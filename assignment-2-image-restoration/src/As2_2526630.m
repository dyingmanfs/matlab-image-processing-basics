%% Q1;
clear all;clc;

I = imread('noisy1.png');

figure; imshow(I); title('noisy1.png Image');
% to find Fourier Spectrum, I made 2D FFT and shifted the zero-frequency component to the center
I_fft = fft2(I);  
I_fft_shifted = fftshift(I_fft); 

% to show better Fourier Spectrum I used LogarithmicTranformations
Fourier_Spectrum = log(1 + abs(I_fft_shifted)); 
figure; imshow(Fourier_Spectrum, []); title('Fourier Spectrum');


% Image dimensions
[M, N] = size(I);                 
uk = 80; vk = 0;
D0 = 25;            % Cut-off frequency
n = 2;              % Filter order (Gaussian exponent)

% Define Notch Filters

    for u=1:M
        for v=1:N
         Dkp(u,v)=((u-(M/2)-uk)^2 + (v-(N/2)-vk)^2 )^(1/2);
         Dkn(u,v)=((u-(M/2)+uk)^2 + (v-(N/2)+vk)^2 )^(1/2);
         end
    end

% Createed notch reject and pass filters
 Hnr = 1 ./ (1 + ((D0 ./ Dkp).^(2 * n))) .* (1 ./ (1 + ((D0 ./ Dkn).^(2 * n))));
 Hnp = 1 - Hnr;
            
figure; imshow(Hnr);title('Notch Reject Filter');
% Filter the image by multiplying the filter with shifted DFT of the image
filtered_fft_shifted = I_fft_shifted .* Hnr;
% Computed the inverse DFT using ifft2 and abs functions
filtered_fft = ifftshift(filtered_fft_shifted); 
I_filtered = ifft2(filtered_fft); 
I_filtered = abs(I_filtered); 
%Convert double to image using uint8 function    
I_filtered_uint8 = uint8(I_filtered); 
figure; imshow(I_filtered_uint8); title('Restored Image');

%to show edges I used sobel filter
%Horizontal Sobel 
Hx = [ -1  0  1;
       -2  0  2;
       -1  0  1 ]; 
%Vertical Sobel 
Hy = [ -1 -2 -1;
        0  0  0;
        1  2  1 ];
Ix = conv2(double(I), Hx, 'same');  
Ix_abs = abs(Ix); 

Iy = conv2(double(I), Hy, 'same');  
Iy_abs = abs(Iy);  
I_F = Ix_abs + Iy_abs;  
figure;
subplot(1, 3, 1); imshow(Ix_abs); title("noisy1.png X Derivative");
subplot(1, 3, 2); imshow(Iy_abs); title("noisy1.png Y Derivative");
subplot(1, 3, 3); imshow(I_F); title("noisy1.png X+Y Derivative");

Ix1 = conv2(double(I_filtered_uint8), Hx, 'same');  
Ix_abs1 = abs(Ix1); 

Iy1 = conv2(double(I_filtered_uint8), Hy, 'same');  
Iy_abs1 = abs(Iy1);  
I_F1 = Ix_abs1 + Iy_abs1;  
figure
subplot(1, 3, 1); imshow(Ix_abs1); title("Restored Image.png X Derivative");
subplot(1, 3, 2); imshow(Iy_abs1); title("Restored Image.png Y Derivative");
subplot(1, 3, 3); imshow(I_F1); title("Restored Image.png X+Y Derivative");
imwrite(I_filtered_uint8, 'recovered1.png');
%% Q2
clear all;clc;
I = imread("noisy2.png");
figure; imshow(I);

% Extract and show the block
block = I(650:858, 876:1048);
figure; imshow(block);

% I can see Uniform Noisy with histogram
figure;imhist(block);
% I used Median Filter to Restored noisy2.png
 f=ordfilt2(I, 5, ones(3,3));


figure; imshow(f); title('Median Filtered Image');
%to show edges I used sobel filter
%Horizontal Sobel 
Hx = [ -1  0  1;
       -2  0  2;
       -1  0  1 ]; 
%Vertical Sobel 
Hy = [ -1 -2 -1;
        0  0  0;
        1  2  1 ];
Ix = conv2(double(I), Hx, 'same');  
Ix_abs = abs(Ix); 

Iy = conv2(double(I), Hy, 'same');  
Iy_abs = abs(Iy);  
I_F = Ix_abs + Iy_abs;  
figure;
subplot(1, 3, 1); imshow(Ix_abs); title("noisy2.png X Derivative");
subplot(1, 3, 2); imshow(Iy_abs); title("noisy2.png Y Derivative");
subplot(1, 3, 3); imshow(I_F); title("noisy2.png X+Y Derivative");

Ix1 = conv2(double(f), Hx, 'same');  
Ix_abs1 = abs(Ix1); 

Iy1 = conv2(double(f), Hy, 'same');  
Iy_abs1 = abs(Iy1);  
I_F1 = Ix_abs1 + Iy_abs1;  
figure
subplot(1, 3, 1); imshow(Ix_abs1); title("Restored Image.png X Derivative");
subplot(1, 3, 2); imshow(Iy_abs1); title("Restored Image.png Y Derivative");
subplot(1, 3, 3); imshow(I_F1); title("Restored Image.png X+Y Derivative");
imwrite(f, 'recovered2.png');

%% 3

clear all;clc;
I = im2double(imread("noisy3.png"));    % Load the degraded image
figure; imshow(I);
% Extract and show the block
block = I(650:800, 876:1000);
figure; imshow(block);
figure;imhist(block);
%histogram is not clear, but thereis  H + noise becuse,We can understand from the image


h = fspecial('motion', 25, 55);         % Define the motion blur filter

% Perform inverse filtering with Wiener deconvolution
estimated_nsr = 0.0001 / var(I(:));
wief = deconvwnr(I, h, estimated_nsr);

% Display the restored image
figure;
imshow(wief);
title('Restored Image');

%to show edges I used sobel filter
%Horizontal Sobel 
Hx = [ -1  0  1;
       -2  0  2;
       -1  0  1 ]; 
%Vertical Sobel 
Hy = [ -1 -2 -1;
        0  0  0;
        1  2  1 ];
Ix = conv2(double(I), Hx, 'same');  
Ix_abs = abs(Ix); 

Iy = conv2(double(I), Hy, 'same');  
Iy_abs = abs(Iy);  
% merged Horizontal and Vertical
I_F = Ix_abs + Iy_abs;  
figure;
subplot(1, 3, 1); imshow(Ix_abs); title("noisy2.png X Derivative");
subplot(1, 3, 2); imshow(Iy_abs); title("noisy2.png Y Derivative");
subplot(1, 3, 3); imshow(I_F); title("noisy2.png X+Y Derivative");

Ix1 = conv2(double(wief), Hx, 'same');  
Ix_abs1 = abs(Ix1); 

Iy1 = conv2(double(wief), Hy, 'same');  
Iy_abs1 = abs(Iy1);  
% merged Horizontal and Vertical
I_F1 = Ix_abs1 + Iy_abs1;  
figure
subplot(1, 3, 1); imshow(Ix_abs1); title("Restored Image.png X Derivative");
subplot(1, 3, 2); imshow(Iy_abs1); title("Restored Image.png Y Derivative");
subplot(1, 3, 3); imshow(I_F1); title("Restored Image.png X+Y Derivative");
imwrite(wief, 'recovered3.png');

%% 4

    clear all;clc;
I = im2double(imread("noisy4.png"));    
figure; imshow(I);

% Extract and show the block

block = I(650:858, 876:1048);
figure; imshow(block);
figure;imhist(block);
%histogram is not clear, but thereis  H + noise becuse,We can understand from the image


h = fspecial('disk',7);         % Define the motion blur filter

% Perform inverse filtering with Wiener deconvolution
estimated_nsr = 0.0001 / var(I(:));
wief = deconvwnr(I, h, estimated_nsr);

% Display the restored image
figure;
imshow(wief);
title('Restored Image');

%to show edges I used sobel filter
%Horizontal Sobel 
Hx = [ -1  0  1;
       -2  0  2;
       -1  0  1 ]; 
%Vertical Sobel 
Hy = [ -1 -2 -1;
        0  0  0;
        1  2  1 ];
Ix = conv2(double(I), Hx, 'same');  
Ix_abs = abs(Ix); 

Iy = conv2(double(I), Hy, 'same');  
Iy_abs = abs(Iy);  
% merged Horizontal and Vertical
I_F = Ix_abs + Iy_abs;  
figure;
subplot(1, 3, 1); imshow(Ix_abs); title("noisy2.png X Derivative");
subplot(1, 3, 2); imshow(Iy_abs); title("noisy2.png Y Derivative");
subplot(1, 3, 3); imshow(I_F); title("noisy2.png X+Y Derivative");

Ix1 = conv2(double(wief), Hx, 'same');  
Ix_abs1 = abs(Ix1); 

Iy1 = conv2(double(wief), Hy, 'same');  
Iy_abs1 = abs(Iy1);  
% merged Horizontal and Vertical
I_F1 = Ix_abs1 + Iy_abs1;  
figure
subplot(1, 3, 1); imshow(Ix_abs1); title("Restored Image.png X Derivative");
subplot(1, 3, 2); imshow(Iy_abs1); title("Restored Image.png Y Derivative");
subplot(1, 3, 3); imshow(I_F1); title("Restored Image.png X+Y Derivative");
imwrite(wief, 'recovered4.png');




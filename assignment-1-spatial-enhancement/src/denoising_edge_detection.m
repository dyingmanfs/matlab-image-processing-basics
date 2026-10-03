clear all;
% to read the noisy image 
Noisy2 = imread("Noisy2.png");
% Apply a 3x3 median filter to reduce noise
Noisy2_F =  medfilt2(Noisy2,[3 3]);
Noisy2_G = Noisy2;
Noisy2_FG = Noisy2_F;
% I created matrix the Sobel operator for horizontal edge detection
Hx = [ -1  0  1;-2  0  2;-1  0  1 ]; 
% I created matrix the Sobel operator for  vertical edge detection
Hy = [ -1 -2 -1; 0  0  0; 1  2  1 ];
% I Applied the horizontal Sobel filter on the noisy image to find edge
Noisy2x = conv2(double(Noisy2_G), Hx, 'same');   
% the absolute value to get Noisy edge magnitudes in horizontal direction
Noisy2x_abs = abs(Noisy2x);
% I Applied the vertical Sobel filter on the noisy image to find edge
Noisy2y = conv2(double(Noisy2_G), Hy, 'same'); 
% the absolute value to get Noisy edge magnitudes in vertical direction
Noisy2y_abs = abs(Noisy2y);
% I Applied the horizontal Sobel filter on the clear image to find edge
Noisy_F2x = conv2(double(Noisy2_FG), Hx, 'same');  
Noisy_F2x_abs = abs(Noisy_F2x);
% I Applied the vertical Sobel filter on the clear image to find edge
Noisy_F2y = conv2(double(Noisy2_FG), Hy, 'same');
Noisy_F2y_abs = abs(Noisy_F2y);
% I merged the vertical Sobel filter and the horizontal Sobel filter on
% Nosiy imgage
Noisy2_E = Noisy2x_abs + Noisy2y_abs;
% I merged the vertical Sobel filter and the horizontal Sobel filter on
% cleare imgage
Noisy2_FE= Noisy_F2x_abs + Noisy_F2y_abs;
% I crearted one figure to show Noisy2.png, Clean2.png, and their edges.
figure;
subplot(2, 2, 1); imshow(Noisy2); title('Noisy2.png');
subplot(2, 2, 2); imshow(Noisy2_F); title('Clean2.png');
subplot(2, 2, 3); imshow(Noisy2_E); title('Edges of Noisy Image');
subplot(2, 2, 4); imshow(Noisy2_FE); title('Edges of Clean Image');

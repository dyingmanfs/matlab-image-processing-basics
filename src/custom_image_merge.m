clear all;
% to read image

I = imread("background.png"); 
I = imresize(I, [128, 128], 'nearest');
H = [0  -1  0; -1  4 -1; 0  -1  0];  
% I cread matrix for Sharpening Spatial Filtering 

B = conv2(double(I), H, 'same');  
B_U = uint8(B);  
% merged filter image and orginal image

I_sharp = I + B_U; 

M = imread("landscape.png"); 
M = imresize(M, [128, 128], 'nearest');
H = [0  -1  0; -1  4 -1; 0  -1  0];  
% I applied Sharpening Spatial Filtering becuse Sharpening is the operation to highlight fine details or enhance the details that has been blurred. 

MF = conv2(double(M), H, 'same');  
MFU = uint8(MF);  
% merged filter image and orginal image

M_sharp = M + MFU; 
Merge = M_sharp + I_sharp;

% merge Moon.png and Image.png
figure;
subplot(1,3,1); imshow(M);
subplot(1,3,2); imshow(I);
subplot(1,3,3); imshow(Merge);

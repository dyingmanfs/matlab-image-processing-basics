clear all; 



% to read image
I = imread("Image.png"); 
% I cread matrix for Sharpening Spatial Filtering 
H = [0  -1  0; -1  4 -1; 0  -1  0];  
% I applied Sharpening Spatial Filtering becuse Sharpening is the operation to highlight fine details or enhance the details that has been blurred. 

B = conv2(double(I), H, 'same');  
B_U = uint8(B);  
% merged filter image and orginal image

I_sharp = I + B_U; 

M = imread("Moon.png"); 
H = [0  -1  0; -1  4 -1; 0  -1  0];  
% I applied Sharpening Spatial Filtering becuse Sharpening is the operation to highlight fine details or enhance the details that has been blurred. 
MF = conv2(double(M), H, 'same');  
MFU = uint8(MF);  
% merged filter image and orginal image
M_sharp = M + MFU; 
% merge Moon.png and Image.png
Merge = M_sharp + I_sharp;

% I created one figure to show all images together. 
figure;subplot(1,3,1); imshow(I);
subplot(1,3,2); imshow(M);
subplot(1,3,3); imshow(Merge);

%% 
% to read the image
A  = imread("Noisy.png");
figure; imshow(A);
subplot(1,2,1);imshow(A);title("Noisy.png"); 
subplot(1,2,2); imhist(A);title("Noisy.png Histogram");


% I applied median filtering to reduce noise
I = medfilt2(A, [15, 15]);
% to save ı use imwrite function
imwrite(I, 'Clean.png');

% to craeted the clean image and its histogram
figure;
subplot(1,2,1);imshow(I);title("Clean.png"); 
subplot(1,2,2); imhist(I);title("Cleadn.png Histogram");


%% I want to apply  thresholding to more clear img but I don't find range
I(I < 100) = 120;

clear all;
clc;
A3_2526630("Plate1.png");
function A3_2526630(inputImage)
    I = imread(inputImage);
    segmentedImage = segmentImage(I);
    eggCount = numberofegg(segmentedImage);
    figure;
    imshow(segmentedImage);
    title(sprintf('Final Segmented Image - Number of Eggs: %.1f', eggCount));
end

function segmentedImage = segmentImage(I)
 % Convert the input RGB image to grayscale
    I = rgb2gray(I);
     % 'graythresh' returns a normalized threshold in the range [0, 1]
    threshold = graythresh(I);

    % Apply the threshold to the grayscale image
    % Convert the threshold to the range [0, 255] for comparison
    % Create a binary image where pixels > threshold are set to 1 (true)
    threshold = graythresh(I);
    thresholdI = I > threshold * 255;
   
    figure;
    subplot(1, 3, 1); imshow(I); title('Original Grayscale Image');
    subplot(1, 3, 2); imshow(thresholdI); title('Thresholded Image');
 
    segmentedImage = thresholdI;
end

function eggCount = numberofegg(I)
eggCount=0;
    % Apply morphological operations to clean the image
    S = strel('disk', 10);   % Increase disk size to combine small regions
    E = imerode(I, S);       % Erosion operation to remove small objects
    F = imfill(E, 'holes');  % Fill holes in the objects




% Set the output image to the original image
OI = I;

% Find the connected components in the binary image
C = bwconncomp(F);

% Get the number of connected components
numComponents = size(C.PixelIdxList, 2);

% Get the number of pixels in each connected component
numPixels = cellfun(@numel, C.PixelIdxList);

% Define minimum and maximum size range
minSize = 30;  % Minimum size 
maxSize = 45; % Maximum size 

for j = 1:numComponents
    if numPixels(j) > minSize && numPixels(j) < maxSize
         eggCount = eggCount + 0.5;
    end
end

% Fill holes of the output image
ImageFilled = imfill(OI, 'holes');

% Plot the results to see all steps together
figure;
subplot(1, 3, 1);
imshow(I);
title('Binary Image', 'FontSize', 8);

subplot(1, 3, 2);
imshow(OI);
title('Filtered by Size Range', 'FontSize', 8);

subplot(1, 3, 3);
imshow(ImageFilled);
title('Imfill', 'FontSize', 8);
   

end
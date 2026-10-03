# MATLAB Image Processing

A collection of MATLAB projects covering fundamental image processing techniques including **spatial enhancement, noise removal, frequency-domain restoration, edge detection, segmentation, and mathematical morphology**.

The projects were developed as part of **CNG466 – Fundamentals of Image Processing** at METU NCC.

## Project Overview

The repository contains three image processing projects:

1. Spatial Image Enhancement
2. Image Restoration and Reconstruction
3. Image Segmentation and Morphology

Together, they demonstrate both spatial-domain and frequency-domain image processing techniques.

## Project Structure

```text
spatial-image-enhancement-matlab/
│
├── assignment-1-spatial-enhancement/
│   ├── src/
│   │   ├── noise_removal.m
│   │   ├── denoising_edge_detection.m
│   │   ├── image_sharpening_merge.m
│   │   └── custom_image_merge.m
│   │
│   └── images/
│       ├── Noisy.png
│       ├── Noisy2.png
│       ├── Image.png
│       ├── Moon.png
│       ├── background.png
│       └── landscape.png
│
├── assignment-2-image-restoration/
│   ├── src/
│   │   └── image_restoration.m
│   │
│   └── images/
│       ├── noisy1.png
│       ├── noisy2.png
│       ├── noisy3.png
│       └── noisy4.png
│
├── assignment-3-segmentation-morphology/
│   ├── src/
│   │   └── egg_segmentation_counting.m
│   │
│   └── images/
│       ├── Plate1.png
│       ├── Plate2.png
│       ├── ...
│       ├── Plate8.png
│       ├── Plate9.png
│       └── Plate10.png
│
├── README.md
└── .gitignore
```

# Assignment 1 – Spatial Image Enhancement

This project focuses on fundamental **spatial-domain image processing techniques**.

## Noise Removal

A noisy grayscale image is processed using median filtering.

The script:

- Loads the noisy image
- Displays the image and histogram
- Applies median filtering
- Saves the cleaned image
- Displays the reconstructed image and histogram

Example:

```matlab
I = medfilt2(A, [15, 15]);
```

## Denoising and Edge Detection

A second noisy image is processed using a **3×3 median filter**.

Sobel operators are then applied to compare edges before and after denoising.

Horizontal Sobel operator:

```text
[-1  0  1
 -2  0  2
 -1  0  1]
```

Vertical Sobel operator:

```text
[-1 -2 -1
  0  0  0
  1  2  1]
```

The output displays:

- Original noisy image
- Filtered image
- Original edge map
- Filtered edge map

## Image Sharpening

Spatial sharpening is implemented using the kernel:

```text
[ 0 -1  0
 -1  4 -1
  0 -1  0 ]
```

The filter is applied using MATLAB's `conv2()` operation.

## Image Merging

Two processed grayscale images are combined after sharpening.

A second experiment repeats the process with a custom image pair resized to:

```text
128 × 128
```

# Assignment 2 – Image Restoration and Reconstruction

This project focuses on identifying and removing different types of image degradation using both **spatial-domain and frequency-domain techniques**.

The original assignment contains four degraded images with different noise or blur characteristics.

## Periodic Noise Removal

The Fourier spectrum of the image is inspected using:

```matlab
fft2()
fftshift()
```

A notch-reject filter is then applied in the frequency domain to suppress periodic noise.

The restored image is reconstructed using:

```matlab
ifftshift()
ifft2()
```

## Noise Filtering

Another noisy image is processed using order-statistic / median-style filtering.

A selected image region is also analyzed using its histogram to investigate the noise characteristics.

## Motion Blur Restoration

Motion blur is modeled using:

```matlab
fspecial('motion', 25, 55)
```

The degraded image is restored using **Wiener deconvolution**:

```matlab
deconvwnr()
```

## Disk Blur Restoration

Another degradation is modeled using a disk-shaped point spread function:

```matlab
fspecial('disk', 7)
```

Wiener deconvolution is again used for restoration.

## Edge Preservation Analysis

Sobel edge detection is applied before and after restoration to inspect whether important edges and boundaries are preserved.

The script automatically generates:

```text
recovered1.png
recovered2.png
recovered3.png
recovered4.png
```

when it is executed.

# Assignment 3 – Image Segmentation and Morphology

This project focuses on **segmenting eggs from breakfast plate images and estimating the total number of eggs**.

The goal is to identify egg regions even when their size, color, and position vary.

## Segmentation

The input RGB image is first converted to grayscale:

```matlab
rgb2gray()
```

An automatic threshold is calculated using:

```matlab
graythresh()
```

The threshold is then used to generate a binary segmented image.

## Mathematical Morphology

Morphological operations are used to clean the segmented image.

The implementation includes:

```matlab
strel()
imerode()
imfill()
```

A disk-shaped structuring element is used for erosion.

## Connected Components

Connected objects are detected using:

```matlab
bwconncomp()
```

The number of pixels in each connected component is analyzed to identify egg regions.

Each detected half egg contributes:

```text
0.5
```

to the total egg count.

For example:

```text
2 half eggs = 1 egg
3 half eggs = 1.5 eggs
```

The final segmented image is displayed together with the calculated number of eggs.

# Techniques Used

- Median Filtering
- Order-Statistic Filtering
- Spatial Filtering
- 2D Convolution
- Histogram Analysis
- Sobel Edge Detection
- Image Sharpening
- Fourier Transform
- Frequency-Domain Filtering
- Notch Reject Filtering
- Wiener Deconvolution
- Motion Blur Modeling
- Disk Blur Modeling
- Otsu Thresholding
- Image Segmentation
- Mathematical Morphology
- Erosion
- Hole Filling
- Connected Component Analysis

# Technologies

- MATLAB
- MATLAB Image Processing Toolbox
- Digital Image Processing
- Spatial-Domain Processing
- Frequency-Domain Processing

# Running the Projects

Open MATLAB and navigate to the desired project directory.

For example:

```text
assignment-1-spatial-enhancement/src/
```

or:

```text
assignment-2-image-restoration/src/
```

Make sure the required images are available at the paths expected by the MATLAB scripts.

For Assignment 3, the segmentation function can be called with an image:

```matlab
egg_segmentation_counting("Plate8.png")
```

# Academic Context

These projects were developed as part of:

**CNG466 – Fundamentals of Image Processing**

at **METU NCC Computer Engineering**.

The projects demonstrate a progression from basic spatial image enhancement to frequency-domain restoration and image segmentation with morphology.

# Author

**Furkan Sağlam**

## Keywords

`MATLAB` `Image Processing` `Computer Vision` `Median Filter` `Sobel` `FFT` `Wiener Filter` `Image Restoration` `Segmentation` `Morphology` `Otsu Thresholding`

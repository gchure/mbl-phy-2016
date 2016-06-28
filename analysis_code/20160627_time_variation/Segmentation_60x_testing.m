%This script will check the robustness of my segmentation functions on 63 x
%data.
im = imread('~/Desktop/aK_ECE174-Pveg-YFP_plas0_60x_t120_pos4_C01_ORG.tif');

%Define the interpixel distance.
ipDist = 0.1 %in microns per pixel.
areaBounds = [0.5/ipDist^2, 4/ipDist^2];
eccBounds = [0.7, 1.0];

imSeg = LogSegmentation(im, areaBounds, eccBounds);

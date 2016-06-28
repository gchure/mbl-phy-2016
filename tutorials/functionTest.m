%This script is intepnded to test various functions for doing photobleaching
%analysis in MATLAB.
close all 
clear all
%Start by loading some test images. 
testDir = '~/Desktop/test_data/';
mchPat = '*mch*.tif';
bfPat = '*bf*.tif';
seqPat = '*seq*.tif';

%See if we can list all of the files in this directory correctly.
files = dir(testDir);

%Load the dir list of all of those above.
mchFile = dir([testDir mchPat]);
bfFile = dir([testDir bfPat]);
seqFile = dir([testDir seqPat]);

%Load up the mCherry image.
imRFP = imread([testDir mchFile.name]);

%Test our Laplacian of Gaussian log filter.
%imSeg = LogSegmentation(imRFP);

%Test the distance filter.
D = 0.5 / 0.063;
%imDist = DistanceFilter(imSeg, D);

f = figure(1);
p = plot(randn(100000,1), '.');
FormatAxes(f)



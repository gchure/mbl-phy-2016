function imSeg = LogSegmentation(im, A)
%LOGSEGMENTATION Perform Laplacian of Gaussian segmentation algorithm over a
%field of bacterial cells. 
% 	imSeg = LOGSEGMENTATION(im) segments im removing objects smaller than
% 		100 pixels
%	imSeg = LOGSEGMENTATION(im, A) segments im removing objects smaller
%		than N pixels.

%Ensure that the image is normalized.
if max(max(im)) > 1
	im = mat2gray(im);
end

%Instantiate the edgefinder function.
imEdge = edge(im, 'log');

%Fill the holes in the edge image.
imFill = imfill(imEdge, 'holes');

%Remove the small stuff by determing the number of inputs.
if nargin < 2
	A = 100;
end
imFilt = bwareaopen(imFill, A, 4);

%Dilate the objects by 2px.
selem = strel('diamond', 1);
imDil = imdilate(imFilt, selem);

%Remove objects touching the border and label the output image.
imSeg = imclearborder(imDil, 4); %Buffer of 4px.
imSeg = bwlabel(imSeg);
end




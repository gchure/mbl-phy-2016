function imSub = BgSubtract(im, radius)
%This function will perform a gaussian blur and subtract the blurred image
%from the original image.
%
%Parameters
%----------
%im : 2d-matrix (image)
%   The image that is to be processed. 
%radius : float
%   The radius of the gaussian blur to be applied
%
%Returns
%-------
%imSub : 2d-matrix (image)
%   Final subtracted image
% 

%Check that the image is normalized.
if max(max(im)) > 1
    im = mat2gray(im)
end

%Now the image is normalized, we'll apply the gaussian blur. 
imGauss = imgaussfilt(im, radius);

%Perform the subtraction. 
imSub = im -imGauss

end


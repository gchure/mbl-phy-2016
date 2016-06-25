function mergedIm = ExampleSegmentation(S, B, L)
% EXAMPLESEGMENTATION creates an RGB image where segmented objects are
% highlighted in blue over a source image.
%	mergedIm = EXAMPLESEGMENTATION(S, B, L) displays the segmented objects
%	in mask S over the base image B in light blue with a scale bar of
%	length L burned into the upper left-hand corner.

% Convert the base image to a float and make a copy.
imFloat = mat2gray(B);
imCopy = imFloat;

% Round the bar length.
barLength = round(L);
% Add a scale bar to the images.
imCopy(20:30, 20:20 + barLength) = 1.0;
imFloat(20:30, 20:20 + barLength) = 1.0;

% Color wherever there are objects 0.5
imCopy(S > 0) = 0.5;

%Concatenate the objects.
mergedIm = cat(3, imFloat, imCopy, imCopy);
end

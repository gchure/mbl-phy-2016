function imFilt = DistanceFilter(im, D)
% DISTANCE FILTER Removes objects that are within a given distance.
% 	imFilt = DISTANCEFILTER(im,D) removes all objects that are within a
% 	distance D of each other. D is in units of pixels.

%Ensure that the provided distance is an integer.
if isinteger(D) ~= 1
	D = round(D);
end

%Get the shape of the image.
imSize = size(im);

%Iterate a square of edge length D over the image and find the unique values.
approvedLabels = [];
for i=1:(imSize(1) - D)
    for j=1:(imSize(2) - D)
	%Slice the region of the image we are interested in.
	imSlice = im([i:(i+D)], [j:(j+D)]);
	
	%Find all of the unique labels.
	uniqueLabels = unique(imSlice);

	%Approved objects will only have two unique labels
	if length(uniqueLabels) > 2
 	   approvedLabels = [approvedLabels uniqueLabels];
	   disp(approvedLabels)
	end
    end
end
approvedLabels = unique(approvedLabels);

%Make an empty image the same size of our original image.
imFilt = zeros(imSize);

%iterate through the approved labels. 
for i=1:max(max(im))
    if sum(i == approvedLabels) == 0
        imFilt = imFilt + (im==i);
    end
end
end

	

function bleachStruct = CompleteBleachProcess(S, P, D, I, T, C)
% COMPLETEBLEACHPROCESS executes a series of operations over an image
% containing fluorescent cells yielding a structure containing information
% about each cell.
% 	bleachStruct = COMPLETEBLEACHPROCESS(S, I, T, C) performs Laplacian of
% 	Gaussian segmentation over image S, removes objects outside of a area
% 	range of 0.5 to 4 square microns which is determined using the
% 	interpixel distance P, and applies a distance filter where
% 	all objects within a distance D of eachother are removed. The resulting
% 	segmentation mask is then used to extract the bleaching trajectories of
% 	a cell of intensity images I. The value at which each bleaching
% 	trajectory reaches a threshold T is determined and is folded into a
% 	structure containing information regarding the cell's DNA concentration
% 	C. 

% Generate the area bounds.
areaBounds = [(0.5 * P^2), (4 * P^2)];
eccBounds = [0, 0.7];

% Segment the image.
imSeg = LogSegmentation(S);

% Compute the region props and remove objects outside of area and ecc bounds.
props = regionprops(imSeg, 'Area', 'Eccentricity');
cellAreas = [props.Area];
ecc = [props.Eccentricity];

% Find the approved cells without looping.
approvedAreas = (cellAreas > areaBounds(1)) & (cellAreas < areaBounds(2));
approvedEccs = (ecc > eccBounds(1)) & (ecc < eccBounds(2));
approvedCells = approvedAreas .* approvedEccs;
approvedLabels = find(approvedCells);

% Make a new segmentation image.
segIm = zeros(size(imSeg));
for i=1:approvedLabels
    segIm = segIm + imSeg==approvedLabels(i);
end

% Pass the new segmentation image through the distance filter.
imFilt = DistanceFilter(segIm, 1.0 / P);

% Compute the photobleaching trajectories.
bleachTraj = ExtractBleachTrajectories(imSeg, I);

%Find the decay times.
decayVec = ExtractDecayTimes(bleachTraj, T);

%Generate and return the struct.
field1 = 'concentration';
value1 = ones(size(decayVec)) * C;
field2 = 'DecayTime';
bleachStruct = struct(field1, value1, field2, decayVec);

end

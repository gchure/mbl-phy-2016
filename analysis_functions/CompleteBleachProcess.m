function [bleachTable,  bleachTraj] = CompleteBleachProcess(S, P, D, I, T, C)
% COMPLETEBLEACHPROCESS executes a series of operations over an image
% containing fluorescent cells yielding a table containing information
% about each cell.
% 	bleachTable = COMPLETEBLEACHPROCESS(S, P, D, I, T, C) performs Laplacian of
% 	Gaussian segmentation over image S, removes objects outside of a area
% 	range of 0.5 to 4 square microns which is determined using the
% 	interpixel distance P, and applies a distance filter where
% 	all objects within a distance D of eachother are removed. The resulting
% 	segmentation mask is then used to extract the bleaching trajectories of
% 	a cell of intensity images I. The value at which each bleaching
% 	trajectory reaches a threshold T is determined and is folded into a
% 	table containing information regarding the cell's DNA concentration
% 	C. 

% Generate the area bounds.
areaBounds = [(0.5 / P^2), (4 / P^2)];
eccBounds = [0.7, 1.0];

% Segment the image.
imSeg = LogSegmentation(S, areaBounds, eccBounds);

% Pass the new segmentation image through the distance filter.
%imFilt = DistanceFilter(imSeg, 1.0 / P);

% Compute the photobleaching trajectories.
bleachTraj = ExtractBleachTrajectories(imSeg, I);

%Find the decay times.
decayTimes = ExtractDecayTimes(bleachTraj, T);

%Generate and return the struct.
concentration = ones(size(decayTimes.')) * C;
decay_times = decayTimes.';
bleachTable = {decay_times};


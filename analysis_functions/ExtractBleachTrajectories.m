function bleachMat = ExtractBleachTrajectories(S, I)
% EXTRACTBLEACHTRAJCTORIES Computes photobleching trajectories over a list of
% supplied images.
%	bleachMat = EXTRACTBLEACHTRAJECTORIES(S, I) generates a matrix of
%	bleaching trajectories of shape numCells by time. These data are
%	smoothed using a Savitzky-Golay filter and are rescaled from 0 to 1.0.
matMeans = [];
se = [ 0, 1, 0;
       1, 1, 1;
       0, 1, 0;]; 
for i=1:length(I)
    %Apply a median filter over all images
    imFilt = medfilt2(I{i});
    
    %Extract the region props.
    props = regionprops(S, imFilt, 'MeanIntensity');
    means = [props.MeanIntensity];
    %Save them in a new vector
    for j=1:length(means)
        matMeans(j,i) = means(j);
    end
end

%Iterate through each and smooth it using the savitzy-golay filter
matFilt = sgolayfilt(matMeans, 2, 5);

%Renormalize each one to the min and max of the column.
matSize = size(matFilt);
for i=1:matSize(1)
    bleachMat(i,:) = (matFilt(i,:) - min(matFilt(i,:))) /...
    (max(matFilt(i,:)) - min(matFilt(i,:)));
end
end

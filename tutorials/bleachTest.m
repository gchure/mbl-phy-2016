%Define the data directories.
dataDir = '~/Desktop/test_data/';
bleachFiles = dir([dataDir 'seq*.tif']);
bfFiles = dir([dataDir 'bf*.tif']);
segFiles = dir([dataDir 'mch*.tif']);

%load the bleach images.
for i=1:length(bleachFiles)
	intIms{i} = imread([dataDir bleachFiles(i).name]);
end
ipDist = 0.065;
areaBounds = [(0.5/ipDist^2), (4/ipDist^2)];
eccBounds = [0.5, 1.0];
%Segment using laplacian of Gaussian.
imRFP = imread([dataDir segFiles(1).name]);
imSeg = LogSegmentation(imRFP, areaBounds, eccBounds);
imBF = imread([dataDir bfFiles(1).name]);

%Make a merge.
merge = ExampleSegmentation(imSeg, imBF, 10/0.065);
%%Apply the distance filter.
minDist = 1/0.065;
ipDist = 0.065;
%imDist = DistanceFilter(imSeg, minDist);
%
%Extract the trajectories.
bleachTraj = ExtractBleachTrajectories(imSeg, intIms);

%Plot them all together.
f = figure()
matSize = size(bleachTraj);
time = 0:1:5;
for i=1:matSize(1)
plot(time, bleachTraj(i,:), 'x--')
hold on;
end 
xlabel = 'Time (frames)';
ylabel = 'Normalized Intensity';
hold off;
FormatAxes(f);

% Try running the whole functionm.
%thresh = exp(-1);
%minDist = 1 ;
%ipDist = 0.065;
%[bleachTable, bleachTraj] = CompleteBleachProcess(imRFP, ipDist, minDist, intIms, thresh, 0);

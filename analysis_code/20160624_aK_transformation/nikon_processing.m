%This script generates the photobleaching decay times vs concentration table
%for the transformation experiment imaged on the widefield microscope at MBL
%Physiology 2016.
%Start by defining the data directory.
dataDir = '/Volumes/gdc_data_2/20160624_zeiss/';

%Define the interpixel distance and min distance.
ipDist = 0.065;
areaBounds = [0.5*ipDist^2, 4*ipDist^2];
eccBounds = [0.7, 1.0];
minDistance = 1;

%Set up the different concentrations.
concs = [0 1 2 3];
decayTimes = {};
decayTraj = {};
for i=1:length(concs)
    disp(['Beginning concentration ' num2str(i) ' of ' num2str(length(concs))])
    %Start by loading the RFP images for segmenatation.
    segDirNames = dir([dataDir 'aK*plas' num2str(concs(i)) '*C01*.tif']);
    segNames = {segDirNames.name};
    intDirNames = dir([dataDir 'aK*plas' num2str(concs(i)) '*T*C02*.tif']);
    intNames = {intDirNames.name};
    intSlices = 1:250:length(intNames);
    %Iterate through each image set.
    for j=1:length(segNames);
	disp(['Processing position ' num2str(j) ' of '...
	num2str(length(segNames))]);
	%Read the segmentation image.
	segIm = imread([dataDir segNames{j}]);
	if j==length(intSlices);
	    relevantInts = {intNames{intSlices(j):length(intNames)}};
	else
	    relevantInts = {intNames{intSlices(j):(intSlices(j+1) - 1)}};
        end
        
	%Load up the intensity images.
	intIms = {};
	for k=1:length(relevantInts)
		nom = relevantInts{k};
		if k==1
		    intIms{k} = imread([dataDir nom]);
		else
		    intIms{k} = imread([dataDir nom]);
		end
	end
	
	%Extract the decay times.
	[bleachTable, bleachTraj] = CompleteBleachProcess(segIm, ipDist,...
	minDistance,intIms, exp(-1), concs(i));

	%Figure out how to merge the table.
    	if j==1
	    decayTimes{i} = bleachTable;
	    dataTraj{i} = bleachTraj;
	else
	    decayTimes{i} = vertcat(decayTimes{i}, bleachTable);
	    dataTraj{i} = vertcat(dataTraj{i}, bleachTraj);
        end
end
end
figure()
for i=1:length(dataTraj)
selData = dataTraj{i};
for j=1:length(selData)
	plot(1:1:250, selData(j), 'b.')
	hold on;
end
end

%%For Parsing Nikon data.
%%I will need to be clever with parsing the correct ones.
%names = {dirList.name};
%lens = cellfun('length', names);
%lens = lens - min(lens);
%indices = find(lens ==0);
%segChannels = names(indices);
%
%%I can do this in a more clever fashion.
%dataDir = '/Volumes/gdc_data_2/20160624/';
%
%segs = {};
%bleaches = {};
%for i=1:1:35
%	if i < 10
%		point = '*Point000';
%	else
%		point = '*Point00';
%	end
%
%    files = dir([dataDir point num2str(i) '*.tif']);
%    names = {files.name};
%    posSegs = {};
%    posInts = {};
%    for j=1:length(names)
%	if length(strfind(names(i), '*c2.tif')) ~= 0
%		posSegs = [posSegs names(i)];
%	elseif length(strfind(names(i), '*Seq0*t*c1.tif')) ~=0
%		posInts = [posInts names(i)];
%	end
%end
%end
%
%
%
%	
%
%%%I want them in batches of two.
%%firstChannels = {};
%%j=1;
%%for i=1:(length(segChannels) - 2)
%%	if mod(i,2)==1
%%		firstChannels{j} = segChannels{j:j+1};
%%		j = j+1;
%%	end
%%end
%%
%%%Goddamn that was annoying. Okay, so now I have all of the segmentation
%%%channels I need.
%%j = 1;
%%segChannels = {}
%%for i=1:length(firstChannels)
%%	if mod(i,2) == 0
%%		segChannels{j} = firstChannels{i};
%%		j = j +1;
%%	end
%%end
%%
%%%Split the names up into reasonable units.
%

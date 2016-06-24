%This script processes the data from an aK transformation experiment performed
%and analyzed via FACS on June 22, 2016. 

%Start by loading up the csv file.
data = csvread('../data_files/20160622_FACS/20160622_aK_FACS_data.csv', 1);

%Define the concentrations 
concs = [0 10, 100, 1000, 10000, 100000];

%Slice the data
rfpVals = [];
close all

f = figure(1)
for i=1:length(concs)
    %Select the data. 
    selConc = data(:,1)==concs(i);

    %Extract the values.
    yfpVals = data(selConc, 2);
    
    %Get the hist and bins.
    [h, b] = hist(yfpVals, 1000);
    h = h ./ sum(h);
    %Generate the plot.
    plot(b,h);
    ax = gca;
    hold on;
end



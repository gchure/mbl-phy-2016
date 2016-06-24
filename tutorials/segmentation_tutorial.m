%This script will serve as a tutorial for more advanced segmentation
%techniques.
%Name: Griffin Chure
%Date: 20160621

%Practice some math. 
a = 2;
b = 10;
c = 2.23;

%Simple addition and subtraction
d = a + b; %Should be 12
e = b - a; %Should be 8
f = b / c; %Should be 4.48is


%Now try some matrix mathematics. 
matOne = [1 0; 0 1];
matTwo = [0 1; 1 0];

dotProd = matOne * matTwo;
mult = matOne .* matTwo;


multzeros = zeros(a, b);
multones = ones(a, b) * 5;

randNums = rand(a,b);


%Test MATLABs random number generators. 
uniform = rand(1000,1);

figure(1)
hist(uniform, 100, 'b')
xlabel('random integer')
ylabel('counts')

figure(2)
gauss = randn(1000, 1)
hist(gauss, 100, 'g') 



%% Basic image processing

%Remind ourselves how to load up images and define directories. 
dataDir = '/Volumes/GDC_DATA_2/20160406/exp_1/';
rfpDir = dir([dataDir '*plas4_0/*MCherry*.tif']);
bfDir = dir([dataDir '*plas4_0/*Brightfield*.tif']);

%Load in my mCherry and brightfield images
rfpIm = imread([rfpDir.folder '/' rfpDir.name]);
bfIm = imread([bfDir.folder '/' bfDir.name]);
% 
% figure(2)
% imshow(bfIm, [])


%Create a gaussian filter. 
gaussFilter = fspecial('gaussian', 100 ,100);
bfBlur = imgaussfilt(bfIm, 10);
imSub = bfIm - bfBlur;
imNorm = mat2gray(imSub);
imshow(imNorm, [])


%
%Load an example image.
mchIm = imread('~/Desktop/test_data/mch_test.tif');

%Slice out a particular cell.
cellSlice = mchIm(200:270, 89:162);
lineProfile = cellSlice(35,:);
typecast(lineProfile, 'int16');

%Convert to a float and compute the derivatives
deriv1 = diff(lineProfile);
deriv2 = diff(deriv1);
close all
f = figure(1);
x = 1:1:length(lineProfile);
x1 = 1:1:(length(x) -1);
x2 = 1:1:(length(x1) -1);
plot(x, lineProfile);
hold on;
plot(x1, deriv1);
plot(x2, deriv2);
legend(['original', 'first derivative', 'second derivative']);
xlabel('x position');
ylabel('rescaled value');
FormatAxes(f);
hold off;


%% Run previous solution script

PlotResults_4_ass3


%% load kronan
im1=imread('kronan1.JPG');
im2=imread('kronan2.JPG');

close all

%% construct levenberg-Maquardt improvement method

P={P1,P_2{2}}

%calculate the projection error
[err,red]=ComputeReprojectionError(P,U,U(:,end))
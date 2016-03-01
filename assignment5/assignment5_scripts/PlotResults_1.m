%% Run previous solution script

PlotResults_4_ass3


%% load kronan
im1=imread('kronan1.JPG');
im2=imread('kronan2.JPG');

close all
clc;

%% Initialize Levenberg-Maquardt improvement method

P={P1,P_2{2}};
u=xtilde;
U=X{2};

lambda = 1;
iterations = 300;
err=zeros(iterations,1);

[~,initial_res] = ComputeReprojectionError(P,U,u);
figure;
histogram(initial_res,100);
title('Initial residue distribution')

% Compute Levenberg-Maquardt improvement method
for i=1:iterations
[err(i),res]=ComputeReprojectionError(P,U,u);
[r,J] = LinearizeReprojErr(P,U,u);
C = J'*J+lambda*speye(size(J,2));
c = J'*r;
deltav = - C\c;
[P,U] = update_solution(deltav,P,U);
end
figure;
histogram(res,100);
title('Final residue distribution')
figure;
plot(1:iterations,err)
title('Total error as function of iteration');
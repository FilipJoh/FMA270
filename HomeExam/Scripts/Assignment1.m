%% create matrices 
P=[1 2 0 4; 1 0 2 1; 0 2 2 1];
X1=[1 2 2 1]';
X2=[2 -1 0 1]';

%Compute camera center principal axis
C1=pflat(null(P));
PrinAx=P(end,:);

%Project points
x1=P*X1
x2=P*X2
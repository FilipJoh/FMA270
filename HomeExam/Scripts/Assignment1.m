%% create matrices 
P=[1 2 0 4; 1 0 2 1; 0 2 2 1];
X1=[1 2 2 1]';
X2=[2 -1 0 1]';

%Compute camera center principal axis
C1=pflat(null(P));
PrinAx=P(end,:);

%Project points
x1=P*X1%pflat(P*X1)
x2=P*X2%pflat(P*X2)

%check if projected points are in front of the camera

test1=PrinAx*(X1-C1)
test2=PrinAx*(X2-C1)


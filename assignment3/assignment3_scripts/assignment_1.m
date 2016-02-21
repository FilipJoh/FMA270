%% create camera matrices and subdivide
P1=[eye(3) zeros(3,1)];
P2=[1 1 0 0; 0 2 0 2; 0 0 1 0];
t=P2(:,end);
A=P2(:,1:3);

%get camera centers
C1=null(P1);
C2=null(P2);
C2=C2./C2(end);

%compute epipoles
e2=P2*C1;
e1=P1*C2;

%compute crossmatrix for [e2]x
e2x=createCrossMatrix(e2);

%create Fundamental Matrix
F=e2x*A

x=cell(4,1);
%create image points for first image
x{1}=[1;1;1];
x{2}=[2;0;1];
x{3}=[2;1;1];
x{4}=[4;2;1];

%create epiloar lines for each points in camera 2
l=cell(4,1);
for i=1:4
    l{i}=F*x{i};
    l{i}=pflat(l{i});
end

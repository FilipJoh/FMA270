%% load in data

load('compEx3data.mat');
im1=imread('cube1.jpg');
im2=imread('cube2.jpg');

%% plot 3D Points

figure;
plot3(Xmodel(1,:),Xmodel(2,:),Xmodel(3,:),'.b','Markersize',10)
hold on;
plot3 ([Xmodel(1,startind);Xmodel(1,endind)],[Xmodel(2,startind);Xmodel(2,endind)],[Xmodel(3,startind);Xmodel(3,endind)],'b-');
axis equal
hold off;

%% construct N

meanx1=mean(x{1}(1:2,:),2);
std1=std(x{1}(1:2,:),0,2);
meanx2=mean(x{2}(1:2,:),2);
std2=std(x{2}(1:2,:),0,2);

N1=[1/std1(1) 0 -meanx1(1)/std1(1); 0 1/std1(2) -meanx1(2)/std1(2); 0 0 1];
N2=[1/std2(1) 0 -meanx2(1)/std2(1); 0 1/std2(2) -meanx2(2)/std2(2); 0 0 1];


%% Normalize Points

xtilde1=N1*x{1};
xtilde2=N2*x{2};

%% Plot normalized points

figure;
plot(x{1}(1,:),x{1}(2,:),'.g');
axis equal


figure;
plot(xtilde1(1,:),xtilde1(2,:),'.b');
axis equal

figure;
plot(xtilde2(1,:),xtilde2(2,:),'.r');
axis equal

%% set up DLT

M1=createM(Xmodel,xtilde1);
M2=createM(Xmodel,xtilde2);

% M=zeros(size(Xmodel,2)*3,4*3+size(Xmodel,2));
% for i=1:size(Xmodel,2)
% M(3*(i-1)+1,1:4)=[Xmodel(:,i);1]';
% M(3*(i-1)+2,5:8)=[Xmodel(:,i);1]';
% M(3*i,9:12)=[Xmodel(:,i);1]';
% M(3*(i-1)+1:3*i,12+i)=-xtilde1(:,i);
% end


%% solve using svd
[U1,S1,V1]=svd(M1);
v1=V1(:,end)

[U2,S2,V2]=svd(M2);
v2=V2(:,end)

D1=S1'*S1;
D1(end)

D2=S2'*S2;
D2(end)

norm(M1*v1)
norm(M2*v2)
%% create P matrices project points

P1=N1\reshape(-v1(1:12),[4 3])';
P2=N2\reshape(-v2(1:12),[4 3])';

projPoints1=pflat(P1*([Xmodel;ones(1,size(Xmodel,2))]))
projPoints2=pflat(P2*([Xmodel;ones(1,size(Xmodel,2))]))



%% plot result

figure;
plot3(Xmodel(1,:),Xmodel(2,:),Xmodel(3,:),'.b','Markersize',10)
hold on;
plot3 ([Xmodel(1,startind);Xmodel(1,endind)],[Xmodel(2,startind);Xmodel(2,endind)],[Xmodel(3,startind);Xmodel(3,endind)],'b-');
axis equal

plotcams({P1, P2})
hold off;

figure;
imshow(im1)
hold on;
plot(projPoints1(1,:),projPoints1(2,:),'+b','Markersize',10)
plot(x{1}(1,:),x{1}(2,:),'+g','Markersize',10)
hold off;

figure;
imshow(im2)
hold on;
plot(projPoints2(1,:),projPoints2(2,:),'+b','Markersize',10)
plot(x{2}(1,:),x{2}(2,:),'+g','Markersize',10)
hold off;


%% RQ-factorize 
[K,R]=rq(P1)


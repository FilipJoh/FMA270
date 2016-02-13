%% load data
load('assignment2data/compEx1data.mat');


%% contruct plot for an image
ImageNbr=1;
points=x{ImageNbr};
projPoints=X;
Pproj=P{ImageNbr};

projPoints=Pproj*projPoints;

projPoints=pflat(projPoints);
% for i=1:size(projPoints,2)
%     if ~isnan(points(:,i))
%        projPoints(:,i)=projPoints(:,i)./projPoints(end,i);
%     else
%        projPoints(:,i)=NaN; 
%     end
% end
im=imread(imfiles{ImageNbr});
visible=isfinite(x{ImageNbr}(1,:));


figure;
imshow(im);
hold on
plot(points(1,:),points(2,:),'+b','Markersize',5)
plot(projPoints(1,visible),projPoints(2,visible),'or','Markersize',5)
title('image points and projected points')
hold off

%% Construct 3d-plot
figure;
plot3(X(1,:),X(2,:),X(3,:),'.b','Markersize',2)
hold on
plotcams(P)
% hold off
grid on
title('3D reconstruction')
axis equal

%% create and apply T1

T1=[1 0 0 0; 0 4 0 0; 0 0 1 0; 1/10 1/10 0 1]
XT1=T1\X; %inv(T1)*X

XT1=pflat(XT1);

%plot 3d model
figure;
plot3(XT1(1,:),XT1(2,:),XT1(3,:),'.b','Markersize',2)
hold on
PT1={};
for i=1:9 
   PT1{i}=P{i}*T1; 
end
plotcams(PT1)
hold off
axis equal
xlabel('X')
ylabel('Y')
zlabel('Z')
grid on
title('3D reconstruction, T1 applied')
axis([-4 13 -2 8 0 50])
%% create and apply T2

T2=[1 0 0 0; 0 1 0 0 ; 0 0 1 0 ; 1/16 1/16 0 1]
XT2=T2\X; %inv(T2)*X
XT2=pflat(XT2);

%plot 3d model
figure;
plot3(XT2(1,:),XT2(2,:),XT2(3,:),'.b','Markersize',2)
hold on
PT2={};
for i=1:9 
   PT2{i}=P{i}*T2; 
end
plotcams(PT2)
hold off
axis equal
xlabel('X')
ylabel('Y')
zlabel('Z')
grid on
title('3D reconstruction, T2 applied')
axis([-4 13 -2 15 0 50])

%% Project 3d points to camera

projT1=PT1{ImageNbr}*XT1;
projT1=pflat(projT1);

figure;
imshow(im);
hold on
%plot(points(1,:),points(2,:),'+b','Markersize',5)
plot(projPoints(1,visible),projPoints(2,visible),'or','Markersize',5)
plot(projT1(1,visible),projT1(2,visible),'+b','Markersize',5)
hold off
title('projected points 3D points with and without T applied')
%likewise for T2


%% Solve Comp ex2

[K1,RT1]=rq(PT1{1});
K1=K1./K1(3,3)

[K2,RT2]=rq(PT2{1});
K2=K2./K2(3,3)


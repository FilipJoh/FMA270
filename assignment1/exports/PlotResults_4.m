%% load in data
im1=imread('compEx4im1.jpg');
im2=imread('compEx4im2.jpg');
load('compEx4.mat');

%% Compute centerpositions and camera center axes in R3

%Solving the individual components of the camera matrices.
[K1,R1,t1]=RQ(P1);
[K2,R2,t2]=RQ(P2);

% The last row of the camera matrices specifies the transformation of the
% the world Z-axis the the pricipal axis of the camera, thus the last row
% is the pricipal axis.
T1=P1(end,1:3);
T2=P2(end,1:3)

%Normalize vectors
T1=T1./norm(T1);
T2=T2./norm(T2);

% Null space of P means the point in R3 that gives (0,0,0) in the
% image coordinate space, but I could be wrong. At least it looks decent
% when we plot the points with U. 
cp1=null(P1);
cp2=null(P2);
cp1=cp1(1:3)./cp1(end);
cp2=cp2(1:3)./cp2(end);

%% Plot U-points in 3D
[Points,~]=transformPoints(U,zeros(4,size(U,2)),eye(4));
figure;
grid on
plot3(Points(1,:),Points(2,:),Points(3,:),'.b','Markersize',2)


%% Plot camera Points
hold on;
plot3(cp1(1),cp1(2),cp1(3),'+r','Markersize',20)
quiver3(cp1(1),cp1(2),cp1(3),T1(1),T1(2),T1(3),15,'r')
plot3(cp2(1),cp2(2),cp2(3),'+r','Markersize',20)
quiver3(cp2(1),cp2(2),cp2(3),T2(1),T2(2),T2(3),15,'r')
grid on
hold off;
axis equal;


%% Transform 3d points to images and plot
PointsP1=P1*U;
PointsP2=P2*U;
for i=1:length(U)   
   PointsP1(:,i)=PointsP1(:,i)./PointsP1(end,i);
   PointsP2(:,i)=PointsP2(:,i)./PointsP2(end,i);
end

figure;
imshow(im1)
hold on;
plot(PointsP1(1,:),PointsP1(2,:),'.g','Markersize',2);
hold off;

figure;
imshow(im2)
hold on;
plot(PointsP2(1,:),PointsP2(2,:),'.g','Markersize',2);
hold off;

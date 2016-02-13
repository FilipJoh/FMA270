%Load data
load('assignment1data/compEx1.mat');

%calculate cartesian coordinates for x2D
endPoint=63;
cartesian=zeros(3,endPoint);
for i=1:endPoint
    cartesian(:,i)=pflat(x2D(:,i));
end

%plot cartesian coordinates for x2D
figure;
plot(cartesian(1,:),cartesian(2,:),'b+');
grid on;
title('cartesian coordinates of x2D')
xlabel('x-value')
ylabel('y-value')
axis equal

%calculate cartesian coordinates for x3D
endPoint=441;
cartesian=zeros(4,endPoint);
for i=1:endPoint
    cartesian(:,i)=pflat(x3D(:,i));
end

%plot cartesian coordinates for x3D
figure;
plot3(cartesian(1,:),cartesian(2,:),cartesian(3,:),'b+');
grid on;
title('cartesian coordinates of x3D')
xlabel('x-value')
ylabel('y-value')
zlabel('z-value')
axis equal



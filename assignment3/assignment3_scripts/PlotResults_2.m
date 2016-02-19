%% run plotResults_1

PlotResults_1

%% construct P matrices

P1=[eye(3) [0 0 0]'];
P1tilde=N1*P1;

e2=null(F')
e2x=[0 -e2(3) e2(2); e2(3) 0 -e2(1); -e2(2) e2(1) 0];


P2=[e2x*F e2];
P2tilde=N2*P2;


%% Triangulate

X=zeros(4,length(x{1}));
for i=1:length(x{1})
  M=[P1tilde -[xtilde{1}(:,i)] [0 0 0]' ; P2tilde [0 0 0]' -[xtilde{2}(:,i)]]; 
  [U,S,V]=svd(M);
  v=V(:,end);
  X=[X v(1:4,:)];
end
X=pflat(X);
figure;
plot3(X(1,:),X(2,:),X(3,:),'.b','Markersize',2);
hold on;
plotcams({P1})
grid on;
axis equal
xlabel('x')
ylabel('y')
zlabel('z')
hold off;
title('Reconstructed 3D-Points aswell as provided 3D-points')
axis equal;



% create Projections
xproj1 = pflat(P1*X );
xproj2 = pflat(P2*X );

figure;
imshow(im1);
hold on;
plot(xproj1(1,:),xproj1(2,:),'+g');
plot(x{1}(1,:),x{1}(2,:),'ro');

hold off;
legend('projected points','image feature points')




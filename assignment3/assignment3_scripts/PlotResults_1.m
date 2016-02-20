%% load data

load('CompEx1data');
im1=imread('kronan1.jpg');
im2=imread('kronan2.jpg');

%% construct N1 and N2

meanx1=mean(x{1}(1:2,:),2);
std1=std(x{1}(1:2,:),0,2);
meanx2=mean(x{2}(1:2,:),2);
std2=std(x{2}(1:2,:),0,2);

N1=[1/std1(1) 0 -meanx1(1)/std1(1); 0 1/std1(2) -meanx1(2)/std1(2); 0 0 1];
N2=[1/std2(1) 0 -meanx2(1)/std2(1); 0 1/std2(2) -meanx2(2)/std2(2); 0 0 1];

%% Normalize points

xtilde{1}=pflat(N1*x{1});
xtilde{2}=pflat(N2*x{2});

%% Create M matrix

M=createM(xtilde)%,x1n,x2n);

%apply SVD
[U,S,V]=svd(M);

v=V(:,end);
% CHeck Eignenvalue
Stot=S'*S;
Stot(end)

%check norm
norm(M*v)

%create normalized fundamental matrix
Fn=reshape(v,[3 3])
[U,S,V]=svd(Fn);
S(3,3)=0;
Fn=U*S*V';


%check determinant
det(Fn)

%unnormalize F
plot(diag(xtilde{2}(:,:)'*Fn*xtilde{1}(:,:)))

F=N2'*Fn*N1;
F=F./F(end);

%% project x1 to x2

l=F*x{1};
l = l./sqrt( repmat( l(1 ,:).^2 + l(2 ,:).^2 ,[3 1]));

r=randi(length(x{1}), 20,1);

%% plot stuff

figure;
imshow(im2);
colormap gray;
hold on;
plot(x{2}(1,r),x{2}(2,r),'b+','Markersize',40)
rital(l(:,r));
hold off

figure;
hist(abs(sum(l.*x{2})),100);
meanD=mean(abs(sum(l.*x{2})))




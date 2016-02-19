%% load data

PlotResults_1
%close all;
load('CompEx3data');


%% Normalize images

xtilde{1}=K\x{1};
xtilde{2}=K\x{2};


%% setup SVD and find essential matrix
M=createM(xtilde);
[U,S,V]=svd(M);
v=V(:,end);
Eapprox=reshape(v,[3 3]);
[U,S,V]=svd(Eapprox);
if det(U*V')>0
    E =U*diag([1 1 0])*V';
else
    V = -V;
    E = U*diag([1 1 0])*V';
end

xtilde{2}(:,1)'*E*xtilde{1}(:,1)

F1=(K')\E/K;


%% project x1 to x2

l=F1*x{1};
l = l./sqrt( repmat(l(1 ,:).^2 + l(2 ,:).^2 ,[3 1]));

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
meanD2=mean(abs(sum(l.*x{2})))
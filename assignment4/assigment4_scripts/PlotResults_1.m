%% load data
clear all;
clc;
%close all;
load('CompEx1data')

%% construct action matrix

X=pflat(X);
[plane,erms]=leastSq(X);
erms
%% compute RANSAC
iterations=10;
nbr_of_inliers = zeros(iterations,1);
inliers_indices = cell(iterations,1);
planes = {};
for i=1:iterations
    randind = randi(length(X),[3 1]);
    planes{i} = null(X(:,randind)');
    planes{i} = planes{i} ./ norm(planes{i}(1:3));
    inliers_indices_current = [];
    for k=1:length(X)
        if (abs(planes{i}' * X(:,k)) < 0.1 )
            nbr_of_inliers(i) = nbr_of_inliers(i) + 1;
            inliers_indices_current = [inliers_indices_current k];
        end
    end
    inliers_indices{i} = inliers_indices_current;
end

% find matches
best_match = find(nbr_of_inliers == max(nbr_of_inliers));
best_match = best_match(1);
max_inliers = nbr_of_inliers(best_match);
plane  = planes{best_match};
X_inliers = X(:,inliers_indices{best_match});

%get erms
erms_RANSAC = sqrt(sum((plane'*X_inliers).^2)/size(X_inliers ,2))
% plot stuff

figure;
histogram(abs(plane'*X_inliers),100);
title('RANSAC')

%% least squares on inliers

[plane_inliers,erms_inliers]=leastSq(X_inliers);
erms_inliers
figure;
histogram(abs(plane_inliers'*X_inliers),100)
title('Least squares')

%% Homography
v=pflat(K\P{1}*X);
u=pflat(K\P{2}*X);

Pnorm{1}=K\P{1};
Pnorm{2}=K\P{2};
R=Pnorm{2}(1:3,1:3);
t=Pnorm{2}(:,4);
pi=pflat(plane_inliers);
H = (R-t*pi(1:3)')
% 
% 
% % create M matrix
%     M=zeros(size(v,2)*3,3*size(v,1)+size(v,2));
% for i=1:size(v,2)
%     M(3*(i-1)+1,1:size(v,1))=[v(:,i)]';
%     M(3*(i-1)+2,size(v,1)+1:2*size(v,1))=[v(:,i)]';
%     M(3*i,2*size(v,1)+1:3*size(v,1))=[v(:,i)]';
%     M(3*(i-1)+1:3*i,size(v,1).^2+i)=-u(:,i);
% end
% 
% % perfom svd
% 
% [U,S,V]=svd(M);
% vsolution=(V(:,end));
% H=[vsolution(1:3)';vsolution(4:6)';vsolution(7:9)'];
% H=H./H(end);

homo=pflat(H*v);
up=K*u;
vp=K*homo;

mean(mean(vp-up))

figure;
plot(up(1,:),up(2,:),'ro');
hold on
plot(vp(1,:),vp(2,:),'g+')
axis equal
hold off


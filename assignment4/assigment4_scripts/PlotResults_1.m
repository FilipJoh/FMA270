%% load data
clear all;
clc;
close all;
load('CompEx1data')

%% construct action matrix

X=pflat(X);
[plane,erms]=leastSq(X);
erms
% meanX=mean(X,2);
% Xtilde=(X-repmat(meanX,[1,size(X,2)]));
% M= Xtilde(1:3,:)*Xtilde(1:3,:)' ;
% 
% % compute eigenvalues
% [V,D]=eig(M);
% abc=V(:,1)';
% plane=[abc -abc*meanX(1:3)]';
% 
% %compute RMS
% erms=sqrt(sum((plane'*X).^2)/size(X ,2))

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
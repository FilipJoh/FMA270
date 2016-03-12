%% load data
im1=imread('im1.jpg');
im2=imread('im2.jpg');

%What we want ot produce here is a Homography from image to image 2
% This is in order to find points on lines

%Initial thought, find feature points with SIFT.

[fim1, dim1] = vl_sift(single(rgb2gray(im1)));
[fim2, dim2] = vl_sift(single(rgb2gray(im2)));

matches = vl_ubcmatch(dim1 , dim2 );

xA = fim1(1:2,matches(1 ,:));
xB = fim2(1:2,matches(2 ,:));

C1=corner(rgb2gray(im1));
%C2=corner(im2);


%% plot features (for testing)

figure;
imshow(im1);
hold on
vl_plotframe(fim1)
plot(C1(:,1),C1(:,2),'b+','markersize',10)
hold off

figure;
imshow(im2)
hold on
vl_plotframe(fim2)
hold off

%% compute Homography matrix

%iterations=8;
v=xA;
u=xB;
H= {};

v=[v;ones(1,size(v,2))];
u=[u;ones(1,size(u,2))];

%% compute H with RANSAC approach
% i=1;
% 
% nbr_of_inliers = zeros(1,1);
% inliers_indices = {};
% iterations=100
% 
% % while(max(nbr_of_inliers)<150)
% for i=1:iterations
%     
%     randind = randi(length(v),[1 4]); 
%     
%     M=createM(v(:,randind),u(:,randind));
%     [U,S,V]=svd(M);
%     vprime=V(:,end);
%     H{i}=reshape(vprime(1:9),[3 3])';
%     inliers_indices_current = [];
%     for k=1:length(v)
%         if norm(pflat(H{i}*v(:,k))-u(:,k))<=5
%         nbr_of_inliers(i) = nbr_of_inliers(i) + 1;
%         inliers_indices_current = [inliers_indices_current k];
%         end
%     end
%    inliers_indices{i} = inliers_indices_current;
%    nbr_of_inliers = [nbr_of_inliers  zeros(1,1)];
%    i=i+1
% end
% best_match = find(nbr_of_inliers == max(nbr_of_inliers));
% best_match = best_match(1);
% max_inliers = nbr_of_inliers(best_match);
% i
% 
% %perform stiching using H
% bestH=H{best_match}
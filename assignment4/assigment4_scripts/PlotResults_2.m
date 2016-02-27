%% load data.

A=imread('a.jpg');
B=imread('b.jpg');

%% find matches with SIFT

[fA, dA] = vl_sift(single(rgb2gray(A)));
[fB, dB] = vl_sift(single(rgb2gray(B)));

matches = vl_ubcmatch(dA , dB );

xA = fA(1:2,matches(1 ,:));
xB = fB(1:2,matches(2 ,:));

%iterations=8;
v=xA;
u=xB;
%nbr_of_inliers = zeros(iterations,1);
%inliers_indices = cell(iterations,1);
H= {};

v=[v;ones(1,size(v,2))];
u=[u;ones(1,size(u,2))];

%% compute H with RANSAC approach
i=1;

nbr_of_inliers = zeros(1,1);
inliers_indices = {}%cell(iterations,1);

while(max(nbr_of_inliers)<150)
%for i=1:iterations
    
    randind = randi(length(v),[1 4]); 
    
    M=createM(v(:,randind),u(:,randind));
    [U,S,V]=svd(M);
    vprime=V(:,end);
    H{i}=reshape(vprime(1:9),[3 3])';
    inliers_indices_current = [];
    for k=1:length(v)
        if norm(pflat(H{i}*v(:,k))-u(:,k))<=5
        nbr_of_inliers(i) = nbr_of_inliers(i) + 1;
        inliers_indices_current = [inliers_indices_current k];
        end
    end
   inliers_indices{i} = inliers_indices_current;
   nbr_of_inliers = [nbr_of_inliers  zeros(1,1)];
   i=i+1;
end
best_match = find(nbr_of_inliers == max(nbr_of_inliers));
best_match = best_match(1);
max_inliers = nbr_of_inliers(best_match);

%for j=1:4
bestH=H{best_match}
%bestH=H{j};


tform = maketform('projective', bestH');
transfbounds = findbounds(tform ,[1 1; size(A ,2) size(A ,1)]);
xdata =[ min([transfbounds(: ,1); 1]) max([ transfbounds(: ,1); size(B ,2)])];
ydata =[ min([transfbounds(: ,2); 1]) max([ transfbounds(: ,2); size(B ,1)])];

[newA] = imtransform(A ,tform , 'xdata', xdata , 'ydata ', ydata );
tform2 = maketform('projective', eye(3));
[ newB ] = imtransform(B , tform2 , 'xdata', xdata ,'ydata', ydata ,'size', size( newA ));

newAB = newB ;
newAB ( newB < newA ) = newA ( newB < newA );

figure;
imshow(newAB)
i
%end



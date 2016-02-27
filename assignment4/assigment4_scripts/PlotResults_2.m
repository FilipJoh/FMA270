%% load data.

A=imread('a.jpg');
B=imread('b.jpg');

%% find matches with SIFT

[fA, dA] = vl_sift(single(rgb2gray(A)));
[fB, dB] = vl_sift(single(rgb2gray(B)));

matches = vl_ubcmatch(dA , dB );

xA = fA(1:2,matches(1 ,:));
xB = fB(1:2,matches(2 ,:));

iterations=4;
u=xA;
v=xB;


for i=1:iterations
   M=createM([v;ones(1,size(v,2))],[u;ones(1,size(u,2))])
   [U,S,V]=svd(M);
   vprime=V(:,end);
   H=reshape(vprime(1:9),[3 3])';   
end

bestH=H;

tform = maketform ('projective', bestH');
%transfbounds = findbounds ( tform ,[1 1; size (A ,2) size (A ,1)]);
xdata =[ min([ transfbounds(: ,1); 1]) max([ transfbounds(: ,1); size(B ,2)])];
ydata =[ min([ transfbounds(: ,2); 1]) max([ transfbounds(: ,2); size(B ,1)])];

[newA] = imtransform(A ,tform , 'xdata', xdata , 'ydata ', ydata );

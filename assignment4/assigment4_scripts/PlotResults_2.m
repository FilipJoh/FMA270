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
   M=createM(v,u)
   [U,S,V]=svd(M);
    
    
end

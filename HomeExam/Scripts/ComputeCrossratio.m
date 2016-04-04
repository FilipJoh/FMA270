function [ value ] = ComputeCrossratio( o,x1,x2,x3,x4 )
%Computes the crossratio from imagepoints x1-x4 on a line and imagepoint o
%that is not on the line.

%add homogenous coordinate, create matrices
A=[o' 1; x1' 1; x3' 1];
B=[o' 1; x2' 1; x4' 1];
C=[o' 1; x1' 1; x4' 1];
D=[o' 1; x2' 1; x3' 1];

%computes the crossRatio
value=det(A)*det(B)/(det(C)*det(D));

end


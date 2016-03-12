function [F] = createF(xtilde,x)
%create the M-matrix
M=createM(xtilde,x);
[U,S,V]=svd(M);

%Extract the last and second last columns of V
v0=V(:,end);
v1=V(:,end-1);

%determine which v corresponds to which F. This is done be checking the
%last element of both v-vectors. The one closest to zero is F1.
    if (abs(v0(end))<(abs(v1(end))))
        F0=reshape(v1,[3 3]);
        F1=reshape(v0,[3 3]);
    else
       F0=reshape(v0,[3 3]);
       F1=reshape(v1,[3 3]);   
    end
    
    %solve the eigenvalue problem in order to compute b candidates
    b=eig(-F1\F0);
    b=real(b);
    %testing of every b
    determinants=zeros(3,1);
    for i=1:3
        determinants(i)=[abs(det(F0+b(i)*F1))];
    end
    bindex=find(determinants==min(determinants));
    F=F0+b(bindex(1))*F1;
end
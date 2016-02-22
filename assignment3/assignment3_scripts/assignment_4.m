%% create fundmendal matrix
F=[0 1 1; 1 0 0; 0 1 1];

X{1}=[1 2 3 1]';
X{2}=[3 2 1 1]';

P1=[eye(3) zeros(3,1)];
C1=null(P1);
e2=null(F');
e2=e2./e2(end);
e2x=createCrossMatrix(e2);
P2=[e2x*F e2];

for i=1:2
    xproj1{i}=P1*X{i};
    xproj2{i}=P2*X{i};
end

disp('first scene point')
xproj2{1}'*F*xproj1{1}
xproj2{2}'*F*xproj1{2}

null(P2)
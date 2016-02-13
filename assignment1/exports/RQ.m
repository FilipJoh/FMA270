function [K,R,t ] = RQ( P )
%Conducts RQ factoristation on P 
A=P(:,1:3);
temp=P(:,4);

A1=A(1,:);
A2=A(2,:);
A3=A(3,:);

%Creating K and R using same method as in lecture notes
f=norm(A3);
R3=1/f*A3;
e=A2*R3';
d=norm(A2-e*R3);
R2=1/d*(A2-e*R3);
c=A1*R3';
b=A1*R2';
a=norm(A1-b*R2-c*R3);
R1=1/a*(A1-b*R2-c*R3);

R=[R1;R2;R3];
K=[a b c; 0 d e; 0 0 f];
K=K./K(3,3);
t=K\temp;

end


% create matrix
Pa=[1168 2030 -876 35400; -1280 1200 960 16000; 0 0 0 1];

% divide into smaller matrices
A=Pa(:,1:3);
a=Pa(:,end);

%compute the thrid row of R
R3=A(3,:);

%compute f_y as well as the second row of R
fy=norm(A(2,:));
R2=A(2,:)/fy;

%Compute s, f_x as well we the first row of R
s=A(1,:)*R2'
fx=norm(A(1,:)-s*R2);
R1=(A(1,:)-s*R2)/fx;

%create R and K matrices
R=[R1; R2; R3]
K=[fx s 0; 0 fy 0; 0 0 1]

%compute t
t=K\a;

%create Pn
Pn=[R t]

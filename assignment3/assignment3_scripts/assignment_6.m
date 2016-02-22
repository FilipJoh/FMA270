%% construct E-matrix

U=[1/sqrt(2) -1/sqrt(2) 0; 1/sqrt(2) 1/sqrt(2) 0; 0 0 1];
V=[1 0 0; 0 0 -1; 0 1 0];

disp(['determinant: ' num2str(det(U*V'))])

E=U*diag([1 1 0])*V';

%% test said matrix

x1=[0 0 1]';
x2=[1 1 1]';

x2'*E*x1

%% construct W and camera matrices

W=[0 -1 0; 1 0 0; 0 0 1];
P={};

syms s real;
X=[0 0 1 s]'
Trans=0;

for i=1:4
    
    if mod(i,2)==0
        u3=-U(:,3)
        disp('odd')
    else
        u3=U(:,3)
    end
    if i==3 | i==4
        if Trans==0
            W=W';
            Trans=1;
        end
    end
   P{i}=[U*W*V' u3];
   x{i}=P{i}*X;
end


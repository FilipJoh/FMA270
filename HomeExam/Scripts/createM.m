function [M] = createM(xtilde,x)
M=zeros(7,9);
    for i=1:size(M,2)-2
    M(i,:)=[xtilde(1,i)*x(1,i) xtilde(1,i)*x(2,i) xtilde(1,i)*x(3,i) xtilde(2,i)*x(1,i) xtilde(2,i)*x(2,i) xtilde(2,i)*x(3,i) xtilde(3,i)*x(1,i) xtilde(3,i)*x(2,i) xtilde(3,i)*x(3,i)];
    end
end


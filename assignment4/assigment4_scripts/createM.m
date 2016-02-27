function [M] = createM(v,x)
M=zeros(size(v,2)*3,size(v,1)*3+size(v,2));
    for i=1:size(v,2)
    M(3*(i-1)+1,1:size(v,1))=v(:,i)';
    M(3*(i-1)+2,size(v,1)+1:2*size(v,1))=v(:,i)';
    M(3*i,size(v,1)*2+1:size(v,1)*3)=v(:,i)';
    M(3*(i-1)+1:3*i,3*size(v,1)+i)=-x(:,i);
    end

end


function [M] = createM(xtilde)%,x1n,x2n)
M = zeros(length(xtilde{1}),9);
    for i = 1:length(xtilde{1}) 
        xx=xtilde{2}(:,i)*xtilde{1}(:,i)';
%         xx=x2n(:,i)*x1n(:,i)';
        M(i,:)=xx(:)';       
    end
end
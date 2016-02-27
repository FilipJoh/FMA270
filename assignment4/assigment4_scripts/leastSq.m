function [ plane, erms ] = leastSq(X)
    meanX=mean(X,2);
    Xtilde=(X-repmat(meanX,[1 size(X,2)]));
    M= Xtilde(1:3,:)*Xtilde(1:3,:)' ;

    % compute eigenvalues
    [V,D]=eig(M);
    abc=V(:,1)';
    plane=[abc -abc*meanX(1:3)]';
    plane = plane ./ norm(plane(1:3));

    %compute RMS
    erms=sqrt(sum((plane'*X).^2)/size(X ,2));
end
clear all;
load('compEx1data.mat');

means1 = mean(x{1}(1:2 ,:), 2);
stds1 = std(x{1}(1:2 ,:), 0, 2);
N1 = [1/stds1(1) 0 -means1(1)/stds1(1); ... 
    0 1/stds1(2) -means1(2)/stds1(2); 0 0 1];
x1n = pflat(N1*x{1});

means2 = mean(x{2}(1:2 ,:), 2);
stds2 = std(x{2}(1:2 ,:), 0, 2);
N2 = [1/stds2(1) 0 -means2(1)/stds2(1); ... 
    0 1/stds2(2) -means2(2)/stds2(2); 0 0 1];
x2n = pflat(N2*x{2});

M = [];
for i=1:2008
    xx = x2n(:,i)*x1n(:,i)';
    M(i,:) = xx(:)';
end

[~,~,v] = svd(M);
Fn = reshape(v(:,end), [3 3]);

det(Fn)

[u,s,v] = svd(Fn);
s(3,3) = 0;
Fn = u*s*v';



F = N2'*Fn*N1;
F = F./F(3,3);

det(F)



l = F*x{1}; % Computes the epipolar lines
l = l./sqrt(repmat(l(1, :).^2 + l(2, :).^2, [3 1]));

save('compEx2data.mat', 'F', 'N1', 'N2');

figure(1);
imshow(imread('kronan2.JPG'));
perm = randperm(size(x{2}, 2));
hold on;

for i=1:20
    rital(l(:,perm(i)));
    plot(x{2}(1,perm(i)), x{2}(2,perm(i)),'ro');
end
hold off;

figure(2)
hist(abs(sum(l.*x{2})), 100);
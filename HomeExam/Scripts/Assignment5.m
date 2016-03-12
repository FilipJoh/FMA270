%% load data
load('ex5data')

%% compute F with RANSAC

iterations=100;

%Define cell arrays
nbr_of_inliers = zeros(1,1);
inliers_indices = {};
F={};

%while(max(nbr_of_inliers)<150)
for i=1:iterations
    randind = randi(length(x{1}),[1 7]); 
    %compute F
    F{i}=createF(x{1}(:,randind),x{2}(:,randind));
   
    
    %Test solution
    inliers_indices_current = [];
    for k=1:length(x{1})
        %Compute the epipolar line
        l=F{i}*x{1}(:,k);
        %normalize l
        l = l./sqrt(l(1)^2+l(2)^2);
        
        %Compute distance to from image points to the corresponding
        %epipolar line
        l'*x{2}(:,k)-x{2}(:,k)'*l;
        if x{2}(:,k)'*l<=5
            nbr_of_inliers(i) = nbr_of_inliers(i) + 1;
            inliers_indices_current = [inliers_indices_current k];
        end
    end
   inliers_indices{i} = inliers_indices_current;
   nbr_of_inliers = [nbr_of_inliers  zeros(1,1)];
   i=i+1;
end
best_match = find(nbr_of_inliers == max(nbr_of_inliers));
best_match = best_match(1);
max_inliers = nbr_of_inliers(best_match);
F_final=F{best_match}
i
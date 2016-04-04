%% load data
load('ex5data')

%% compute F with RANSAC

iterations=100;

%Define cell arrays
nbr_of_inliers = zeros(iterations,3);
inliers_indices = {};
%F as a cell array of cell arrays
F={{}};

for i=1:iterations
    randind = randi(length(x{1}),[1 7]); 
    %compute F
    F{i}=createF(x{1}(:,randind),x{2}(:,randind));
   
    for j=1:length(F{i})
        %Test solution
        inliers_indices_current = [];
        for k=1:length(x{1})
            %Compute the epipolar line
            l=F{i}{j}*x{1}(:,k);
            %normalize l
            l = l./sqrt(l(1)^2+l(2)^2);

            %Compute distance to from image points to the corresponding
            %epipolar line
            l'*x{2}(:,k)-x{2}(:,k)'*l;
            if x{2}(:,k)'*l<=5
                nbr_of_inliers(i,j) = nbr_of_inliers(i) + 1;
            end
        end
    end
end

%Get the best match
[best_match_row,best_match_col] = find(nbr_of_inliers == max(max(nbr_of_inliers)));
best_match_row = best_match_row(1);
best_match_col = best_match_col(1);

%get the best matching F
F_final=F{best_match_row}{best_match_col}
i
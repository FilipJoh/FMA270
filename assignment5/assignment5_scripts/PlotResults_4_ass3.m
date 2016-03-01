%% compute required data

PlotResults_3_ass3
close all

%% compute camera matrices


W=[0 -1 0;1 0 0; 0 0 1];
P_2{1}=[U*W*V' U(:,3)]
P_2{2}=[U*W*V' -U(:,3)]
P_2{3}=[U*W'*V' U(:,3)]
P_2{4}=[U*W'*V' -U(:,3)]
P1=[eye(3) [0 0 0]'];

%% Setup DLT

P1n=K*P1;
isInFront = {};
X={};
for i=1:4
    [X{i},U,S,V]=Triang(xtilde,P1,P_2{i});    
    X{i}=pflat(X{i});

    %plot reconstructed 3D-points
    figure;
    plot3(X{i}(1,:),X{i}(2,:),X{i}(3,:),'.b','Markersize',2);
    hold on
    plotcams({P1; P_2{i}})
    axis equal
    hold off
    P2n=K*P_2{i};
    pProj2{i}=pflat(P2n*X{i});
    
    figure;
    imshow(im2)
    hold on
    plot(pProj2{i}(1,:),pProj2{i}(2,:),'+g')
    plot(x{2}(1,:),x{2}(2,:),'ro');
    hold off
    legend('projected points','image feature points');
    
  


    camera_center = null(P_2{i});
    principal_axis = P_2{i}(end,1:3);
    frontindex = [];
    for k = 1:length(X{i})
        Xprime = X{i}(:,k) - camera_center;
        if (((Xprime(1:3)' * principal_axis') > 0) && ((Xprime(1:3)' * [0 0 1]') > 0))
            frontindex = [frontindex i];
        end
        isInFront{i} = frontindex;
    end
end
%%Load data
load('assignment1data/compEx3.mat');
nbrofLines=42;

%% plot undistorted grid
figure;
plot([startpoints(1,:); endpoints(1,:)],[startpoints(2,:); endpoints(2,:)],'b-')    

%%apply H1 and plot
H1=[sqrt(3) -1 1; 1 sqrt(3) 1; 0 0 2];
[CTS1, CTE1]=transformPoints(startpoints,endpoints,H1);
figure;
plot([CTS1(1,:);CTE1(1,:)],[CTS1(2,:);CTE1(2,:)],'b-')

%% apply H2 and plot
H2=[1 -1 1; 1 1 0; 0 0 1];
figure;
[CTS2, CTE2]=transformPoints(startpoints,endpoints,H2);
plot([CTS2(1,:);CTE2(1,:)],[CTS2(2,:);CTE2(2,:)],'b-')

%% apply H3 and plot 
H3=[1 1 0; 0 2 0; 0 0 1];
figure;
[CTS3, CTE3]=transformPoints(startpoints,endpoints,H3);
plot([CTS3(1,:);CTE3(1,:)],[CTS3(2,:);CTE3(2,:)],'b-')

%% apply H4 and plot
H4=[sqrt(3) -1 1; 1 sqrt(3) 1; 1/4 1/2 2];
figure;
[CTS4, CTE4]=transformPoints(startpoints,endpoints,H4);
plot([CTS4(1,:);CTE4(1,:)],[CTS4(2,:);CTE4(2,:)],'b-')

%%load data and images
load('compEx2.mat');
im=imread('compEx2.JPG');

%% plot image
figure;
imagesc(im)
colormap gray;
hold on;
%% plot points and lines
handle=plot(p1(1,:),p1(2,:),'ob',p2(1,:),p2(2,:),'or',p3(1,:),p3(2,:),'og');
set(handle,'linewidth',4);

%Find the lines
l1=null(p1');
l2=null(p2');
l3=null(p3');

%plot the lines
rital(l1,'b')
rital(l2,'r')
rital(l3,'g')

%% find intersections between l2 and l3
inter23=null([l2,l3]');
noHomo23=inter23./inter23(end);
plot(noHomo23(1),noHomo23(2),'+w');

%% distance calculation
dist=(noHomo23'*l1)/(norm(l1(1:2)))

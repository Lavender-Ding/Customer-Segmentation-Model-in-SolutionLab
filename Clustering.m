k = 13;

tSEN_Data = csvread('.\3D_MAP\para=49.csv');
Idx = csvread('.\Data\para49k13.csv',1,1);
% eva = evalclusters(tSEN_Data,'kmeans','silhouette','KList',[1:20])
% [Idx,C,sumD,D] = kmeans(tSEN_Data,k,'emptyaction','drop','start','uniform');
% csvwrite('.\Data\Idx.csv',Idx);
figure(2);
scatter3(tSEN_Data(:,1),tSEN_Data(:,2),tSEN_Data(:,3),[],Idx,'.');

xlabel('x asix');
ylabel('y asix');
zlabel('z asix');
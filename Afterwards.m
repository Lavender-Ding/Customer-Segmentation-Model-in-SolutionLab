clear;
clc;
Amount = csvread('.\DBSCAN\AmountOfCluster.csv');
Label = csvread('.\DBSCAN\IdxPara=45.csv');
tSNE_Data = csvread('.\3D_MAP\para=45.csv');
[I,J,V] = find(Amount == max(Amount(:,2)));
BiggestCluster = tSNE_Data(Label == I,:);
scatter3(BiggestCluster(:,1),BiggestCluster(:,2),BiggestCluster(:,3),'.');
% scatter(BiggestCluster(:,1),BiggestCluster(:,2),'.');
% figure;
% [Ik c] = kmeans(BiggestCluster,3);
% scatter3(BiggestCluster(:,1),BiggestCluster(:,2),BiggestCluster(:,3),[],Ik,'.');
k = 3;
ltol = 0.01;
maxiter = 1000;
pflag = 1;
Init = [];
X = BiggestCluster;
[W,M,V,L,E,Lb] = EM_GM_fast(X,k,ltol,maxiter,pflag,Init);

for i = 1 : size(Label)
    if Label(i) > I
        Label(i) = Label(i) + k - 1;
    end
end

j=0;
for i = 1 : size(Label)
    if Label(i) == I
        j = j + 1;
        Label(i) = I + Lb(j) - 1;
    end
end

newSize = size(Amount,1) + k - 1;
AmountWithEM(:,1) = 1 : newSize;
AmountWithEM(newSize,1) = -1;
for i = 1 : newSize
    AmountWithEM(i,2) = sum(Label == AmountWithEM(i,1));
end

scatter3(tSNE_Data(:,1),tSNE_Data(:,2),tSNE_Data(:,3),[],Label./k,'.');

csvwrite('.\DBSCAN\IdxPara=45WithEM.csv',Label)
csvwrite('.\DBSCAN\AmountOfClusterWithEM.csv',AmountWithEM)

% Amount (I,J) = 0;
% [I,J,V] = find(Amount == max(Amount(:,2)));
% BiggestCluster = tSNE_Data(Label == I,:);
% scatter3(BiggestCluster(:,1),BiggestCluster(:,2),BiggestCluster(:,3),'.');
% % scatter(BiggestCluster(:,1),BiggestCluster(:,2),'.');
% % figure;
% % [Ik c] = kmeans(BiggestCluster,3);
% % scatter3(BiggestCluster(:,1),BiggestCluster(:,2),BiggestCluster(:,3),[],Ik,'.');
% k = 2;
% ltol = 0.01;
% maxiter = 1000;
% pflag = 1;
% Init = [];
% X = BiggestCluster;
% [W,M,V,L,E] = EM_GM_fast(X,k,ltol,maxiter,pflag,Init);

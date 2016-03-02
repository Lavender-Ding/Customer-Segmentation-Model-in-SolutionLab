clear;
clc;

belta = 8;
MinPts = 13;

delete .\DBSCAN\JPG\*
delete .\DBSCAN\FIG\*
tSNE_Data = csvread('.\3D_MAP\para=45.csv');
% tSNE_Data = csvread('.\Data\Steady.csv',1,1);
[Idx, Idx_Score] = dbscan(tSNE_Data,belta,MinPts);
fprintf('There are %d clusters,\n',length(unique(Idx)));
prompt = 'do we need to continue? [y/n]\n';
str = input(prompt,'s');
if str ~= 'y' && str ~= 'Y'
    return
end;
Amount = zeros(length(unique(Idx)),2);
for i = 1:length(unique(Idx)) - 1
    tempData = tSNE_Data(Idx == i,:);
    Amount(i,:) = [i sum(Idx == i)];
    h = scatter3(tempData(:,1),tempData(:,2),tempData(:,3),...
        'Marker','o',...
        'LineWidth',0.1,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[0 .75 .75]);
    axis([-100 100 -100 100 -100 100]);
    saveas(gcf,strcat('.\DBSCAN\JPG\Label = ',int2str(i),'.jpg'));
    saveas(gcf,strcat('.\DBSCAN\FIG\Label = ',int2str(i),'.fig'));
end;
tempData = tSNE_Data(Idx == -1,:);
i = -1;
Amount(length(unique(Idx)),:) = [-1 sum(Idx == -1)];
h = scatter3(tempData(:,1),tempData(:,2),tempData(:,3));
axis([-100 100 -100 100 -100 100])
saveas(gcf,strcat('.\DBSCAN\FIG\Label = ',int2str(i),'.fig'));
csvwrite('.\DBSCAN\AmountOfCluster.csv',Amount);
scatter3(tSNE_Data(:,1),tSNE_Data(:,2),tSNE_Data(:,3),[],Idx,'.');
csvwrite('.\DBSCAN\IdxPara=45.csv',Idx)

% belta = 8;
% MinPts = 7;
% 
% % belta = 8;
% % MinPts = 8;
% 
% % 9,8
% 
% delete .\DBSCAN\JPG\*
% delete .\DBSCAN\FIG\*
% tSNE_Data = csvread('.\3D_MAP\para=45.csv');
% [Idx, Idx_Score] = dbscan(tSNE_Data,belta,MinPts);
% % BiggestCluster = tSNE_Data(Idx == 1,:);
% % [Idx1, Idx_Score2] = dbscan(BiggestCluster,10,5);
% % sum(Idx1 == -1)
% BiggestCluster = tSNE_Data(Idx == 1,:);
% [Idx1, ~] = kmeans(BiggestCluster,4);
% index = 1;
% len = length(unique(Idx));
% for row = 1:length(Idx)
%     if Idx(row) == 1
%         Idx(row) = Idx1(index) + len - 1;
%         index = index + 1;
%     end;
% end;
% Idx = Idx - 1;
% fprintf('There are %d clusters,\n',length(unique(Idx)));
% prompt = 'do we need to continue? [y/n]\n';
% str = input(prompt,'s');
% if str ~= 'y' && str ~= 'Y'
%     return
% end;
% Amount = zeros(length(unique(Idx)),2);
% for i = 1:length(unique(Idx)) - 1
%     tempData = tSNE_Data(Idx == i,:);
%     
%     h = scatter3(tempData(:,1),tempData(:,2),tempData(:,3),...
%         'Marker','o',...
%         'LineWidth',0.1,...
%         'MarkerEdgeColor','k',...
%         'MarkerFaceColor',[0 .75 .75]);
%     axis([-100 100 -100 100 -100 100]);
%     saveas(gcf,strcat('.\DBSCAN\JPG\Label = ',int2str(i),'.jpg'));
%     saveas(gcf,strcat('.\DBSCAN\FIG\Label = ',int2str(i),'.fig'));
% end;
% tempData = tSNE_Data(Idx == -1,:);
% i = -1;
% h = scatter3(tempData(:,1),tempData(:,2),tempData(:,3));
% axis([-100 100 -100 100 -100 100])
% saveas(gcf,strcat('.\DBSCAN\FIG\Label = ',int2str(i),'.fig'));
% 
% % saveas(gcf,strcat('.\DBSCAN\bigFIG\Label = ',int2str(i),'.fig'));
% % csvwrite('.\DBSCAN\AmountOfCluster_big.csv',Amount);
% scatter3(tSNE_Data(:,1),tSNE_Data(:,2),tSNE_Data(:,3),[],Idx,'.');
% 
% 
% for i = 1:length(unique(Idx)) - 1
%     Amount(i,:) = [i sum(Idx == i)];
% end;
% Amount(length(unique(Idx)),:) = [-2 sum(Idx == -2)];
% 
% csvwrite('.\DBSCAN\AmountOfCluster.csv',Amount);
% csvwrite('.\DBSCAN\IdxPara=45.csv',Idx)
% % csvwrite('.\DBSCAN\IdxPara=5_big.csv',Idx)
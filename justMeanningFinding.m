[in,title] = xlsread('.\Data\processed_Title.xlsx');
indata = csvread('.\Data\processed_Data.csv');
idx = csvread('.\DBSCAN\IdxPara=45WithEM.csv');
cluster = csvread('.\DBSCAN\AmountOfClusterWithEM.csv');
result(1:2,:) = cluster';
title = title';
for i = 1 : size(indata,2)
    for k = 1 : size(cluster,1)
        tmp = mean(indata(idx == cluster(k,1),i));
        result(i + 2,k) = tmp;
    end
end
result_tmp = result(:,1:size(result,2)-1);
variance = var(result_tmp')';
meaning = result(variance > 0.01,:);
variance_tmp = variance(3:size(variance,1),:);
title_final = title(variance_tmp > 0.01,:);
xlswrite('.\Result\Title.xlsx',title_final)
csvwrite('.\Result\Result.csv',meaning)

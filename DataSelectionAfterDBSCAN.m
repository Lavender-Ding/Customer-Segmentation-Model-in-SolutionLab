delete .\Results\ClusterElements.xlsx
dtData = csvread('.\Data\processed_Data.csv');
Idx = csvread('.\DBSCAN\IdxPara=49.csv');
[~, meaningData] = xlsread('.\Data\meaning_Interpretation.xlsx');
[~, Title] = xlsread('.\Data\Title.xlsx');
threshold = 100;

for i = 1:length(unique(Idx)) - 1
    if sum(Idx == i) < threshold
        Idx(Idx == i) = -1;
    end;
end;
label = unique(Idx);

for tmp = 1:length(label)
    i = label(tmp);
    if i == -1
        continue;
    end; 
    IdxForGroupi = Idx;
    IdxForGroupi(IdxForGroupi ~= i) = 0;
    [max_gain_feature, gain] = infogain(dtData,IdxForGroupi,100);
    selectedDim = max_gain_feature;
    writableData = cell(10,length(selectedDim));
    selectedTitle = Title(selectedDim);
    
    writableData(1,:) = selectedTitle;
    for j = 1:length(selectedTitle)
        index = selectedTitle(j);
        writableData{2,j} = mean(dtData(IdxForGroupi ~= 0,selectedDim(j)));
        writableData{3,j} = mean(dtData(:,selectedDim(j)));
        writableData{6,j} = (writableData{2,j} - writableData{3,j}) / ...
                            (max(dtData(:,selectedDim(j))) - min(dtData(:,selectedDim(j))));
    end;
    
    SelectedDimensionInterpretion1 = meaningInterpreting(selectedTitle, meaningData)';
    xlswrite('.\Results\ClusterElements.xlsx',writableData,strcat('Cluster',num2str(i)));
end;
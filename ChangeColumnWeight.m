clear;
clc;

[inData, inTitle] = xlsread('.\Data\id_media.xlsx');
[Demo_Data, Demo_Title] = xlsread('.\Data\id_demo.xlsx');

inData = [inData,zeros(size(inData,1),1)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%加收入，将上网时间分布归为工作日上网比率和工作日的工作时间的上网比率%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DemoIncome = Demo_Data(:,3);
MediaIncome = ones(size(inData,1),1) .* (-1);
DemoId = Demo_Title(:,1);
MediaId = inTitle(:,1);
for i = 2 : size(MediaId)
    for j = 2 : size(DemoId)
        if strcmp(DemoId(j),MediaId(i)) == 1
            MediaIncome(i-1,1) = DemoIncome(j-1,1);
            continue
        end
    end
end
inData(:,8) = inData(:,6) + inData(:,7);
inData(:,9) = inData(:,6) ./ inData(:,8);
inData(:,6) = MediaIncome;
inTitle(:,8) = {'income'};
inTitle(:,10) = {'weekday'};
inTitle(:,11) = {'work'};
inData(:,7) = [];
inTitle(:,9) = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%删除raw_mode的列，并且只保留long_term的用户数据%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Title = inTitle(1,3:size(inTitle,2));
reTitle = [];
reData = [];

for col = 3 : size(inTitle,2)
    name = inTitle(:,col);
    if strfind(name{1,1},'mode') > 0
        for row = 1 : size(inTitle,1)
            name2 = inTitle(row,col);
            if strfind(name2{1,1},'light')
                inData(row-1,col-2) = 0;
                inData(row-1,col-3) = 0;
            end
            if strfind(name2{1,1},'short_term')
                inData(row-1,col-2) = 1;
                inData(row-1,col-3) = 0;
            end
            if strfind(name2{1,1},'long_term')
                inData(row-1,col-2) = 2;
            end
        end
    end
end

reTitle = [];
reData = [];

for i = 1 : size(Title,2)
    name = Title(i);
    if strfind(name{1,1},'mode') > 0
        continue
    end
    reTitle = [reTitle Title(i)];
    reData = [reData inData(:,i)];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%区分电脑用户和非电脑用户%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%加权重%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Data = (mapminmax(reData',0,1))';
for i = 1 : size(Data,2)
    Data(:,i) = Data(:,i) .* (0.5 ./ mean(Data(:,i)));
end


outTitle = reTitle;
outData = Data;

csvwrite('.\Data\processed_Data.csv',outData);
xlswrite('.\Data\processed_Title.xlsx',outTitle);


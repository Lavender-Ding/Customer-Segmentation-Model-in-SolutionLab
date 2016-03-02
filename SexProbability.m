clc;
clear;

[inData, inTitle] = xlsread('.\Data\id_stat.xlsx');
Female = {'时尚','八卦','命理','购物','奢侈品','美容美体','明星资讯'};
Male = {'色情','军事','汽车','博彩','政治','体育'};

for i = 3 : size(inData,2)
    inData(:,i) = 100 .* inData(:,i) ./ inData(:,1);
end

FHSize = size(Female,2);
MHSize = size(Male,2);
Title = inTitle(1,2:size(inTitle,2));
Sex_Probability = zeros(size(inData,1),2);

Data_tmp = inData(:,3:size(inData,2));
Mean = mean((mean(Data_tmp))');
weight = zeros(1,size(inData,2)-2);

for i = 3 : size(inData,2)
    if mean(inData(:,i)) ~= 0
        weight(1,i-2) = Mean ./ mean(inData(:,i));
        inData(:,i) = inData(:,i) .* weight(1,i-2);
    end
end

FData = [];
MData = [];

for i = 1 : FHSize
    FHobby = Female(1,i);
    for j = 1 : size(Title,2)
        Hobby = Title(1,j);
        if strfind(Hobby{1,1},FHobby{1,1})
            FData = [FData,inData(:,j)];
        end
    end
end

for i = 1 : MHSize
    MHobby = Male(1,i);
    for j = 1 : size(Title,2)
        Hobby = Title(1,j);
        if strfind(Hobby{1,1},MHobby{1,1})
            MData = [MData,inData(:,j)];
        end
    end
end

FMax_Value = max(FData);
MMax_Value = max(MData);

Sex_Probability(:,1) = sum(FData,2);
Sex_Probability(:,2) = sum(MData,2);

Sex = Sex_Probability(:,2) - Sex_Probability(:,1);
% Sex = mapminmax(Sex',0,100)';

% Sex = mapminmax(Sex_Probability',0,100)';

% Sex_Probability(:,1) = sum(FData,2) ./ sum(FMax_Value);
% Sex_Probability(:,2) = sum(MData,2) ./ sum(MMax_Value);

% for id = 1 : size(inData,1)
%     for i = 1 : FHSize
%         FHobby = Female(1,i);
%         for j = 1 : size(Title,2)
%             Hobby = Title(1,j);
%             if strfind(Hobby{1,1},FHobby{1,1})
%                 Sex_Probability(id,1) = Sex_Probability(id,1) + inData(id,j);
%             end
%         end
%     end
%     for i = 1 : MHSize
%         MHobby = Male(1,i);
%         for j = 1 : size(Title,2)
%             Hobby = Title(1,j);
%             if strfind(Hobby{1,1},MHobby{1,1})
%                 Sex_Probability(id,2) = Sex_Probability(id,2) + inData(id,j);
%             end
%         end
%     end
% end








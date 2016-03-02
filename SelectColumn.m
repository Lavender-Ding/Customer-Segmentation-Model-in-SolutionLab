[inData, Title] = xlsread('.\Data\eral_weighted_data.xlsx');

SelectedColumn = {'D1_2','D3_1','D5_NA','LM1_5','LM2_12',...
                  'LM2_4','LM2_7','LM3_1_1','LM4_11','LM4_13',...
                  'LM4_19','LM4_2','LM4_4','LM4_9','P1'...
                    'P14_13','P14_14','P14_9'};

index = 0;
[outData, NotNaNnumber] = delete_NA_rows(inData);
selectedData = [];
for col = 1:size(outData,2)
    for j = 1:length(SelectedColumn)
        % if isempty(strfind(Title{col},SelectedColumn{j})) == 0  % Not empty, meaning that the needed column is finded     
        if strcmp(Title{col},SelectedColumn{j})
            selectedData = [selectedData outData(:,col)];
            fprintf(Title{col});
            fprintf(' is founded, with col = %d and j = %d\n',col,j);
        end;
    end;
end;
csvwrite('.\Data\processed_Data_2_28.csv',selectedData);
xlswrite('.\Data\Title.xlsx',Title);
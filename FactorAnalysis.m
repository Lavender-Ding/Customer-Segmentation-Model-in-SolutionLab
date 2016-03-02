[inData, Title] = xlsread('.\Result\speed_tmp.xlsx');
SelectedDimension = {'Q48_'};
outData = [];
outTitle = {};
index = 1;
%[outData, NotNaNnumber] = delete_NA_rows(inData);
for col = 1:size(inData,2)
    for j = 1:length(SelectedDimension)
        if isempty(strfind(Title{col},SelectedDimension{j})) == 0  % Not empty, meaning that the needed column is finded
            outData = [outData inData(:,col)];
            outTitle{index} = Title{col};
            index = index + 1;
            fprintf(Title{col});
            fprintf(' is founded. \n');
        end;
    end
end;

[pc,score,latent,tsquare] = princomp(outData); %PC is the matrix
value = cumsum(latent)./sum(latent) % Evaluate the quality of down-dim. 95%+ is OK.
coeff = pc(:,1:7);
DR_Data = outData * coeff;
xlswrite('.\Result\coeff.xlsx',coeff);
xlswrite('.\Result\coeff.xlsx',outTitle,'Title');
xlswrite('.\Result\Q48_NewData_7.xlsx',DR_Data);
% 'Q48_'

  
function [ selectedTitle ] = selectTitle(filename, selectedDim)
    % [inData, Title] = xlsread('.\Data\eral_weighted_data.xlsx');
    [~, Title] = xlsread(filename);
    selectedTitle = Title(selectedDim);
end
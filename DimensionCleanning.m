function [ outData ] = DimensionCleanning( inData )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
    threshold = 0.9;
    outData = [];
    all = size(inData,1);
    for i = 1:size(inData,2)
        temp = unique(inData(:,i));
        maxVal = 0;
        for len = 1:length(temp)
            t = sum(inData(:,i) == temp(len));
            if t > maxVal
                maxVal = t;
            end;
        end;
        if ~(maxVal/all > threshold)
            outData = [outData inData(:,i)];
        end;
    end;
%     outData = mapminmax(outData')';
end


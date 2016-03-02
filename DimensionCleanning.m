function [ outData ] = DimensionCleanning( inData )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
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


function [ out_Data, index ] = delete_NA_rows( in_Data )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% out_Data = zeros(length(find(in_Data(:,2) ~= 0)),size(in_Data,2));
out_Data = zeros(sum(~isnan(in_Data(:,1))),size(in_Data,2));
index = 1;
for i = 1:size(in_Data,1)
    if ~isnan(in_Data(i,1))
        out_Data(index,:) = in_Data(i,:);
        index = index + 1;
    end;
end;
index = index - 1;
end


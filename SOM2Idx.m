function [ Idx ] = SOM2Idx( Matrix )
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    num = size(Matrix,2);
    Idx = zeros(num,1);
    for i = 1:num
        Idx(i) = find(Matrix(:,i) ~= 0);
    end;
end


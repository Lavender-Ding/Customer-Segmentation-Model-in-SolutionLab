function [ Idx ] = SOM2Idx( Matrix )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
    num = size(Matrix,2);
    Idx = zeros(num,1);
    for i = 1:num
        Idx(i) = find(Matrix(:,i) ~= 0);
    end;
end


k = 15;
threshold = 0.8;

tTesting_Data = xlsread('eral_tsne_feb4.xlsx');
tIdx = csvread('Idx.csv');

tData = zeros(size(tTesting_Data,1),size(tTesting_Data,2),k);
for i = 1:k
    num = length(find(tIdx == i));
    tData(1:num,:,i) = tTesting_Data(tIdx == i,:);
end;

var_val = zeros(1,size(tTesting_Data,2),k);
mean_val = zeros(1,size(tTesting_Data,2),k);
for i = 1:k
    for col = 1:size(tTesting_Data,2)
        leng = length(find(tIdx == i));
        mean_val(1,col,i) = mean(tData(1:leng,col,i));
        if length(unique(tData(1:leng,col,i))) == 2 % Using tData(1:length(find(tIdx == i)) for the valid data just remains for length(find(tIdx == i)
            val1 = length(find((tData(1:leng,col,i))>0));
            val2 = length(find((tData(1:leng,col,i))));
            p = val1 / val2;
            var_val(1,col,i) = p * (1-p) / val2;
        else
            var_val(1,col,i) = var(tData(1:leng,col,i),1);
        end;
    end;
end;

d0 = 0;
% out = zeros(k * (k-1) / 2, size(tTesting_Data,2) + 5);
out = zeros(k,k);
for cluster_num_1 = 1:(k - 1)
    for cluster_num_2 = (cluster_num_1 + 1) : k
% for cluster_num_1 = 1:k
%     for cluster_num_2 = 1:k
        testing_val = zeros(1,size(tTesting_Data,2));
        for col = 1:size(tTesting_Data,2)
            n1 = length(find(tIdx == cluster_num_1));
            n2 = length(find(tIdx == cluster_num_2));
            x1_bar = mean_val(1,col,cluster_num_1);
            x2_bar = mean_val(1,col,cluster_num_2);
            s1_squ = var_val(1,col,cluster_num_1);
            s2_squ = var_val(1,col,cluster_num_2);
            t = ((x1_bar - x2_bar) - d0) / sqrt(s1_squ / n1 + s2_squ / n2);
            df = (s1_squ / n1 + s2_squ / n2)^2 / ( (s1_squ / n1)^2 / (n1 - 1) + (s2_squ / n2)^2 / (n2 - 1));
            testing_val(1,col) = abs(tcdf(t,df) * 2 - 1);
        end;
        out(cluster_num_1,cluster_num_2) = length(find(testing_val < 0.85)) / size(tTesting_Data,2);
        out(cluster_num_2,cluster_num_1) = out(cluster_num_1,cluster_num_2);
        %out(index,3:end - 3) = testing_val;
        %out(index,end - 1) = length(find(testing_val < 0.85)) / size(tTesting_Data,2);
        %out(index,end) = length(find(testing_val >= 0.85)) / size(tTesting_Data,2);
    end;
end;
xlswrite('out_k = 15.xlsx',out);


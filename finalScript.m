clear;
clc;

matlabpool local 12;
Data = csvread('.\Data\processed_Data.csv'); %The total dimension is 11 while the first col is Main_Key
% Data = randint(848,200);
col = {[0 .75 .75],[ 0 .5 0], [.75 .75 0;]};
start_per = 45;
end_per = 48;
start_k = 4;
end_k = 7;

sumD_2D = zeros((end_per - start_per + 1) + start_per * 2, ( 2+start_k + 2+end_k) * (end_k - start_k + 1) / 2);
sumD_3D = zeros((end_per - start_per + 1) + start_per * 2, ( 2+start_k + 2+end_k) * (end_k - start_k + 1) / 2);
error_2D = zeros(end_per + start_per,2);
error_3D = zeros(end_per + start_per,2);

Data = DimensionCleanning(Data);

% parfor i = start_per:end_per
%     %temp = zeros(1,( 2+start_k + 2+end_k) * (end_k - start_k + 1) / 2);
%     temp = [];
%     [mappedX, error] = tsne(Data,[], 2, 30, i);
%     error_2D(i,:) = [i, error];
%     fprintf(['Above is 2D graph where parameter = ' num2str(i) ' while error = ' num2str(error) '  <------------!>\n']);
%     %disp(['Above is 2D graph where parameter = ' num2str(i) ' while error = ' num2str(error) '  <------------!>']);
%     scatter(mappedX(:,1), mappedX(:,2));
%     saveas(gcf,strcat('.\2D_PIC\Raw\Raw_',int2str(i),'.jpg'));
%     saveas(gcf,strcat('.\2D_FIG\Raw_',int2str(i),'.fig'));
%     csvwrite(strcat('.\2D_MAP\para=',int2str(i),'.csv'),mappedX);
% end;
% csvwrite('error_2D.csv',error_2D);

parfor i = start_per:end_per
    %temp = zeros(1,( 2+start_k + 2+end_k) * (end_k - start_k + 1) / 2);
    temp = [];
    [mappedX, error] = tsne(Data,[], 3, 30, i);
    error_3D(i,:) = [i, error];
    fprintf(['Above is 3D graph where parameter = ' num2str(i) ' while error = ' num2str(error) '  <------------!>\n']);
    %disp(['Above is 3D graph where parameter = ' num2str(i) ' while error = ' num2str(error) '  <------------!>']);
    scatter3(mappedX(:,1), mappedX(:,2), mappedX(:,3));
    saveas(gcf,strcat('.\3D_PIC\Raw\Raw_',int2str(i),'.jpg'));
    saveas(gcf,strcat('.\3D_FIG\Raw_',int2str(i),'.fig'));
    csvwrite(strcat('.\3D_MAP\para=',int2str(i),'.csv'),mappedX);
end;
csvwrite('sumD_3D.csv',sumD_3D);
csvwrite('.\Results\error_3D.csv',error_3D);

matlabpool close;

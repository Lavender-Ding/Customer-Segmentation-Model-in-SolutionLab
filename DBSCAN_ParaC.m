clear;
clc;

matlabpool local 12;
tSEN_Data = csvread('.\3D_MAP\para=45.csv');
data = zeros(50,50);

parfor belta = 5:20
    for MinPts = 5:20
        fprintf('Now the system is processing DBSCAN with belta = %d and MinPts with %d\n',belta,MinPts)
        [Idx, Idx_Score] = dbscan(tSEN_Data,belta,MinPts);
        data(belta,MinPts) = length(unique(Idx));
    end;
end;
csvwrite('.\DBSCAN\traversePara.csv',data);
matlabpool close;
tSNE_Data = csvread('.\3D_MAP\para=45.csv');
X = tSNE_Data;
Lx = zeros(1100,1);
Lx(1:100,1) = 2;
Lx(101:1000,1) = 3;
Lx(1001:1100,1) = 1;

k = 17;

figure;
scatter3(X(:,1),X(:,2),X(:,3),'.');
% scatter(X(:,1),X(:,2),[],Lx./k,'.');

% [CENTER, U, OBJ_FCN] = fcm(X, 3);
% L = zeros

ltol = 0.01;
maxiter = 500;
pflag = 1;
Init = [];

% X1 = mapminmax(X,0,1);
% IDX = kmeans(X1, k);
% figure;
% scatter3(X(:,1),X(:,2),X(:,3),[],Ci./k,'.');
% scatter(X1(:,1),X1(:,2),[],IDX./k,'.');


% Inputs:
%   X(n,d) - input data, n=number of observations, d=dimension of variable
%   k - maximum number of Gaussian components allowed
%   ltol - percentage of the log likelihood difference between 2 iterations ([] for none)
%   maxiter - maximum number of iteration allowed ([] for none)
%   pflag - 1 for plotting GM for 1D or 2D cases only, 0 otherwise ([] for none)
%   Init - structure of initial W, M, V: Init.W, Init.M, Init.V ([] for none)
%
% Ouputs:
%   W(1,k) - estimated weights of GM
%   M(d,k) - estimated mean vectors of GM
%   V(d,d,k) - estimated covariance matrices of GM
%   L - log likelihood of estimates

[W,M,V,L,E,Lb] = EM_GM_fast(X,k,ltol,maxiter,pflag,Init);
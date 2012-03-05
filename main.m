% Load files of X and y
function [res_x,res_y,res_AUC,res_lift,res_Beta] = main(topk, type, lambda)
if strcmp(type, 'default')
  fname = 'data/model-default.mat';
elseif strcmp(type,'stop') 
  fname = 'data/model-stemmed.mat';
elseif strcmp(type, 'stem')
  fname = 'data/model-stopwords.mat';
else
  disp('Invalid Arguments')
  return 
end
k=topk;
load(fname);
disp('Data loaded')

% Extract the top-k frequent features
X = Xuniq';
cnts = sum(X);
[dumb, idx] = sort(cnts, 'descend');
topk = idx(1:k);
X = sparse(X(:, topk));
Y = yuniq;

[m,n] = size(X);
lifts = [];
Betas = [];
AUCs = [];

% Start cross validation
iter = 10;
for i = 1:10
  upEnd = int32(m*i*1.0/iter)-1;
  lowEnd = int32(m*(i-1)*1.0/iter)+2;

  XTest = sparse(X(lowEnd:upEnd, :));
  YTest = Y(lowEnd:upEnd, :);
  
  XTrain = sparse(vertcat(X(1:lowEnd-1,:), X(upEnd+1:m,:)));
  YTrain = vertcat(Y(1:lowEnd-1,:), Y(upEnd+1:m,:));
  MA=sparse(XTrain'*XTrain + lambda*speye(n));
  nnz(MA)
  Beta = (MA)\(sparse(XTrain'*YTrain));
  YPred = XTest * Beta;

% Plot curves
  [x,y,t,AUC] = perfcurve((YTest>3), YPred, true);
  AUCs = [AUCs, AUC];
  [dumb, idx] = min(abs(x-.01));
  lifts = [lifts, y(idx)/.01];
  Betas = [Betas Beta];

end

res_x=x;
res_y=y;
res_AUC=mean(AUCs);
res_lift=mean(lifts);
res_Beta=mean(Betas,2);

end

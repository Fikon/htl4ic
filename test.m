%task: integer index of the task, for example 10
function em = runTask(task)

taskStr = int2str(task);

folder = ['./data/' taskStr '/'];
addpath (folder);

loaddata;

load A1.mat;
%A = A2;
load A1Lab
load Z.mat;
%B1 = A2;
F = load('F.txt');
T = load('T.txt');

NB1 = sum(abs(Z),2);
Z = Z ./ repmat(NB1,[1 size(Z,2)]);
i = find(isnan(Z));
Z(i) = zeros(size(i));

i = find(isnan(T));
T(i) = zeros(size(i));

B21 = Z.' * T;
i = find(isnan(B21));
B21(i) = zeros(size(i));

i = find(isnan(F));
F(i) = zeros(size(i));

rc_pairs = [1 2;3 2;4 2]; % 1: image 2: tag 3: doc 4:img feature

params = glmparams(3, 4, rc_pairs, {'gaussian', 'gaussian', 'gaussian'});
params.maxiter = 30;
params.k = 20;

ImageTag = sparse(T);
DocTag = sparse(F);
FeatureTag = sparse(1000*B21);

Xs = {50*ImageTag 50*DocTag 50*FeatureTag};
Ws = {spones(ImageTag) spones(DocTag) 100*spones(FeatureTag)};


params.alphas = [0.25 0.25 0.5];
model = glm(Xs,Ws,params);

U = model{4};
simU = A1*U;

num = 10;

%change to whatever way you like to do svm, if path include is wrong.
[acc, std] = dosvm(simU, A1Lab, num);

% tag view
accs{1} = acc;
stds{1} = std;

savename = ['result' int2str(task) '.mat'];
save(savename, 'accs', 'stds');

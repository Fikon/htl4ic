%task: integer index of the task, for example 10
function em = runTask(task)

taskStr = int2str(task);

folder = ['./data/' taskStr '/'];
addpath (folder);

loaddata;

load A1.mat;
%A = A2;
load A1Lab


num = 10;

%change to whatever way you like to do svm, if path include is wrong.
[acc, std] = dosvm(A1, A1Lab, num);

% tag view
accs{1} = acc;
stds{1} = std;

savename = ['result' int2str(task) '.mat'];
save(savename, 'accs', 'stds');

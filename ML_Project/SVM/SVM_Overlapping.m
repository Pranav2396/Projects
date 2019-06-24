clearvars;
%5 -> a,bA,chA
col=1;
filepath = '.\FeaturesHW\a.ldf';
fid = fopen(filepath);
data = textscan(fid,'%f');
data = data{:};
fid = fclose(fid);
col = max([data; col]);
filepath = '.\FeaturesHW\bA.ldf';
fid = fopen(filepath);
data = textscan(fid,'%f');
data = data{:};
fid = fclose(fid);
col = max([data; col]);
filepath = '.\FeaturesHW\chA.ldf';
fid = fopen(filepath);
data = textscan(fid,'%f');
data = data{:};
fid = fclose(fid);
col = max([data; col]);




filepath = '.\FeaturesHW\a.ldf';
N1 = size(importdata(filepath,'\n'),1);
fid = fopen(filepath);
data = textscan(fid,'%f');
data = data{:};
fid = fclose(fid);
class1 = zeros(N1, 2*col);
pnt = 1;
for i = 1:N1
    temp = 2*data(pnt,1);
    pnt = pnt+1;
    for j=1:temp
        class1(i, j) = data(pnt,1);
        pnt = pnt+1;
    end
end

filepath = '.\FeaturesHW\bA.ldf';
N2 = size(importdata(filepath,'\n'),1);
fid = fopen(filepath);
data = textscan(fid,'%f');
data = data{:};
fid = fclose(fid);
class2 = zeros(N2, 2*col);
pnt = 1;
for i = 1:N2
    temp = 2*data(pnt,1);
    pnt = pnt+1;
    for j=1:temp
        class2(i, j) = data(pnt,1);
        pnt = pnt+1;
    end
end

filepath = '.\FeaturesHW\chA.ldf';
N3 = size(importdata(filepath,'\n'),1);
fid = fopen(filepath);
data = textscan(fid,'%f');
data = data{:};
fid = fclose(fid);
class3 = zeros(N1, 2*col);
pnt = 1;
for i = 1:N3
    temp = 2*data(pnt,1);
    pnt = pnt+1;
    for j=1:temp
        class3(i, j) = data(pnt,1);
        pnt = pnt+1;
    end
end





Ntrain1 = floor(0.7*N1);
Nval1 = floor(0.2*N1);
Ntest1 = N1 - Nval1 - Ntrain1;


Ntrain2 = floor(0.7*N2);
Nval2 = floor(0.2*N2);
Ntest2 = N2 - Nval2 - Ntrain2;

Ntrain3 = floor(0.7*N3);
Nval3 = floor(0.2*N3);
Ntest3 = N3 - Nval3 - Ntrain3;

class1train = (class1(1:Ntrain1,:));
class1val = (class1(1+Ntrain1:Ntrain1+Nval1,:));
class1test = (class1(1+Ntrain1+Nval1:Ntrain1+Nval1+Ntest1,:));

class2train = (class2(1:Ntrain2,:));
class2val = (class2(1+Ntrain2:Ntrain2+Nval2,:));
class2test = (class2(1+Ntrain2+Nval2:Ntrain2+Nval2+Ntest2,:));

class3train = (class3(1:Ntrain3,:));
class3val = (class3(1+Ntrain3:Ntrain3+Nval3,:));
class3test = (class3(1+Ntrain3+Nval3:Ntrain3+Nval3+Ntest3,:));


xtrain = [class1train; class2train; class3train];
xval = [class1val; class2val; class3val];
xtest = [class1test; class2test; class3test];

label_1 = zeros(Ntrain1,1)+1;
label_2 = zeros(Ntrain2,1)+2;
label_3 = zeros(Ntrain3,1)+3;

val_label_1 = zeros(Nval1,1) +1;
val_label_2 = zeros(Nval2,1)+2;
val_label_3 = zeros(Nval3,1)+3;

test_label_1 = zeros(Ntest1,1) +1;
test_label_2 = zeros(Ntest2,1)+2;
test_label_3 = zeros(Ntest3,1)+3;

Ntrain = Ntrain1+Ntrain2+Ntrain3;
Nval = Nval1+Nval2+Nval3;
Ntest = Ntest1+Ntest2+Ntest3;



xlabel = [label_1; label_2; label_3];
val_label_check = [val_label_1; val_label_2; val_label_3];
test_label_check = [test_label_1; test_label_2; test_label_3];

model = svmtrain(xlabel, xtrain,'-s 0 -t 0 ' );

% xtrain = xtest;
% Ntrain = Ntest;
% Ntrain1 = Ntest1;
% Ntrain2 = Ntest2;
% Ntrain3 = Ntest3;
% xlabel = test_label_check;
% xtrain = xval;
% Ntrain = Nval;
% Ntrain1 = Nval1;
% Ntrain2 = Nval2;
% Ntrain3 = Nval3;
% xlabel = val_label_check;
[predict_train, train_accuracy, dec_values] = svmpredict(xlabel, xtrain, model);


%%%%%%%%%%%confusion%%%%%%%%%%%%%%%%%%%%%%%%%%%
conftotal = size(xlabel,1);
count = zeros(3, 3);
for i = 1:conftotal
   count(xlabel(i), predict_train(i)) = count(xlabel(i), predict_train(i)) + 1;
    %count(val_label_check(i), predict_val(i)) = count(val_label_check(i), predict_val(i)) + 1;
    %count(test_label_check(i), predict_test(i)) = count(test_label_check(i), predict_test(i)) + 1;
end    
disp(count);
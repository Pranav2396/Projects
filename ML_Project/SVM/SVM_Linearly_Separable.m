clearvars;
[xtrain1] = textread('.\nonlinearly_separable\class1_train.txt');
[xtrain2] = textread('.\nonlinearly_separable\class2_train.txt');



[Ntrain1, NotRequired] = size(xtrain1);
[Ntrain2, NotRequired] = size(xtrain2);



[xval1] = textread('.\nonlinearly_separable\class1_val.txt');
[xval2] = textread('.\nonlinearly_separable\class2_val.txt');


[Nval1, NotRequired] = size(xval1);
[Nval2, NotRequired] = size(xval2);


[xtest1] = textread('.\nonlinearly_separable\class1_test.txt');
[xtest2] = textread('.\nonlinearly_separable\class2_test.txt');



[Ntest1, NotRequired] = size(xtest1);
[Ntest2, NotRequired] = size(xtest2);


label_1 = zeros(Ntrain1,1) +1;
label_2 = zeros(Ntrain2,1)+2;

val_label_1 = zeros(Nval1,1) +1;
val_label_2 = zeros(Nval2,1)+2;

test_label_1 = zeros(Ntest1,1) +1;
test_label_2 = zeros(Ntest2,1)+2;

Ntrain = Ntrain1+Ntrain2;
Nval = Nval1+Nval2;
Ntest = Ntest1+Ntest2;


xtrain = [xtrain1; xtrain2];
xval = [xval1; xval2];
xtest = [xtest1; xtest2];

xtrain = zscore(xtrain);
xval = zscore(xval);
xtest = zscore(xtest);

xlabel = [label_1; label_2];

val_label_check = [val_label_1; val_label_2];

test_label_check = [test_label_1; test_label_2];

% xtrain = xtest;
% Ntrain = Ntest;
% Ntrain1 = Ntest1;
% Ntrain2 = Ntest2;
% % Ntrain3 = Ntest3;
% xlabel = test_label_check;
% xtrain = xval;
% Ntrain = Nval;
% Ntrain1 = Nval1;
% Ntrain2 = Nval2;
% xlabel = val_label_check;
% 

weightC = 1;
model = svmtrain(xlabel, xtrain,'-s 0 -t 2  -c 1 -g 10' );%model
[predict_train, train_accuracy, dec_values] = svmpredict(xlabel, xtrain, model);

%modulate
%model = svmtrain(xlabel, xtrain,'-s 0 -t 2 -c 0.001 ' );

	

% pomodel = svmtrain(val_label_check, xval,'-s 0 -t 1 -d 15 -g 1' );
% [predict_val, val_accuracy, dec_values] = svmpredict(val_label_check, xval, polymodel);
% 
% polymodel = svmtrain(test_label_check, xtest,'-s 0 -t 1 -d 15 -g 1' );
% [predict_test, test_accuracy, dec_values] = svmpredict(test_label_check, xtest, polymodel);

%gaussmodel = svmtrain(xlabel, xtrain,'-s 0 -t 2' );
%[predict_train, train_accuracy, dec_values] = svmpredict(xlabel, xtrain, gaussmodel);

% gaussmodel = svmtrain(val_label_check, xval,'-s 0 -t 2' );
% [predict_val, val_accuracy, dec_values] = svmpredict(val_label_check, xval, gaussmodel);
% 
% gaussmodel = svmtrain(test_label_check, xtest,'-s 0 -t 2' );
% [predict_test, test_accuracy, dec_values] = svmpredict(test_label_check, xtest, gaussmodel);

% gaussianmodel = svmtrain(xlabel, xtrain,'-s 0 -t 2' );
% [predict_test, test_accuracy, dec_values] = svmpredict(test_label_check, xtest, gaussianmodel);




%%%%%%%%%%%%%%%%%%plot%%%%%%%%%%%
groundTruth = xlabel;
d = xtrain;

figure

% plot training data
hold on;
pos = find(groundTruth==1);
scatter(d(pos,1), d(pos,2), 'r')
pos = find(groundTruth==2);
scatter(d(pos,1), d(pos,2), 'b')


% now plot support vectors
hold on;
sv = full(model.SVs);
% plot(sv(:,1),sv(:,2),'o','MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k', 'MarkerSize',2);
nsv = size(sv, 1);
svbounded = [];
svunbounded = [];

for i = 1:nsv
    if abs(model.sv_coef(i,1)) == weightC
        svbounded = [svbounded; sv(i,:)];
    else
        svunbounded = [svunbounded; sv(i,:)];
    end
end
if(size(svunbounded,1)>0)
plot(svunbounded(:,1),svunbounded(:,2),'o','MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k', 'MarkerSize', 4);
end
if(size(svbounded,1)>0)
plot(svbounded(:,1),svbounded(:,2),'o','MarkerFaceColor', 'y', 'MarkerEdgeColor', 'y', 'MarkerSize', 4);
end
%plot(sv(:,1),sv(:,2),'kx','MarkerSize',12);

% now plot decision area
[xi,yi] = meshgrid([min(d(:,1)):0.01:max(d(:,1))],[min(d(:,2)):0.01:max(d(:,2))]);
dd = [xi(:),yi(:)];
tic;[predicted_label, accuracy, decision_values] = svmpredict(zeros(size(dd,1),1), dd, model);toc
pos = find(predicted_label==1);
hold on;
cyancolor = [1 0.8 0.8];
h1 = plot(dd(pos,1),dd(pos,2),'s','color',cyancolor,'MarkerSize',10,'MarkerEdgeColor',cyancolor,'MarkerFaceColor',cyancolor);
pos = find(predicted_label==2);
hold on;
magentacolor = [0.8 0.8 1];
h2 = plot(dd(pos,1),dd(pos,2),'s','color',magentacolor,'MarkerSize',10,'MarkerEdgeColor',magentacolor,'MarkerFaceColor',magentacolor);

uistack(h1, 'bottom');
uistack(h2, 'bottom');
















conftotal = size(xlabel,1);
count = zeros(2, 2);
for i = 1:conftotal
    count(xlabel(i), predict_train(i)) = count(xlabel(i), predict_train(i)) + 1;
    %count(val_label_check(i), predict_val(i)) = count(val_label_check(i), predict_val(i)) + 1;
    %count(test_label_check(i), predict_test(i)) = count(test_label_check(i), predict_test(i)) + 1;
end    
disp(count);


%model = svmtrain(training_label_vector, training_instance_matrix [, 'libsvm_options']);
%[predicted_label, accuracy, decision_values/prob_estimates] = svmpredict(testing_label_vector, testing_instance_matrix, model [, 'libsvm_options']);
% training_label_vector = [1 2];
% training_instance_matrix = [1 2; 3 4];
% testing_instance_matrix = [1 2; 3 4];
% testing_label_vector = [1 2];
% model = svmtrain(training_label_vector, training_instance_matrix);
% [predicted_label, accuracy] = svmpredict(testing_label_vector, testing_instance_matrix, model);

%[heart_scale_label, heart_scale_inst] = libsvmread('heart_scale');
%model = svmtrain(heart_scale_label, heart_scale_inst, '-c 1 -g 0.07');
%[predict_label, accuracy, dec_values] = svmpredict(heart_scale_label, heart_scale_inst, model); % test the training data
% labels = double(rand(10,1)>0.5);
% data = rand(10,5);
% model = svmtrain(labels, data, '-s 0 -t 2 -c 1 -g 0.1');
% [predict_label, accuracy, dec_values] = svmpredict(labels, data, model);

% 1 -- polynomial: (gamma*u'*v + coef0)^degree
% 2 -- radial basis function: exp(-gamma*|u-v|^2)
%-d degree : set degree in kernel function (default 3)
%-g gamma : set gamma in kernel function (default 1/num_features)
%
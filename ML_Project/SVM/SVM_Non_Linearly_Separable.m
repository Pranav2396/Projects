% % % % % % %Group-5 Coast,Street,Mountain
% % % % % % clearvars;
% % % % % % 
% % % % % % N1 = 360;
% % % % % % N2 = 292;
% % % % % % N3 = 374;
% % % % % % 
% % % % % % Ntrain1 = floor(0.7*N1);
% % % % % % Nval1 = floor(0.2*N1);
% % % % % % Ntest1 = N1 - Nval1 - Ntrain1;
% % % % % % 
% % % % % % 
% % % % % % Ntrain2 = floor(0.7*N2);
% % % % % % Nval2 = floor(0.2*N2);
% % % % % % Ntest2 = N2 - Nval2 - Ntrain2;
% % % % % % 
% % % % % % Ntrain3 = floor(0.7*N3);
% % % % % % Nval3 = floor(0.2*N3);
% % % % % % Ntest3 = N3 - Nval3 - Ntrain3;
% % % % % % 
% % % % % % 
% % % % % % coast_string='.\image_dataset\Features\coast\';
% % % % % % Files=dir('.\image_dataset\Features\coast\');
% % % % % % 
% % % % % % 
% % % % % % class1_cell = cell(N1, 1);
% % % % % % for k=3:length(Files)
% % % % % %    FileNames=Files(k).name;
% % % % % %    fid = fopen(strcat(coast_string,FileNames), 'r');
% % % % % %    class1_cell{k-2, 1} = (fscanf(fid, '%f', [23 Inf]))';
% % % % % %    fclose(fid);
% % % % % % end
% % % % % % 
% % % % % % 
% % % % % % class1train = cell2mat(class1_cell(1:Ntrain1,:));
% % % % % % class1val = cell2mat(class1_cell(1+Ntrain1:Ntrain1+Nval1,:));
% % % % % % class1test = cell2mat(class1_cell(1+Ntrain1+Nval1:Ntrain1+Nval1+Ntest1,:));
% % % % % % 
% % % % % % 
% % % % % % 
% % % % % % 
% % % % % % 
% % % % % % street_string='.\image_dataset\Features\street\';
% % % % % % Files=dir('.\image_dataset\Features\street\');
% % % % % % 
% % % % % % 
% % % % % % class2_cell = cell(N2, 1);
% % % % % % for k=3:length(Files)
% % % % % %    FileNames=Files(k).name;
% % % % % %    fid = fopen(strcat(street_string,FileNames), 'r');
% % % % % %    class2_cell{k-2, 1} = (fscanf(fid, '%f', [23 Inf]))';
% % % % % %    fclose(fid);
% % % % % % end
% % % % % % 
% % % % % % class2train = cell2mat(class2_cell(1:Ntrain2,:));
% % % % % % class2val = cell2mat(class2_cell(1+Ntrain2:Ntrain2+Nval2,:));
% % % % % % class2test = cell2mat(class2_cell(1+Ntrain2+Nval2:Ntrain2+Nval2+Ntest2,:));
% % % % % % 
% % % % % % 
% % % % % % mountain_string='.\image_dataset\Features\mountain\';
% % % % % % Files=dir('.\image_dataset\Features\mountain\');
% % % % % % 
% % % % % % 
% % % % % % class3_cell = cell(N3, 1);
% % % % % % for k=3:length(Files)
% % % % % %    FileNames=Files(k).name;
% % % % % %    fid = fopen(strcat(mountain_string,FileNames), 'r');
% % % % % %    class3_cell{k-2, 1} = (fscanf(fid, '%f', [23 Inf]))';
% % % % % %    fclose(fid);
% % % % % % end
% % % % % % 
% % % % % % class3train = cell2mat(class3_cell(1:Ntrain3,:));
% % % % % % class3val = cell2mat(class3_cell(1+Ntrain3:Ntrain3+Nval3,:));
% % % % % % class3test = cell2mat(class3_cell(1+Ntrain3+Nval3:Ntrain3+Nval3+Ntest3,:));
% % % % % % 
% % % % % % 
% % % % % % xtrain = [class1train; class2train; class3train];
% % % % % % xval = [class1val; class2val; class3val];
% % % % % % xtest = [class1test; class2test; class3test];
% % % % % % 
% % % % % % % xtrain = zscore(xtrain);
% % % % % % % xval = zscore(xval);
% % % % % % % xtest = zscore(xtest);
% % % % % % 
% % % % % % Ntrain1 = size(class1train, 1);
% % % % % % Nval1 = size(class1val, 1);
% % % % % % Ntest1 = size(class1test, 1);
% % % % % % 
% % % % % % 
% % % % % % Ntrain2 = size(class2train, 1);
% % % % % % Nval2 = size(class2val, 1);
% % % % % % Ntest2 = size(class2test, 1);
% % % % % % 
% % % % % % Ntrain3 = size(class3train, 1);
% % % % % % Nval3 = size(class3val, 1);
% % % % % % Ntest3 = size(class3test, 1);
% % % % % % 
% % % % % % 
% % % % % % 
% % % % % % label_1 = zeros(Ntrain1,1)+1;
% % % % % % label_2 = zeros(Ntrain2,1)+2;
% % % % % % label_3 = zeros(Ntrain3,1)+3;
% % % % % % 
% % % % % % val_label_1 = zeros(Nval1,1) +1;
% % % % % % val_label_2 = zeros(Nval2,1)+2;
% % % % % % val_label_3 = zeros(Nval3,1)+3;
% % % % % % 
% % % % % % test_label_1 = zeros(Ntest1,1) +1;
% % % % % % test_label_2 = zeros(Ntest2,1)+2;
% % % % % % test_label_3 = zeros(Ntest3,1)+3;
% % % % % % 
% % % % % % Ntrain = Ntrain1+Ntrain2+Ntrain3;
% % % % % % Nval = Nval1+Nval2+Nval3;
% % % % % % Ntest = Ntest1+Ntest2+Ntest3;
% % % % % % 
% % % % % % 
% % % % % % 
% % % % % % xlabel = [label_1; label_2; label_3];
% % % % % % val_label_check = [val_label_1; val_label_2; val_label_3];
% % % % % % test_label_check = [test_label_1; test_label_2; test_label_3];

model = svmtrain(xlabel, xtrain,'-s 0 -t 1 -d 3 -c 1000' );
% xtrain = xtest;
% Ntrain = Ntest;
% Ntrain1 = Ntest1;
% Ntrain2 = Ntest2;
% Ntrain3 = Ntest3;
% xlabel = test_label_check;
% % temp1 = xtrain;
% % temp2 = Ntrain;
% % temp3 = Ntrain1;
% % temp4 = Ntrain2;
% % temp45 = Ntrain3;
%temp5 = xlabel;
xtrain = xval;
Ntrain = Nval;
Ntrain1 = Nval1;
Ntrain2 = Nval2;
Ntrain3 = Nval3;
xlabel = val_label_check;

[predict_train, train_accuracy, dec_values] = svmpredict(xlabel, xtrain, model);

itr = size(dec_values,1);
p1=0;
p2=0;
p3=0;
image_pred = zeros(itr/36, 1);
image_act = zeros(itr/36, 1)+1;
Ntrain1=Ntrain1/36;
Ntrain2=Ntrain2/36;
Ntrain3=Ntrain3/36;
image_act(Ntrain1+1:(Ntrain1+Ntrain2), 1) = image_act(Ntrain1+1:(Ntrain1+Ntrain2), 1)+1;
image_act((Ntrain1+Ntrain2)+1:itr/36, 1) = image_act((Ntrain1+Ntrain2)+1:itr/36, 1)+2;
for i = 1:itr
    if dec_values(i,1)>0
         p1 = p1+dec_values(i, 1);
    else 
        p2 = p2-dec_values(i, 1);
    end
    if dec_values(i,2)>0
         p1 = p1+dec_values(i, 2);
    else 
        p3 = p3-dec_values(i, 2);
    end
    if dec_values(i,3)>0
         p2 = p2+dec_values(i, 3);
    else 
        p3 = p3-dec_values(i, 3);
    end
    if mod(i,36) == 0
        if p1>p2
            if p1>p3
                image_pred(i/36) = 1;
            else
                image_pred(i/36) = 3;
            end
        else
            if p2>p3
                image_pred(i/36) = 2;
            else
                image_pred(i/36) = 3;
            end
        end        
        p1=0;
        p2=0;
        p3=0;
    end
end
conftotal = size(xlabel,1);
count = zeros(3, 3);
for i = 1:itr/36
    count(image_act(i), image_pred(i)) = count(image_act(i), image_pred(i)) + 1;
    %count(val_label_check(i), predict_val(i)) = count(val_label_check(i), predict_val(i)) + 1;
    %count(test_label_check(i), predict_test(i)) = count(test_label_check(i), predict_test(i)) + 1;
end    
final_accuracy = trace(count)/sum(count(:));
disp('acc');
disp(final_accuracy*100);
xtrain = temp1;
Ntrain = temp2;
Ntrain1 = temp3;
Ntrain2 = temp4;
Ntrain3 = temp45;
xlabel = temp5;
% polymodel = svmtrain(xlabel, xtra in,'-s 0 -t 1 -d 15 -g 1' );
% [predict_test_poly, val_accuracy, dec_values] = svmpredict(test_label_check, xtest, polymodel);


%polymodel = svmtrain(xlabel, xtrain,'-s 0 -t 1 -d 15 -g 1' );
%[predict_train, train_accuracy, dec_values] = svmpredict(xlabel, xtrain, polymodel);

% polymodel = svmtrain(val_label_check, xval,'-s 0 -t 1 -d 15 -g 1' );
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






% conftotal = size(xlabel,1);
% count = zeros(3, 3);
% for i = 1:conftotal
%    count(xlabel(i), predict_train(i)) = count(xlabel(i), predict_train(i)) + 1;
% end    
% disp(count);

% [xtrain1] = textread('.\nonlinearly_separable\class1_train.txt');
% [xtrain2] = textread('.\nonlinearly_separable\class2_train.txt');
% 
% 
% 
% [Ntrain1, NotRequired] = size(xtrain1);
% [Ntrain2, NotRequired] = size(xtrain2);
% 
% 
% 
% [xval1] = textread('.\nonlinearly_separable\class1_val.txt');
% [xval2] = textread('.\nonlinearly_separable\class2_val.txt');
% 
% 
% [Nval1, NotRequired] = size(xval1);
% [Nval2, NotRequired] = size(xval2);
% 
% 
% [xtest1] = textread('.\nonlinearly_separable\class1_test.txt');
% [xtest2] = textread('.\nonlinearly_separable\class2_test.txt');
% 
% 
% 
% [Ntest1, NotRequired] = size(xtest1);
% [Ntest2, NotRequired] = size(xtest2);
% 
% 
% label_1 = zeros(Ntrain1,1) +1;
% label_2 = zeros(Ntrain2,1)+2;
% 
% val_label_1 = zeros(Nval1,1) +1;
% val_label_2 = zeros(Nval2,1)+2;
% 
% test_label_1 = zeros(Ntest1,1) +1;
% test_label_2 = zeros(Ntest2,1)+2;
% 
% Ntrain = Ntrain1+Ntrain2;
% Nval = Nval1+Nval2;
% Ntest = Ntest1+Ntest2;
% 
% 
% xtrain = [xtrain1; xtrain2];
% xval = [xval1; xval2];
% xtest = [xtest1; xtest2];
% 
% xlabel = [label_1; label_2];
% 
% val_label_check = [val_label_1; val_label_2];
% 
% test_label_check = [test_label_1; test_label_2];
% 
% polymodel = svmtrain(xlabel, xtrain,'-s 0 -t 1 -d 15 -g 1' );
% [predict_test_poly, val_accuracy, dec_values] = svmpredict(test_label_check, xtest, polymodel);
% 
% 
% gaussianmodel = svmtrain(xlabel, xtrain,'-s 0 -t 2' );
% [predict_test_gauss, test_accuracy, dec_values] = svmpredict(test_label_check, xtest, gaussianmodel);



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
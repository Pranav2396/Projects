clearvars;
load 'iris_dataset.mat'
%x12 is 2nd column of 1st class.
[x11_train,x12_train]=textread('..\data_assign3_group5\linearly_separable\class1_train.txt','%f %f');
[x11_test,x12_test]=textread('..\data_assign3_group5\linearly_separable\class1_test.txt','%f %f');
[x11_val,x12_val]=textread('..\data_assign3_group5\linearly_separable\class1_val.txt','%f %f');

[x21_train,x22_train]=textread('..\data_assign3_group5\linearly_separable\class2_train.txt','%f %f');
[x21_test,x22_test]=textread('..\data_assign3_group5\linearly_separable\class2_test.txt','%f %f');
[x21_val,x22_val]=textread('..\data_assign3_group5\linearly_separable\class2_val.txt','%f %f');

[x31_train,x32_train]=textread('..\data_assign3_group5\linearly_separable\class3_train.txt','%f %f');
[x31_test,x32_test]=textread('..\data_assign3_group5\linearly_separable\class3_test.txt','%f %f');
[x31_val,x32_val]=textread('..\data_assign3_group5\linearly_separable\class3_val.txt','%f %f');

[x41_train,x42_train]=textread('..\data_assign3_group5\linearly_separable\class4_train.txt','%f %f');
[x41_test,x42_test]=textread('..\data_assign3_group5\linearly_separable\class4_test.txt','%f %f');
[x41_val,x42_val]=textread('..\data_assign3_group5\linearly_separable\class4_val.txt','%f %f');

[Ntrain1,nq]=size(x11_train);
[Ntest1,nq]=size(x11_test);
[Nval1,nq]=size(x11_val);

[Ntrain2,nq]=size(x21_train);
[Ntest2,nq]=size(x21_test);
[Nval2,nq]=size(x21_val);

[Ntrain3,nq]=size(x31_train);
[Ntest3,nq]=size(x31_test);
[Nval3,nq]=size(x31_val);

[Ntrain4,nq]=size(x41_train);
[Ntest4,nq]=size(x41_test);
[Nval4,nq]=size(x41_val);

 N=Ntrain1+Ntrain2+Ntrain3+Ntrain4;

 X1_train=[x11_train,x12_train];
 X2_train=[x21_train,x22_train];
 X3_train=[x31_train,x32_train];
 X4_train=[x41_train,x42_train];

 X1_test=[x11_test,x12_test];
 X2_test=[x21_test,x22_test];
 X3_test=[x31_test,x32_test];
 X4_test=[x41_test,x42_test];
 
 Y1_train=zeros(Ntrain1,1);
 Y2_train=zeros(Ntrain2,1);
 Y3_train=zeros(Ntrain3,1);
 Y4_train=zeros(Ntrain4,1);
 
 for i=1:Ntrain1 Y1_train(i)=1; end
 for i=1:Ntrain2 Y2_train(i)=2; end
 for i=1:Ntrain3 Y3_train(i)=3; end
 for i=1:Ntrain4 Y4_train(i)=4; end
 
 for i=1:Ntest1 Y1_test(i)=1; end
 for i=1:Ntest2 Y2_test(i)=2; end
 for i=1:Ntest3 Y3_test(i)=3; end
 for i=1:Ntest4 Y4_test(i)=4; end

 
a = [1 0 0 0]';
b = [0 1 0 0]';
c = [0 0 1 0]';
d = [0 0 0 1]';

 x=[X1_train' X2_train' X3_train' X4_train'];
 x1=[X1_test' X2_test' X3_test' X4_test'];
 
 T = [repmat(a,1,length(X1_train)) repmat(b,1,length(X2_train)) ...
      repmat(c,1,length(X3_train)) repmat(d,1,length(X4_train))];

%net=feedforwardnet([10 10]); %MSE
net=patternnet([3 3]); %Cross-entropy
net = train(net,x,T);
net.trainFcn = 'traingdm';
y = net(x);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%TESTING%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
predicted1=zeros(Ntest1,1);
predicted2=zeros(Ntest2,1);
predicted3=zeros(Ntest3,1);
predicted4=zeros(Ntest4,1);

y1=net(x1);
for i=1:400
  xx=y1(:,i);
  [mm,ind]=max(xx);
  
  if(i<=100) predicted1(i)=ind;end
  if(i>100 && i<=200) predicted2(i-100)=ind; end
  if(i>200 && i<=300) predicted3(i-200)=ind; end
  if(i>300) predicted4(i-300)=ind; end
end


%Computing confusion matrix.
confusion_matrix=zeros(4,4);
for i=1:Ntest1
  confusion_matrix(1,predicted1(i,1))=confusion_matrix(1,predicted1(i,1))+1;
end

for i=1:Ntest2
  confusion_matrix(2,predicted2(i,1))=confusion_matrix(2,predicted2(i,1))+1;
end

for i=1:Ntest3
  confusion_matrix(3,predicted3(i,1))=confusion_matrix(3,predicted3(i,1))+1;
end

for i=1:Ntest4
  confusion_matrix(4,predicted4(i,1))=confusion_matrix(4,predicted4(i,1))+1;
end

disp(confusion_matrix);

accuracy=double((confusion_matrix(4,4)+confusion_matrix(1,1)+confusion_matrix(2,2)+confusion_matrix(3,3)))/4;
disp(accuracy);
% 
% %%%%%%%%PLOTTING%%%%%%%%%%%%%%%
% xrange = [-15 20];
% yrange = [-15 20];
% inc = 0.1;
% [g, h] = meshgrid(xrange(1):inc:xrange(2), yrange(1):inc:yrange(2));
% image_size = size(g);
% xy = [g(:) h(:)];
% xy = [reshape(g, image_size(1)*image_size(2),1) reshape(h, image_size(1)*image_size(2),1)];
% Ntest=length(xy);
% 
% predicted=zeros(Ntest,1);
% for i=1:Ntest
%   xx=xy(i,:);
%   p = [xx(1);xx(2)];
%   tp=net(p)';
%   
%   [mm,ind]=max(tp);
%   predicted(i)=ind;
%   disp(i);
% end
% 
% decisionmap = reshape(predicted, image_size);
% 
% figure;
% imagesc(xrange,yrange,decisionmap);
% 
% hold on
% set(gca,'ydir','normal');
% cmap = [0.7 1 0.7;0.9 0.9 1;1 0.7 1;1 0.8 0.8];
% colormap(cmap);
% 
% scatter(x11_train,x12_train,'g');
% scatter(x21_train,x22_train,'b');
% scatter(x31_train,x32_train,'m');
% scatter(x41_train,x42_train,'r');
% hold off

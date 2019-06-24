clearvars;
load 'nn_nl1.mat'
%x12 is 2nd column of 1st class.
[x11_train,x12_train]=textread('..\data_assign3_group5\nonlinearly_separable\class1_train.txt','%f %f');
[x11_test,x12_test]=textread('..\data_assign3_group5\nonlinearly_separable\class1_test.txt','%f %f');
[x11_val,x12_val]=textread('..\data_assign3_group5\nonlinearly_separable\class1_val.txt','%f %f');

[x21_train,x22_train]=textread('..\data_assign3_group5\nonlinearly_separable\class2_train.txt','%f %f');
[x21_test,x22_test]=textread('..\data_assign3_group5\nonlinearly_separable\class2_test.txt','%f %f');
[x21_val,x22_val]=textread('..\data_assign3_group5\nonlinearly_separable\class2_val.txt','%f %f');

[Ntrain1,nq]=size(x11_train);
[Ntest1,nq]=size(x11_test);
[Nval1,nq]=size(x11_val);

[Ntrain2,nq]=size(x21_train);
[Ntest2,nq]=size(x21_test);
[Nval2,nq]=size(x21_val);

 N=Ntrain1+Ntrain2;

 X1_train=[x11_train,x12_train];
 X2_train=[x21_train,x22_train];

 X1_test=[x11_test,x12_test];
 X2_test=[x21_test,x22_test];
 
 Y1_train=zeros(Ntrain1,1);
 Y2_train=zeros(Ntrain2,1);
 
 for i=1:Ntrain1 Y1_train(i)=1; end
 for i=1:Ntrain2 Y2_train(i)=2; end
 
 for i=1:Ntest1 Y1_test(i)=1; end
 for i=1:Ntest2 Y2_test(i)=2; end
 
a = [1 0]';
b = [0 1]';

 x=[X1_train' X2_train'];
 xtest=[X1_test' X2_test'];
 
 T = [repmat(a,1,length(X1_train)) repmat(b,1,length(X2_train))];

%net=feedforwardnet([10 10]); %MSE

h_size=11;
net=patternnet([h_size h_size]); %Cross-entropy

net = configure(net,x,T);


 C1=net.IW;
C2=net.LW;
C3=net.b;
%  net.IW=C1;
%  net.LW=C2;
%  net.b=C3;
 
 %net.divideFcn='divideint';
 net.trainFcn = 'traingdm';
 
 net.trainParam.epochs = 10000;
 net.trainParam.goal=0.0;
 net.trainParam.min_grad=1e-10;
 net.trainParam.mc=0.1;
 net.trainParam.lr=0.4;

 net = train(net,x,T);
y1=net(x);
y = net(xtest);

weight_arr1=cell2mat(net.IW(1,1));
bias_arr1=cell2mat(net.b(1,1));

%%Computing output of H1 nodes.
[xn xsettings] = mapminmax(x);
 [tn tsettings]  = mapminmax(T);
 b1  = cell2mat(net.b(1));
 IW = cell2mat(net.IW);
 [ I N ]  = size(xn);
 B1  = b1*ones(1,N);
 % B1 = repmat(b,1,N);             % Alternate
 temp=tanh(B1+IW*xn);
 
 LW = cell2mat(net.LW(2,1));        
 b2 = cell2mat(net.b(2));      
 
 h1=zeros(h_size,1);
 h2=zeros(h_size,1);
 
 for i=1:h_size
   vec=temp(i,:);
   h1(i,1)=mean(vec);
 end
h2=tanh(b2 + LW*h1);

LW1 = cell2mat(net.LW(3,2));        
b3 = cell2mat(net.b(3));

o1=b3+LW1*h2;
o1(1,1)=exp(o1(1,1))/(exp(o1(1,1))+exp(o1(2,1)));
o1(2,1)=exp(o1(2,1))/(exp(o1(1,1))+exp(o1(2,1)));
 
%%%%%%%%%%%%%%%%%%%TESTING%%%%%%%%
%%%%%
predicted=zeros(520,1);

predicted11=zeros(260,1);
predicted11(:,1)=2;
predicted21=zeros(260,1);
predicted21(:,1)=1;

count=0;
for i=1:520
  xx=y(:,i);
  [mm,ind]=max(xx);
  predicted(i)=ind;
  if(i<=260 && ind==1) predicted11(i,1)=ind;count=count+1;end
  if(i>260 && ind==2)  predicted21(i-260,1)=ind;count=count+1;end
end
 
%Computing confusion matrix.
confusion_matrix=zeros(2,2);
for i=1:Ntest1
  confusion_matrix(1,predicted11(i,1))=confusion_matrix(1,predicted11(i,1))+1;
end

for i=1:Ntest2
  confusion_matrix(2,predicted21(i,1))=confusion_matrix(2,predicted21(i,1))+1;
end


disp(confusion_matrix);


  disp(double(count)*100/520);
% %%%%%%%%PLOTTING%%%%%%%%%%%%%%%
% xrange = [-h_size 20];
% yrange = [-h_size 20];
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
% cmap = [0.7 1 0.7;0.9 0.9 1];
% colormap(cmap);
% 
% scatter(x11_train,x12_train,'g');
% scatter(x21_train,x22_train,'b');
% hold off

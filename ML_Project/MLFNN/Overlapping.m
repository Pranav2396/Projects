load('image_train_poly');
a = [1 0 0]';
b = [0 1 0]';
c = [0 0 1]';

t1=zeros(3,13464);
for i=1:13464
    t1(:,i)=a;
end

t2=zeros(3,12960);
for i=1:12960
    t2(:,i)=b;
end

t3=zeros(3,10512);
for i=1:10512
    t3(:,i)=c;
end

x=[class1' class2' class3'];
T=horzcat(t1,t2,t3);

h_size=150;
net=patternnet([h_size h_size]); %Cross-entropy
net.trainFcn = 'traingdm';
net.trainParam.epochs = 10000;
net.trainParam.goal=0.0;
net.trainParam.min_grad=1e-10;
net.trainParam.mc=0.1;

net = train(net,x,T);
y = net(x);

predicted=zeros(36936,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%TESTING%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
predicted1=zeros(Ntest1,1);
predicted2=zeros(Ntest2,1);
predicted3=zeros(Ntest3,1);

mt='..\data_assign3_group5\image_dataset\image_dataset\Features\mountain\test\';
Files=dir('..\data_assign3_group5\image_dataset\image_dataset\Features\mountain\test\');  
for t=3:length(Files)
  FileNames=Files(t).name;
  temp=strcat(mt,FileNames);
  temp111=importdata(temp);
  y=net(temp111');
  
    arr1=zeros(3,1);
    for j=1:size(y,2)
         arr1(1)=arr1(1)+log(y(1,j));
    end 
    
    for j=1:size(y,2)
         arr1(2)=arr1(2)+log(y(2,j));
    end 
    
    for j=1:size(y,2)
         arr1(3)=arr1(3)+log(y(3,j));
    end 
    [mm,ind]=max(arr1);
    predicted1(t-2,1)=ind;
end
disp('Test 1 complete');

%%class2
mt='..\data_assign3_group5\image_dataset\image_dataset\Features\coast\test\';
Files=dir('..\data_assign3_group5\image_dataset\image_dataset\Features\coast\test\');  
for t=3:length(Files)
  FileNames=Files(t).name;
  temp=strcat(mt,FileNames);
  temp111=importdata(temp);
  y=net(temp111');
  
    arr1=zeros(3,1);
    for j=1:size(y,2)
         arr1(1)=arr1(1)+log(y(1,j));
    end 
    
    for j=1:size(y,2)
         arr1(2)=arr1(2)+log(y(2,j));
    end 
    
    for j=1:size(y,2)
         arr1(3)=arr1(3)+log(y(3,j));
    end 
    [mm,ind]=max(arr1);
    predicted2(t-2,1)=ind;
end
disp('Test 2 complete');

%%class 3
mt='..\data_assign3_group5\image_dataset\image_dataset\Features\street\test\';
Files=dir('..\data_assign3_group5\image_dataset\image_dataset\Features\street\test\');  
for t=3:length(Files)
  FileNames=Files(t).name;
  temp=strcat(mt,FileNames);
  temp111=importdata(temp);
  y=net(temp111');
  
    arr1=zeros(3,1);
    for j=1:size(y,2)
         arr1(1)=arr1(1)+log(y(1,j));
    end 
    
    for j=1:size(y,2)
         arr1(2)=arr1(2)+log(y(2,j));
    end 
    
    for j=1:size(y,2)
         arr1(3)=arr1(3)+log(y(3,j));
    end 
    [mm,ind]=max(arr1);
    predicted3(t-2,1)=ind;
end
disp('Test 3 complete');

%Computing confusion matrix.
confusion_matrix=zeros(3,3);
for i=1:Ntest1
  confusion_matrix(1,predicted1(i,1))=confusion_matrix(1,predicted1(i,1))+1;
end

for i=1:Ntest2
  confusion_matrix(2,predicted2(i,1))=confusion_matrix(2,predicted2(i,1))+1;
end

for i=1:Ntest3
  confusion_matrix(3,predicted3(i,1))=confusion_matrix(3,predicted3(i,1))+1;
end

disp(confusion_matrix);

accuracy=double((confusion_matrix(1,1)+confusion_matrix(2,2)+confusion_matrix(3,3))*100)/(Ntest1+Ntest2+Ntest3);
disp(accuracy);
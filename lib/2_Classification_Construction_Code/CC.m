function [output_test,Pre_Labels,Model,T,output_train,Accuracy]=CC_C(train_data,train_target,test_data,test_target,orderchain)
 disp('CC method');
 [num_class,num_test]=size(test_target);
 [num_class,num_train]=size(train_target);

 output_test=zeros(num_class,num_test);
 output_train=zeros(num_class,num_train);
 Accuracy = zeros(7,1);
 t = 2;
 gamma = 0.2;
 cost = 10;
 str = ['-t ',num2str(t),' -g ',num2str(gamma),' -c ',num2str(cost),'-b 1 -v 10'];

 x=1:num_class;
 % random order
if strcmp(orderchain,'random')
    x=x(randperm(length(x)));
    cc_order = x;
end
Model.num=cc_order;
 % train
 for i = 1:num_class
    eval(['Model.model_' num2str(i) ' = svmtrain(train_target(cc_order(i),:)'',train_data,str);']);
    train_data=[train_data,train_target(cc_order(i),:)'];
 end          
% test
 train_data_2 = train_data;
 for i = 1:num_class
     % testing set
     eval(['[predict_label, accuracy, dec_values] = svmpredict(test_target(cc_order(i),:)'', test_data, Model.model_' num2str(i) ');']);
     dec_values = dec_values';
     eval(['if(Model.model_' num2str(i) '.Label(1)==1) output_test(cc_order(i),:) = dec_values(1,:); else output_test(cc_order(i),:)=-dec_values(1,:); end']);
     for j = 1:num_test
         if output_test(cc_order(i),j)<0 
             dec_values(1,j)=-1;
         else
             dec_values(1,j)=1;
         end;
     end
     test_data = [test_data,dec_values(1,:)'];
     Accuracy(i,:) = accuracy(1,1);
     clear dec_values
     % training set
     eval(['[predict_label, accuracy, dec_values] = svmpredict(train_target(cc_order(i),:)'', train_data_2, Model.model_' num2str(i) ');']);
     dec_values = dec_values';
     eval(['if(Model.model_' num2str(i) '.Label(1)==1) output_train(cc_order(i),:) = dec_values(1,:); else output_train(cc_order(i),:)=-dec_values(1,:); end']);
     for j = 1:num_train
         if output_train(cc_order(i),j)<0 
             dec_values(1,j)=-1;
         else
             dec_values(1,j)=1;
         end;
     end
     train_data_2 = [train_data_2,dec_values(1,:)'];
     clear dec_values
 end
T = getT(output_train,train_target);

% get label set
for i = 1:length(test_data)
    output_i = output_test(:,i);

    prelabel_1 = -zeros(1,7);
    prelabel_2 = -zeros(1,7);

    [maximum,index]=max(output_i);
     % Top criterion
     if(max(output_i) <= 0) 
         prelabel_1(index)=1;
     else
         prelabel_1(output_i>0)=1;
     end

      % using threshold
      prelabel_2(maximum-output_i<T)=1;
      Pre_Labels(i,:) = prelabel_1 & prelabel_2;
end

Pre_Labels = single(Pre_Labels);
Pre_Labels(Pre_Labels==0)=-1;
Pre_Labels = Pre_Labels';

clc;clear;
image_state_txt = dir('./data/1_Image_State_Results/');
imagestate_dataset = [];
num_image = size(image_state_txt,1);
stats = zeros( num_image-2, 3);




dataset =load('./data/01_Data_Screen/SLFs_feature_10db.mat');
SLFs = dataset.SLFs_feature;
dataset =load('./data/01_Data_Screen/Feat_scale_1_phase.mat');
addition_Feat_scale_1_phase = dataset.Feat_scale_1_phase;
dataset =load('./data/01_Data_Screen/Feat_scale_2_phase.mat');
addition_Feat_scale_2_phase = dataset.Feat_scale_2_phase;
dataset =load('./data/01_Data_Screen/Feat_scale_3_phase.mat');
addition_Feat_scale_3_phase = dataset.Feat_scale_3_phase;
dataset =load('./data/01_Data_Screen/Feat_scale_4_phase.mat');
addition_Feat_scale_4_phase = dataset.Feat_scale_4_phase;
dataset =load('./data/01_Data_Screen/Feat_scale_5_phase.mat');
addition_Feat_scale_5_phase = dataset.Feat_scale_5_phase;


target = load('./data/01_Data_Screen/matrix_target_dataset.mat');
Target = target.matrix_target_dataset;
str_Target = load('./data/01_Data_Screen/dataset_target_1.mat');
sda_str_Target = str_Target.dataset_target_1;

data = [];
SLFs_datasets = getfield(SLFs,'db1');
data = [SLFs_datasets addition_Feat_scale_1_phase addition_Feat_scale_2_phase addition_Feat_scale_3_phase addition_Feat_scale_4_phase addition_Feat_scale_5_phase];

for i = 3:num_image
     imagestate_dir = getfield(image_state_txt(i,1), 'name');
    file_path = ['./data/1_Image_State_Results/' imagestate_dir];
    fid=fopen(file_path,'r');  stat = fread(fid);  fclose(fid);
    stat(end)=[];  stat=char(stat)';  stat=str2num(stat);
    stats(i-2,:) = stat;
end
tmp=isnan(data);
data_column=size(data,1);
tmpp=zeros(length(data),1);
%for i=1:3240
for i=1:data_column        
   tmpp(i) = sum(tmp(i,:));
end
ind_data=find(tmpp~=0);
data(ind_data,:) = [];
stats(ind_data,:) = [];
Target(:,ind_data) = [];
sda_str_Target(ind_data) = [];
ind = find(stats(:,1)>13);
data(ind,:) = [];
stats(ind) = [];
Target(:,ind) = [];
sda_str_Target(ind) = [];
foldNum = 5;
load_result = load('./data/01_Data_Screen/guiding.mat');
indices = load_result.indices;
addition_Feat_scale_1_phase(ind_data,:) = [];addition_Feat_scale_1_phase(ind,:) = [];
addition_Feat_scale_2_phase(ind_data,:) = [];addition_Feat_scale_2_phase(ind,:) = [];
addition_Feat_scale_3_phase(ind_data,:) = [];addition_Feat_scale_3_phase(ind,:) = [];
addition_Feat_scale_4_phase(ind_data,:) = [];addition_Feat_scale_4_phase(ind,:) = [];
addition_Feat_scale_5_phase(ind_data,:) = [];addition_Feat_scale_5_phase(ind,:) = [];
data_db_num = {'db1','db2','db3','db4','db5','db6','db7','db8','db9','db10'};
for db_num = 1:length(data_db_num)
    SLFs_datasets = getfield(SLFs,data_db_num{db_num});
    SLFs_datasets(ind_data,:) = [];SLFs_datasets(ind,:) = [];
    cchain_method_list = {'random'};
    cmethod_list = {'SLFs_phase_scale_1','SLFs_phase_scale_2','SLFs_phase_scale_3','SLFs_phase_scale_4','SLFs_phase_scale_5'};
    for CC_chain_num = 1:length(cchain_method_list)
        order_chain = cchain_method_list{CC_chain_num};
        for CC_method_num = 1:length(cmethod_list)
            cmethod = cmethod_list{CC_method_num};
            if strcmp(cmethod,'SLFs')
                handld_data = SLFs_datasets(:,2:841);
            end
            if strcmp(cmethod,'SLFs_phase_scale_1')
                handld_data = [SLFs_datasets(:,2:841) addition_Feat_scale_1_phase];
            end
            if strcmp(cmethod,'SLFs_phase_scale_2')
                handld_data = [SLFs_datasets(:,2:841) addition_Feat_scale_2_phase];
                        end
           if strcmp(cmethod,'SLFs_phase_scale_3')
                handld_data = [SLFs_datasets(:,2:841) addition_Feat_scale_3_phase];
           end
            if strcmp(cmethod,'SLFs_phase_scale_4')
                handld_data = [SLFs_datasets(:,2:841) addition_Feat_scale_4_phase];
                        end
           if strcmp(cmethod,'SLFs_phase_scale_5')
                handld_data = [SLFs_datasets(:,2:841) addition_Feat_scale_5_phase];
           end
            signal_subset_accuracy_all = 0;
            multi_subset_accuracy_all = 0;
            subset_accuracy_all = 0;
            accuracy_all = 0;
            multi_accuracy = 0;signal_accuracy = 0;
            recall_all = 0;
            precision_all = 0;
            label_accuracy_all = 0;
            average_label_accuracy_all = 0;
            model_save = [];    model_save{foldNum} = [];
            IDX_SDA = [];    IDX_SDA{foldNum} = [];
            signal_subset_accuracy_save = [];signal_subset_accuracy_save{foldNum} = [];multi_subset_accuracy_save = [];multi_subset_accuracy_save{foldNum} = [];
            train_data_save = [];    train_data_save{foldNum} = [];
            test_data_save = [];    test_data_save{foldNum} = [];
            traintarget_save = [];    traintarget_save{foldNum} = [];
            testtarget_save = [];    testtarget_save{foldNum} = [];
            subset_accuracy_save = [];    subset_accuracy_save{foldNum} = [];
            accuracy_save = [];    accuracy_save{foldNum} = [];
            recall_save = [];    recall_save{foldNum} = [];
            precision_save = [];    precision_save{foldNum} = [];
            label_accuracy_save = [];    label_accuracy_save{foldNum} = [];
            average_label_accuracy_save = [];    average_label_accuracy_save{foldNum} = [];
            subset_accuracy_divide_all = [];subset_accuracy_divide_all{foldNum} = [];
            outputs_test_save = [];outputs_test_save{foldNum} = [];
            outputs_traint_save = [];outputs_traint_save{foldNum} = [];
            accuracy_save = [];accuracy_save{foldNum} = [];
            u= [1,2,3,4,5,6,7];
            for i = 1:foldNum
                test_num = (indices == i);
                train_num = ~test_num; 
                traindata = handld_data(train_num,:);
                traintarget = Target(:,train_num); 
                testdata = handld_data(test_num,:);
                testtarget = Target(:,test_num);
                [train_data,test_data] = featnorm( traindata, testdata);
                train_data = double( train_data*2-1);
                test_data = double(test_data*2-1);
                dataset_str_sda = sda_str_Target(1,train_num);
                for sda_i=1:length(u)
                     temp1_sda = train_data( dataset_str_sda==u(sda_i), :);
                     feat{u(sda_i)} = temp1_sda;
                end     
                 logfilename = ['./lib/6_SDA_Results/',order_chain,'_',cmethod,'_',data_db_num{db_num},num2str(i),'.mat'];
                 idx_sda  = ml_stepdisc( feat,logfilename);
                 outputs_test_all = 0;outputs_train_all = 0;
                 if strcmp(order_chain,'random')
                     [outputs_test,Pre_Labels,model,T,outputs_train,accuracy_2]=CC(train_data(:,idx_sda),traintarget,test_data(:,idx_sda),testtarget,order_chain);
                      [subset_accuracy,signal_subset_accuracy,multi_subset_accuracy] = S_accuracy(Pre_Labels,testtarget);
                 end
                 IDX_SDA{i} = idx_sda;
                 train_data_save{i} = train_data;traintarget_save{i} = traintarget;test_data_save{i} = test_data;testtarget_save{i} = testtarget;
                 model_save{i} = model;
                 subset_accuracy_save{i} = subset_accuracy; 
                 signal_subset_accuracy_save{i} =signal_subset_accuracy;    multi_subset_accuracy_save{i} =multi_subset_accuracy;
                 train_data_save{i} = train_data(:,:);
                 test_data_save{i} = test_data(:,:);
                 traintarget_save{i} = traintarget(:,:); 
                 testtarget_save{i} = testtarget(:,:);
                 
                  outputs_test_save{i} = outputs_test(:,:);
                outputs_traint_save{i} = outputs_train(:,:);

                 subset_accuracy_all = subset_accuracy_all+subset_accuracy;
                 multi_subset_accuracy_all = multi_subset_accuracy + multi_subset_accuracy_all;
                 signal_subset_accuracy_all = signal_subset_accuracy + signal_subset_accuracy_all;
            end 
            multi_accuracy = multi_subset_accuracy_all/foldNum;
            signal_accuracy = signal_subset_accuracy_all/foldNum;
            subset_accuracy = subset_accuracy_all/foldNum;
            save_path_all = ['./lib/7_Classification_Results/',order_chain,'_',cmethod,'_',data_db_num{db_num},'.mat'];
            save(save_path_all,'indices','outputs_test','outputs_train','subset_accuracy',...
            'outputs_traint_save','outputs_test_save',...
            'subset_accuracy_divide_all','IDX_SDA','model_save',...
            'signal_subset_accuracy_save','multi_subset_accuracy_save',...
            'subset_accuracy_save',...
            'train_data_save','traintarget_save','test_data_save','testtarget_save','T');
       end
    end
end
classify_orientation;
classify_energy;

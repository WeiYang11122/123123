clc;clear;
data_db_num = {'db1','db2','db3','db4','db5','db6','db7','db8','db9','db10'}; 

cchain_method_list = {'random'};
%
outputs_test_save = [];
target_test_save = [];target_train_save= [];

all_target_test_save = [];

temp = [];train_temp = [];
subset_accuracy_list = [];signal_subset_accuracy_list = [];multi_subset_accuracy_list = [];subset_accuracy_list_1 = [];
all_outputs_train_1=0;all_outputs_train_0=0;
all_outputs_train_2=0;
all_outputs_train_3=0;
all_outputs_test_1=0;all_outputs_test_0=0;
all_outputs_test_2=0;
all_outputs_test_3=0;
 for fold = 1:5
    dir_files = ['./lib/7_Classification_Results/random_SLFs_phase_scale_1_db1.mat'];
    data = load(dir_files);
     temp = [temp data.outputs_test_save{1, fold}];
     train_temp = [train_temp data.outputs_traint_save{1, fold}];
     target_test_save = [target_test_save data.testtarget_save{1,  fold}];
     target_train_save = [target_train_save data.traintarget_save{1,  fold}];
 end

 
 
all_outputs_test_save_0 = zeros(size(temp,1),size(temp,2));
all_outputs_train_save_0 = zeros(size(train_temp,1),size(train_temp,2));
 
all_outputs_test_save_1 = zeros(size(temp,1),size(temp,2));
all_outputs_train_save_1 = zeros(size(train_temp,1),size(train_temp,2));

all_outputs_train_save_2 = zeros(size(train_temp,1),size(train_temp,2));
all_outputs_test_save_2 = zeros(size(temp,1),size(temp,2));

all_outputs_train_save_3 = zeros(size(train_temp,1),size(train_temp,2));
all_outputs_test_save_3 = zeros(size(temp,1),size(temp,2));
for db_num = 1:10


    cmethod_list = {'SLFs_energy_scale_1','SLFs_energy_scale_2','SLFs_energy_scale_3','SLFs_energy_scale_4','SLFs_energy_scale_5'};
    all_outputs_train_save_1 = 0;all_outputs_test_save_1=0;
    for j = 1:length(cchain_method_list)
        for q = 1:length(cmethod_list)
            dir_files = ['./lib/7_Classification_Results/' cchain_method_list{j}  '_' cmethod_list{q} '_' data_db_num{db_num} '.mat'];
            data = load(dir_files);
            outputs_test_save = [];outputs_train_save = [];
            for fold = 1:5
                outputs_test_save = [outputs_test_save data.outputs_test_save{1, fold}];
                outputs_train_save = [outputs_train_save data.outputs_traint_save{1, fold}];
            end
            all_outputs_train_save_1 = all_outputs_train_save_1 + outputs_train_save(:,:);
            all_outputs_test_save_1 =all_outputs_test_save_1+ outputs_test_save(:,:);
        end
    end
    final_outputs_train_save_1 = all_outputs_train_save_1/size(cmethod_list,2);
    final_target_test_save_1 = all_outputs_test_save_1/size(cmethod_list,2);

    cchain_method_list = {'random'};
    cmethod_list = {'SLFs_phase_scale_1','SLFs_phase_scale_2','SLFs_phase_scale_3','SLFs_phase_scale_4','SLFs_phase_scale_5'};
    all_outputs_train_save_2 = 0;all_outputs_test_save_2=0;
    for j = 1:length(cchain_method_list)
        for q = 1:length(cmethod_list)
            dir_files = ['./lib/7_Classification_Results/' cchain_method_list{j}  '_' cmethod_list{q} '_' data_db_num{db_num} '.mat'];
            data = load(dir_files);
            outputs_test_save = [];outputs_train_save = [];
            for fold = 1:5
                outputs_test_save = [outputs_test_save data.outputs_test_save{1, fold}];
                outputs_train_save = [outputs_train_save data.outputs_traint_save{1, fold}];
            end
            all_outputs_train_save_2 = all_outputs_train_save_2 + outputs_train_save(:,:);
            all_outputs_test_save_2 =all_outputs_test_save_2+ outputs_test_save(:,:);
        end
    end
    final_outputs_train_save_2 =  all_outputs_train_save_2/size(cmethod_list,2);
    final_target_test_save_2 =  all_outputs_test_save_2/size(cmethod_list,2);

    
    cchain_method_list = {'random'};
    cmethod_list = {'SLFs_orientation_scale_1','SLFs_orientation_scale_2','SLFs_orientation_scale_3','SLFs_orientation_scale_4','SLFs_orientation_scale_5'};
    all_outputs_train_save_3 = 0;all_outputs_test_save_3=0;
    for j = 1:length(cchain_method_list)
        for q = 1:length(cmethod_list)
            dir_files = ['./lib/7_Classification_Results/' cchain_method_list{j}  '_' cmethod_list{q} '_' data_db_num{db_num}  '.mat'];
            data = load(dir_files);
            outputs_test_save = [];outputs_train_save = [];
            for fold = 1:5
                outputs_test_save = [outputs_test_save data.outputs_test_save{1, fold}];                    
                outputs_train_save = [outputs_train_save data.outputs_traint_save{1, fold}];
            end
            all_outputs_train_save_3 = all_outputs_train_save_3 + outputs_train_save(:,:);
            all_outputs_test_save_3 =all_outputs_test_save_3+ outputs_test_save(:,:);
        end
    end
    final_target_test_save_3 =  all_outputs_test_save_3/size(cmethod_list,2);
    final_outputs_train_save_3 = all_outputs_train_save_3/size(cmethod_list,2);
  
    all_outputs_train_1 = all_outputs_train_1 + final_outputs_train_save_1;
    all_outputs_train_2 = all_outputs_train_2 + final_outputs_train_save_2;
    all_outputs_train_3 = all_outputs_train_3 + final_outputs_train_save_3;
    all_outputs_test_1 = all_outputs_test_1 + final_target_test_save_1;
    all_outputs_test_2 = all_outputs_test_2 + final_target_test_save_2;
    all_outputs_test_3 = all_outputs_test_3 + final_target_test_save_3;
    [ subset_accuracy,signal_subset_accuracy,multi_subset_accuracy ] = get_result_mul_1( final_outputs_train_save_1,final_outputs_train_save_2 ,final_outputs_train_save_3,final_target_test_save_1,final_target_test_save_2,final_target_test_save_3,target_train_save,target_test_save,0.43)
    subset_accuracy_list = [subset_accuracy_list subset_accuracy];
    signal_subset_accuracy_list = [signal_subset_accuracy_list signal_subset_accuracy];
    multi_subset_accuracy_list = [multi_subset_accuracy_list multi_subset_accuracy];
    clear Pre_Labels;
end
disp('The subset accuracy of MIC_Locator in 10 dbs');
disp(subset_accuracy_list);


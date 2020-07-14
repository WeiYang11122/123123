% % 
% % % %这是（2）步骤，为的是为（3）准备数字格式的dataset
clc;clear;

% SLFs 10 dbs
feature_db = {'db1','db2','db3','db4','db5','db6','db7','db8','db9','db10'};
features_mat = dir('.\data\3_Feature_Results\3_featuresState_db1\');
for i = 1:size(feature_db,2)
    features_dir = ['./data/3_Feature_Results/3_featuresState','_',feature_db{i},'_SLFs/'];
    %features_dir = ['./'];
     features_mat = dir(features_dir);
%     str_dir = ['..\..\data\3_featuresState\3_featuresState','_',feature_db{i}];
    SLFs_feature_dataset = [];
    for j = 3:size(features_mat,1)
        features_name = getfield(features_mat(j,1), 'name');
        load_str = [features_dir '/' features_name];
        features_temp = load(load_str);
        featuretemp = features_temp.features;
        SLFs_feature_dataset = [SLFs_feature_dataset;featuretemp];
    end
    if i == 1
        SLFs_feature.db1 = SLFs_feature_dataset;
    end
    if i == 2
        SLFs_feature.db1 = SLFs_feature_dataset;
    end
    if i == 2
        SLFs_feature.db2 = SLFs_feature_dataset;
    end
    if i == 3
        SLFs_feature.db3 = SLFs_feature_dataset;
    end
    if i == 4
        SLFs_feature.db4 = SLFs_feature_dataset;
    end
    if i == 5
        SLFs_feature.db5 = SLFs_feature_dataset;
    end
    if i == 6
        SLFs_feature.db6 = SLFs_feature_dataset;
    end
    if i == 7
        SLFs_feature.db7 = SLFs_feature_dataset;
    end
    if i == 8
        SLFs_feature.db8 = SLFs_feature_dataset;
    end
    if i == 9
        SLFs_feature.db9 = SLFs_feature_dataset;
    end
    if i == 10
        SLFs_feature.db10 = SLFs_feature_dataset;
    end
end

save_path ='./data/01_Data_Screen/SLFs_feature_10db.mat';
save(save_path,'SLFs_feature');


feature_db = {'db1'};
for i = 1:size(feature_db,2)
    features_dir = ['./data/3_Feature_Results/3_featuresState_db1_garbor_LBP_Energy/'];
    features_mat = dir(features_dir);
    Feat_scale_1_energy = []; Feat_scale_2_energy=[];Feat_scale_3_energy=[]; Feat_scale_4_energy=[];Feat_scale_5_energy=[];
    for j = 3:size(features_mat,1)
        features_name = getfield(features_mat(j,1), 'name');
        load_str = [features_dir '/' features_name];
        features_temp = load(load_str);
        featuretemp = features_temp.features;
        Feat_scale_1_energy = [Feat_scale_1_energy;featuretemp.scale_1];
        Feat_scale_2_energy = [Feat_scale_2_energy;featuretemp.scale_2];
        Feat_scale_3_energy = [Feat_scale_3_energy;featuretemp.scale_3];
        Feat_scale_4_energy = [Feat_scale_4_energy;featuretemp.scale_4];
        Feat_scale_5_energy = [Feat_scale_5_energy;featuretemp.scale_5];
    end
end

save_path ='./data/01_Data_Screen/Feat_scale_1_energy.mat';
save(save_path,'Feat_scale_1_energy');
save_path ='./data/01_Data_Screen/Feat_scale_2_energy.mat';
save(save_path,'Feat_scale_2_energy');
save_path ='./data/01_Data_Screen/Feat_scale_3_energy.mat';
save(save_path,'Feat_scale_3_energy');
save_path ='./data/01_Data_Screen/Feat_scale_4_energy.mat';
save(save_path,'Feat_scale_4_energy');
save_path ='./data/01_Data_Screen/Feat_scale_5_energy.mat';
save(save_path,'Feat_scale_5_energy');

feature_db = {'db1'};
for i = 1:size(feature_db,2)
    features_dir = ['../../data/3_Feature_Results/3_featuresState_db1_garbor_LBP_Ori/'];
    features_mat = dir(features_dir);
    Feat_scale_1_orientation = []; Feat_scale_2_orientation=[];Feat_scale_3_orientation=[]; Feat_scale_4_orientation=[];Feat_scale_5_orientation=[];
    for j = 3:size(features_mat,1)
        features_name = getfield(features_mat(j,1), 'name');
        load_str = [features_dir '/' features_name];
        features_temp = load(load_str);
        featuretemp = features_temp.features;
        Feat_scale_1_orientation = [Feat_scale_1_orientation;featuretemp.scale_1];
        Feat_scale_2_orientation = [Feat_scale_2_orientation;featuretemp.scale_2];
        Feat_scale_3_orientation = [Feat_scale_3_orientation;featuretemp.scale_3];
        Feat_scale_4_orientation = [Feat_scale_4_orientation;featuretemp.scale_4];
        Feat_scale_5_orientation = [Feat_scale_5_orientation;featuretemp.scale_5];
    end
end

save_path ='./data/01_Data_Screen/Feat_scale_1_orientation.mat';
save(save_path,'Feat_scale_1_orientation');
save_path ='./data/01_Data_Screen/Feat_scale_2_orientation.mat';
save(save_path,'Feat_scale_2_orientation');
save_path ='./data/01_Data_Screen/Feat_scale_3_orientation.mat';
save(save_path,'Feat_scale_3_orientation');
save_path ='./data/01_Data_Screen/Feat_scale_4_orientation.mat';
save(save_path,'Feat_scale_4_orientation');
save_path ='./data/01_Data_Screen/Feat_scale_5_orientation.mat';
save(save_path,'Feat_scale_5_orientation');


feature_db = {'db1'};
for i = 1:size(feature_db,2)
    features_dir = ['./data/3_Feature_Results/3_featuresState_db1_garbor_LBPs/'];
    features_mat = dir(features_dir);
    Feat_scale_1_phase = []; Feat_scale_2_phase=[];Feat_scale_3_phase=[]; Feat_scale_4_phase=[];Feat_scale_5_phase=[];
    for j = 3:size(features_mat,1)
        features_name = getfield(features_mat(j,1), 'name');
        load_str = [features_dir '/' features_name];
        features_temp = load(load_str);
        featuretemp = features_temp.features;
        Feat_scale_1_phase = [Feat_scale_1_phase;featuretemp.scale_1];
        Feat_scale_2_phase = [Feat_scale_2_phase;featuretemp.scale_2];
        Feat_scale_3_phase = [Feat_scale_3_phase;featuretemp.scale_3];
        Feat_scale_4_phase = [Feat_scale_4_phase;featuretemp.scale_4];
        Feat_scale_5_phase = [Feat_scale_5_phase;featuretemp.scale_5];
    end
end

save_path ='./data/01_Data_Screen/Feat_scale_1_phase.mat';
save(save_path,'Feat_scale_1_phase');
save_path ='./data/01_Data_Screen/Feat_scale_2_phase.mat';
save(save_path,'Feat_scale_2_phase');
save_path ='./data/01_Data_Screen/Feat_scale_3_phase.mat';
save(save_path,'Feat_scale_3_phase');
save_path ='./data/01_Data_Screen/Feat_scale_4_phase.mat';
save(save_path,'Feat_scale_4_phase');
save_path ='./data/01_Data_Screen/Feat_scale_5_phase.mat';
save(save_path,'Feat_scale_5_phase');


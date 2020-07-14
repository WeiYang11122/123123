clc;clear;
dir_file = dir('./data/0_Imagedata/');


for i = 3: length(dir_file)
    image_name = getfield (dir_file(i),'name');
	image_path_temp = image_name(1:end-4);
	image_read_path = strcat( './data/0_Imagedata/',image_name );
	image_path = strcat('./data/1_Image_State_Results/',image_path_temp,'.txt');
	imageStats(image_read_path ,image_path );
end
% 
params.UMETHOD =  'lin';
params.ITER =  5000;
params.INIT =  'truncated';
params.RANK =  2;
params.STOPCONN = 1;
params.W =load('.\lib\0_Channel_Separation_Code\Wbasis.mat');

for i = 3: length(dir_file)
   	image_name = getfield(dir_file(i),'name');
	image_path_temp = image_name(1:end-4);
	image_read_path = strcat( './data/0_Imagedata/',image_name );
	image_path = strcat('./data/2_Channel_Separation_Results/',image_path_temp,'.png');
	processImage(image_read_path ,image_path ,params);
end

method = {'SLFs'};
dbs = {'db1','db2','db3','db4','db5','db6','db7','db8','db9','db10'}; 
feat_filedir = dir('./data/2_Channel_Separation_Results/');
for i = 8:length(dbs)
    for q = 1:length(method)
            for j =  3:length(feat_filedir)
                image_name = getfield(feat_filedir(j),'name');
                params.featdb = dbs{i}; 
                params.level = 10;
                params.method = method{q};
                image_path_temp = image_name(1:end-4);
                image_read_path = strcat( './data/2_Channel_Separation_Results/',image_name );
                image_path = strcat( './data/3_Feature_Results/3_featuresState_',dbs{i},'_', method{q},'/',image_path_temp,'.mat');
                calculateFeatures(image_read_path ,image_path ,params.featdb,params.level,params.method);
            end
    end
end


method = {'garbor_LBPs','garbor_LBP_Ori','garbor_LBP_Energy'};
dbs = {'db1'}; 
feat_filedir = dir('./data/2_Channel_Separation_Results/');
for i = 1:length(dbs)
    for q = 2:length(method)
        for j =  3:length(feat_filedir)
            image_name = getfield(feat_filedir(j),'name');
            params.featdb = dbs{i}; 
            params.level = 10;
            params.method = method{q};
            image_path_temp = image_name(1:end-4);
            image_read_path = strcat( './data/2_Channel_Separation_Results/',image_name );
            image_path = strcat( './data/3_Feature_Results/3_featuresState_',dbs{i},'_', method{q},'/',image_path_temp,'.mat');
            calculateFeatures(image_read_path ,image_path ,params.featdb,params.level,params.method);
        end
    end
end
function calculateFeatures(readpath, writepath, dbtype, NLEVELS, feattype)
 if strcmp(feattype, 'SLFs')
    I = imfinfo( readpath);
    H = imread( readpath);
    J = reconIH( imread(I.Comment), H);
    features = tissueFeatures_SLFs( J(:,:,2), J(:,:,1), dbtype, NLEVELS, feattype);
    save( writepath, 'features');
end
if strcmp(feattype, 'garbor_LBPs')
    I = imfinfo( readpath);
    H = imread( readpath);
    J = reconIH( imread(I.Comment), H);
    features = tissueFeatures( J(:,:,2),feattype);
    save( writepath, 'features');

end 

if strcmp(feattype, 'garbor_LBP_Ori')
    I = imfinfo( readpath);
    H = imread( readpath);
    J = reconIH( imread(I.Comment), H);
    features = tissueFeatures( J(:,:,2),feattype);
    save( writepath, 'features');
end 
if strcmp(feattype, 'garbor_LBP_Energy')
    I = imfinfo( readpath);
    H = imread( readpath);
    J = reconIH( imread(I.Comment), H);
    features = tissueFeatures( J(:,:,2),feattype);
    save( writepath, 'features');
end  
end
    
 
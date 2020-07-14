function wfeat = tissueFeatures( prot, feattype)
prot = single(prot);

if strcmp(feattype,'garbor_LBPs')
   Feat=gabor_lbp_phase(prot);
end
if strcmp(feattype,'garbor_LBP_Ori')
   Feat=gabor_lbp_oritation(prot);
end
if strcmp(feattype,'garbor_LBP_Energy')
   Feat=gabor_lbp_energy(prot);
end

if strcmp(feattype,'garbor_LBP_Ori')
   wfeat = [Feat];
end
if strcmp(feattype,'garbor_LBP_Energy')
   wfeat = [Feat];
end
if strcmp(feattype,'garbor_LBPs')
   wfeat = [Feat];
end

return


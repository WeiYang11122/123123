function wfeat = tissueFeatures( prot, dna, dbtype, NLEVELS, feattype)
[c b] = imhist(prot);
[a i] = max(c);
prot = prot - b(i);

[c b] = imhist(dna);
[a i] = max(c);
dna = dna - b(i);


thr_prot = graythresh(prot)*255;
thr_dna = graythresh(dna)*255;

obj_prot = prot>thr_prot;
obj_dna = dna>thr_dna;

S = size(prot);

area_prot = sum(obj_prot(:));
area_dna = sum(obj_dna(:));

SLFareaRatio = area_prot / area_dna;


overlap = obj_prot & obj_dna;
areaOverlap = sum(overlap(:));
SLFoverlapRatio = areaOverlap / area_prot;

SLFoverlapIntRatio = sum(prot(overlap)) / sum(prot(:));

dist_dna = bwdist(obj_dna);
SLFdistance = sum(dist_dna(obj_prot))/area_prot;

ofeat = [area_prot SLFareaRatio SLFoverlapRatio SLFoverlapIntRatio SLFdistance];
clear dist_* obj_ overlap dna*

prot = single(prot);

if strcmp(feattype,'SLFs_LBPs')||strcmp(feattype,'SLFs_LBPs_CL')
   spoints = [1, 0; 1, -1; 0, -1; -1, -1; -1, 0; -1, 1; 0, 1; 1, 1];
   lbpfeat=lbp(prot,spoints,0,'h');
end

GLEVELS = 31;
A = uint8(round(GLEVELS*prot/max(prot(:))));

wfeat = ml_texture( A);
wfeat = [mean(wfeat(1:13,[1 3]),2); mean(wfeat(1:13,[2 4]),2)]';

[C,S] = wavedec2(prot,NLEVELS,dbtype);

for k = 0 : NLEVELS-1
    [chd,cvd,cdd] = detcoef2('all',C,S,(NLEVELS-k));
    A = chd - min(chd(:));
    A = uint8(round(GLEVELS*A/max(A(:))));
    hfeat = ml_texture( A);
    hfeat = [mean(hfeat(1:13,[1 3]),2); mean(hfeat(1:13,[2 4]),2)]';

    A = cvd - min(cvd(:));
    A = uint8(round(GLEVELS*A/max(A(:))));
    vfeat = ml_texture( A);
    vfeat = [mean(vfeat(1:13,[1 3]),2); mean(vfeat(1:13,[2 4]),2)]';

    A = cdd - min(cdd(:));
    A = uint8(round(GLEVELS*A/max(A(:))));
    dfeat = ml_texture( A);
    dfeat = [mean(dfeat(1:13,[1 3]),2); mean(dfeat(1:13,[2 4]),2)]';

    wfeat = [wfeat hfeat vfeat dfeat ...
        sqrt(sum(sum(chd.^2))) ...
        sqrt(sum(sum(cvd.^2))) ...
        sqrt(sum(sum(cdd.^2)))];
end

if strcmp(feattype,'SLFs')
   wfeat = [ ofeat wfeat];
end

return


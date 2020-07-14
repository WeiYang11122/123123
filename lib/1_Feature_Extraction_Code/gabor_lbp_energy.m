function LBP_garbor = gabor_lbp_energy(protein) 
minWaveLength       =  4;     
sigmaOnf            =  0.64;       
mult                =  1.7;     
nscale              =  5;        
orientWrap          =  0;
neigh               =  8;
radius              =  2; 
Tem_img     =     protein;
[f1, h1f1, h2f1, A1,theta1, psi1] = Monogenic_Energy_Component(Tem_img, ...
        nscale, minWaveLength, mult, sigmaOnf, orientWrap);

for v=1:nscale
    Tem_img=uint8((A1{v}-min(A1{v}(:)))./(max(A1{v}(:))-min(A1{v}(:))).*255);
    LBPHIST=lbp(Tem_img,radius,neigh,0,'i');
    matrix2=zeros(size(h1f1{v}));matrix3=zeros(size(h2f1{v}));
    matrix2(h1f1{v}>0)=0;matrix2(h1f1{v}<=0)=1;matrix2=matrix2(radius+1:end-radius,radius+1:end-radius);
    matrix3(h2f1{v}>0)=0;matrix3(h2f1{v}<=0)=1;matrix3=matrix3(radius+1:end-radius,radius+1:end-radius);
    N_LBPHIST=matrix2*512+matrix3*256+double(LBPHIST);
    N_LBPHIST=uint16(N_LBPHIST);
    if v ==1
        LBP_garbor_1 = hist(N_LBPHIST(:),0:1023);
    end
    if v ==2
        LBP_garbor_2 = hist(N_LBPHIST(:),0:1023);
    end
    if v ==3
        LBP_garbor_3 = hist(N_LBPHIST(:),0:1023);
    end
    if v ==4
        LBP_garbor_4 = hist(N_LBPHIST(:),0:1023);
    end
    if v == 5
        LBP_garbor_5 = hist(N_LBPHIST(:),0:1023);
    end
end
LBP_garbor.scale_1=LBP_garbor_1;LBP_garbor.scale_2=LBP_garbor_2;LBP_garbor.scale_3=LBP_garbor_3;
LBP_garbor.scale_4=LBP_garbor_4;LBP_garbor.scale_5=LBP_garbor_5;


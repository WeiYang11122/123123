function threshold = fitGetT(n1,n2)

   a1 =149;
   b1=2.041; 
   c1=0.6214;
   a2 =60.43;
   b2=0.2748;
   c2=0.5443;
   
   pas = [a1 b1 c1 a2 b2 c2];
   if ( sum(pas) == 0 )
       error('Replace the parameters of fit function by your own fitted model.');
   end
   
   x=0:0.0001:5;
   y1=a1*exp(-((x-b1)/c1).^2);
   y2=a2*exp(-((x-b2)/c2).^2);
   f1=@(x)a1*exp(-((x-b1)/c1).^2);
   f2=@(x)a2*exp(-((x-b2)/c2).^2);
   dec1=quadl(f1,0,5);
   dec2=quadl(f2,0,5);
   y1=(1/dec1)*y1;
   y2=(1/dec2)*y2;
   p1=a1*n1/(n1+n2);
   p2=a2*n2/(n1+n2);
   threshold=fzero(@Tfun,1); 

   
   
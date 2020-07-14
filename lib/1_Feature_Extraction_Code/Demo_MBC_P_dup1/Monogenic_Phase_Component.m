function [f, h1f, h2f, A, theta, psi] = ...
	Monogenic_Phase_Component(im, nscale, minWaveLength, mult, sigmaOnf, orientWrap)

    if nargin == 5
	orientWrap = 0;
    end
    
    if nargout > 4
	thetaPhase = 1; 
    else
	thetaPhase = 0;  
    end
    
    [rows,cols] = size(im);    
    IM = fft2(double(im));
    

    [u1, u2] = meshgrid(([1:cols]-(fix(cols/2)+1))/(cols-mod(cols,2)), ...
			([1:rows]-(fix(rows/2)+1))/(rows-mod(rows,2)));

    u1 = ifftshift(u1);   
    u2 = ifftshift(u2);
    
    radius = sqrt(u1.^2 + u2.^2);   
                                 
    radius(1,1) = 1;
    
    H1 = i*u1./radius;   
    H2 = i*u2./radius;
    
    for s = 1:nscale
	wavelength = minWaveLength*mult^(s-1);
	fo = 1.0/wavelength;              
	logGabor = exp((-(log(radius/fo)).^2) / (2 * log(sigmaOnf)^2));  
	logGabor(1,1) = 0;                   
	
	H1s = H1.*logGabor; 
	H2s = H2.*logGabor; 
	

	f{s} = real(ifft2(IM.*logGabor));    
	h1f{s} = real(ifft2(IM.*H1s));
	h2f{s} = real(ifft2(IM.*H2s));
	
	A{s} = sqrt(f{s}.^2 + h1f{s}.^2 + h2f{s}.^2); 

	if thetaPhase   

	    theta{s} = atan2(h2f{s}, h1f{s});             
	    psi{s} = atan2(f{s}, sqrt(h1f{s}.^2 + h2f{s}.^2));
	    if orientWrap
		negind = find(theta{s}<0);
		theta{s}(negind) = theta{s}(negind) + pi;
		psi{s}(negind) = pi-psi{s}(negind);
		morethanpi = find(psi{s}>pi);
		psi{s}(morethanpi) = psi{s}(morethanpi)-2*pi;
	    end
	end
	
    end
    
    
function [H, rhoScale, thetaScale] = HoughTransform(Im, threshold, rhoRes, thetaRes)

thetaScale=[0:thetaRes:2*pi-thetaRes];
[ximg,yimg]=size(Im);
rho_max=sqrt(ximg^2+yimg^2);
rhoScale=[1:rhoRes:rho_max-rhoRes];
H=zeros(length(rhoScale),length(thetaScale));

[yvalor,xvalor]=find(Im>threshold);
numero_valores_acima_threshold=length(xvalor);
thetatotal=[0:(2*pi/360):2*pi-(2*pi/360)];

for i=1:numero_valores_acima_threshold
        rho=xvalor(i)*cos(thetaScale)+yvalor(i)*sin(thetaScale); 
        for j=1:length(rho)
                if rho(j)>0
                   H(floor(rho(j)/rhoRes)+1,j)=H(floor(rho(j)/rhoRes)+1,j)+1;
                end
        end
end

end
        
        
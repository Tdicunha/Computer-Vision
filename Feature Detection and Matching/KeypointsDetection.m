function [Pts1] = KeypointsDetection(Img,Pts)
%Your implemention here
%orientação
sigma_i=2;
t_kernel_d=2*ceil(3*sigma_i)+1;

gf=fspecial('gaussian',t_kernel_d,sigma_i);
imgf=ImageFilter(Img, gf);

sobely=fspecial('sobel');
imgy=ImageFilter(imgf, sobely);

sobelx=-sobely';
imgx=ImageFilter(imgf, sobelx);

theta=atan2(imgy, imgx);

for i=1:size(Pts.x,1)
    thetafinal(i,1)=theta(Pts.y(i),Pts.x(i));
end
Pts.theta=thetafinal;

%escala
sigma=0.25;
i=[0 1 2 3 4 5];
sigmah=sigma*2.^(i);

%filtro laplaciano 
for i =1:6
    h=-(sigmah(i)^(2)) *fspecial('log',2*ceil(3*sigmah(i))+1,sigmah(i));
    imgfilter(:,:,i)=imfilter(Img,h);
end

for i=1:size(Pts.x,1)
    
    sx=Pts.x(i);
    sy=Pts.y(i);
    [~,imgaux(i)]=max(imgfilter(sy,sx,:));
    imgauxsigma(i)=sigmah(imgaux(i));
    
end
Pts.escala=reshape(imgauxsigma,[],1);

%Retirar os pontos conforme a máscara
el=2*ceil(3*sigmah(6))+1;
eliminar=floor(el/2);

counter=1;

for i=1:size(Pts.x,1)
    if (Pts.x(i)>eliminar) && (Pts.y(i)>eliminar) && (Pts.x(i)<size(Img,2)-eliminar) && (Pts.y(i)<size(Img,1)-eliminar)
       Ptsaux.x(counter,1)=Pts.x(i);
       Ptsaux.y(counter,1)=Pts.y(i);
       Ptsaux.escala(counter,1)=Pts.escala(i);
       Ptsaux.theta(counter,1)=Pts.theta(i);
       counter=counter+1;
    
    
    end
    
end
%output da função
Pts1=Ptsaux;

end
        
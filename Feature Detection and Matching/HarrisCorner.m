function [Pts] = HarrisCorner(img0,thresh,sigma_d,sigma_i,NMS_size)
%Your implemention
t_kernel_d=2*ceil(3*sigma_d)+1;

gf=fspecial('gaussian',t_kernel_d,sigma_d);

t_kernel_i=2*ceil(3*sigma_i)+1;
gi=fspecial('gaussian',t_kernel_i, sigma_i);

imgfilter= ImageFilter(img0,gf);

sobelx=fspecial('sobel');
imgx=ImageFilter(imgfilter, sobelx);

sobely=-sobelx';
imgy=ImageFilter(imgfilter, sobely);

imgx2= ImageFilter(imgx.^2,gi);
imgy2= ImageFilter(imgy.^2,gi);
imxy= ImageFilter(imgx.*imgy, gi);

R= imgx2.*imgy2-imxy.^2 - 0.04*(imgx2+imgy2).^2;
%R=R>(max(max(R))*thresh);


%NMS
img1=zeros(size(R));
aux=zeros(size(R));
tpad=floor(NMS_size/2);
aux(tpad+1:size(R,1)-tpad,tpad+1:size(R,2)-tpad)=R(tpad+1:size(R,1)-tpad,tpad+1:size(R,2)-tpad);

[x, y]=find((aux)>(max(max(aux))*thresh));

for i=1:size(x,1) 
    
    mask=aux(x(i)-tpad:x(i)+tpad,y(i)-tpad:y(i)+tpad);
    mask(tpad+1,tpad+1)=0; % ponto central

    if(max(max(mask))< aux(x(i),y(i)))
        img1(x(i),y(i))=aux(x(i),y(i));

    end
       
end

[y1,x1]=find(img1>0);%verificar, sus
%figure(1)
%imshow(img0)
%hold on
%scatter(x1,y1,'+','red')
%hold on


%adicionar os pontos à estrutura de dados
field1 ='x'; value1 = x1;
field2 ='y';value2= y1;
Pts=struct(field1, value1, field2,value2);
end
    
                
        
        

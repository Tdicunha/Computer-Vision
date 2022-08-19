function [pts] = findEpipolarMatches(im1, im2, F, pts1)
% findEpipolarMatches:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2

im1 = rgb2gray(im1);
im2 = rgb2gray(im2);

im1 = im2double(im1);
im2 = im2double(im2);

pts=zeros(size(pts1,1),2);
for i=1:size(pts1,1)
    [sy,sx]= size(im2);
    x=pts1(i,1);
    y=pts1(i,2);
    
    v(1) = x;
    v(2) = y;
    v(3) = 1;
    
    l = F * v';
    
    s = sqrt(l(1)^2+l(2)^2);
    
    l = l/s;
    
    if l(1) ~= 0
        ye = sy;
        ys = 1;
        xe = -(l(2) * ye + l(3))/l(1);
        xs = -(l(2) * ys + l(3))/l(1);
    else
        xe = sx;
        xs = 1;
        ye = -(l(1) * xe + l(3))/l(2);
        ys = -(l(1) * xs + l(3))/l(2);
    end
    
    
    %calculo dos parametros da reta y=mx+b
    m= (ye - ys)./(xe-xs);
    b=ye - m*xe;
    
    xpoints=(1:1:size(im1,2));
    ypoints=m.*xpoints+b;
    ypoints=round(ypoints);
    
    m_size=35;
    tpad=floor(m_size./2);
    


   
    descriptor1= im1(pts1(i,2)-tpad:pts1(i,2)+tpad, pts1(i,1)-tpad:pts1(i,1)+tpad);
    descriptor1= reshape(descriptor1,[],1);

    for j=1+tpad:length(ypoints)-tpad
        descriptor2=im2(ypoints(j)-tpad:ypoints(j)+tpad, xpoints(j)-tpad:xpoints(j)+tpad);
        descriptor2=reshape(descriptor2,[],1);
        matriz2(:,j)=descriptor2;
    end
    
    for k=1:size(matriz2,2)
        soma(k,:)=sum((descriptor1-matriz2(:,k)).^2)/size(matriz2,2);
    end
    
    [~,ind]= min(soma);

    pts(i,:)= [xpoints(1,ind),ypoints(1,ind)];
end
end

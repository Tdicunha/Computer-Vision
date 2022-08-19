function [img1] = EdgeFilter(img0, sigma)

    t_kernel=2*ceil(3*sigma)+1;
    kernel_gauss=fspecial('gaussian',t_kernel,sigma);

    
    smoth_image=ImageFilter(img0,kernel_gauss);

    
    %vertical
    h = fspecial('sobel');
    h_x=-h';
    smoth_vertical=ImageFilter(smoth_image,h);

    %horizontal
    smoth_horizontal=ImageFilter(smoth_image,h_x);

    
    % edge filter 
    modulo = sqrt(smoth_vertical.^2 + smoth_horizontal.^2);
    gradiente = atan2(smoth_vertical,smoth_horizontal);
    teta=rad2deg(gradiente);
    
    
    
    img1=zeros(size(smoth_horizontal));
    m= size(img1,1);
    n=size(img1,2);
    
    
    for i= 2:m-1
        for j= 2:n-1
            img1(i,j)=modulo(i,j);
            if( (teta(i,j)>-22.5 && teta(i,j)<=22.5) || (teta(i,j)>157.5 && teta(i,j)<=180) || (teta(i,j)<-157.5 && teta(i,j)>=-180))
                if((modulo(i,j)<modulo(i,j-1)) || (modulo(i,j)<modulo(i,j+1)))
                    img1(i,j)=0;
               
                end
            elseif ( (teta(i,j)>22.5 && teta(i,j)<=67.5)||(teta(i,j)>=-157.5 && teta(i,j)<-112.5))
                    if((modulo(i,j)<modulo(i-1,j+1)) || (modulo(i,j)<modulo(i+1,j-1)))
                        img1(i,j)=0;
                    
                    end
            elseif ( (teta(i,j)>67.5 && teta(i,j)<=112.5)||(teta(i,j)>=-112.5 && teta(i,j)<-67.5))
                 if((modulo(i,j)<modulo(i-1,j)) || (modulo(i,j)<modulo(i+1,j)))
                        img1(i,j)=0;
                 
                 end
            elseif( (teta(i,j)>112.5 && teta(i,j)<=157.5)||(teta(i,j)>=-67.5 && teta(i,j)<-22.5))
                if((modulo(i,j)<modulo(i-1,j-1)) || (modulo(i,j)<modulo(i+1,j+1)))
                        img1(i,j)=0;
                
                end
            end
        end
    end

    img1=img1>0.1;
    
end
    
                
        
        

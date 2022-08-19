function [img1] = ImageFilter(img0, h)
   if rank(h)==1
        [xoriginal,yoriginal]=size(img0);
        [U,D,V]=svd(h);
        kernel_vertical=sqrt(D(1,1))*U(:,1);
        kernel_horizontal=sqrt(D(1,1))*V(:,1)';
       
        %padarray
        tpad=length(h);
        tpad=floor(tpad/2);
        img0=padarray(img0,[tpad,0],'replicate');
        [xtamanhopad,ytamanhopad]=size(img0);
        
        kernel_vertical__rep=repmat(kernel_vertical,1,size(img0,2));
        

        tpad=length(h);
        tpad=floor(tpad/2);
 
        xinicial=1+tpad;
        yinicial=1+tpad;
        xfinal=xoriginal;
        yfinal=yoriginal;
        resultado_vertical=zeros(xoriginal,yoriginal);
        resultado_horizontal=zeros(xoriginal,yoriginal);
        
        
        for i=xinicial:xfinal
            aux=img0(i-tpad:i+tpad,:).*kernel_vertical__rep;
            auxsum=sum(aux);
            resultado_vertical(i-tpad,:)=auxsum();
        end
        

        resultado_vertical=padarray(resultado_vertical,[0,tpad],'replicate');
        kernel_horizontal__rep=repmat(kernel_horizontal,size(resultado_vertical,1),1);
        for i=yinicial:yfinal
            aux=resultado_vertical(:,i-tpad:i+tpad).*kernel_horizontal__rep;
            auxsum=sum(aux,2);
            resultado_horizontal(:,i-tpad)=auxsum();
        end
   
        img1=resultado_horizontal;
  
   else
        disp('Não é possivel decompor o kernel')
   end

end

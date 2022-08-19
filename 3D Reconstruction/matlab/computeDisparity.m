function dispM = computeDisparity(im1, im2, maxDisp, windowSize)
    % computeDisparity creates a disparity map from a pair of rectified images im1 and
    %   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.
    im1 = im2double(im1);
    im2 = im2double(im2);
    tpad=floor(windowSize/2);
 
    img1= padarray(im1,[tpad,tpad],'replicate','both');
    img2= padarray(im2,[tpad,tpad],'replicate','both');
   
    dispM=zeros(size(im1));

    for i=1+tpad:size(im1,1)-tpad
        for j=1+tpad:size(im1,2)-tpad
            descriptor1=img1(i-tpad:i+tpad,j-tpad:j+tpad);
            descriptor1= reshape(descriptor1,[],1);
            v=1;
            matriz2=[];
            
            for d=-maxDisp:1:maxDisp
                if((j+d-tpad)>0) && ((j+d+tpad)<size(img2,2))
                    descriptor2=img2(i-tpad:i+tpad,j+d-tpad:j+d+tpad);
                    descriptor2=reshape(descriptor2,[],1);
                    matriz2(:,v)=descriptor2;
                    v=v+1;
                end
            end
            
            for k=1:size(matriz2,2)
                soma(k,:)=sum((descriptor1-matriz2(:,k)).^2)/size(matriz2,2);
            end
            
            [~,ind]=min(soma);
            disp=ind-1;      
            dispM(i,j)=disp;
        end
    end
end
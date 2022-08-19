function [Descriptors] = FeatureDescriptor(Img,Pts,Dscpt_type,Patch_size)
 %Simple   
    if strcmp(Dscpt_type,'Simple')
        for i=1:size(Pts.x,1)
            aux=zeros(5,5);
            for z=-2:2
                for y=-2:2
                    aux(z+3,y+3)=Img(Pts.y(i)+z,Pts.x(i)+y);
                end
            end
            mascara(:,:,i)=aux;
            aux=reshape(aux,1,[]);
            mascara_vector(i,:)=normalize(aux,'center');
        end
        Descriptors=mascara_vector;
        figure(10)
        imshow(Img)
        hold on
        scatter(Pts.x,Pts.y,'x');
        hold on
        for i=1:2
        xbe=Pts.x(i)-2.5;
        xbd=Pts.x(i)+2.5;
        xce=Pts.x(i)-2.5;
        xcd=Pts.x(i)+2.5;
        ybe=Pts.y(i)+2.5;
        ybd=Pts.y(i)+2.5;
        yce=Pts.y(i)-2.5;
        ycd=Pts.y(i)-2.5;
        patch('Vertices',[[xbe xbd xcd xce]; [ybe ybd ycd yce]]','Faces',[1 2 3 4],'Edgecolor','red','Facecolor','none','Linewidth',1.2)
        hold on
        
        
        end
        figure(11)
        tiledlayout(10,10)
        for i=1:2
        
        
        nexttile
        imshow(mascara(:,:,i))
        hold on
        
        end
    end
    
  %S-mops
    
    if strcmp(Dscpt_type,'S-MOPS')
        
        rodada_vetor=[]
        %
%         figure(2)
%         imshow(Img)
%         hold on
        %
        for i=1:size(Pts.x,1)
                DM=2*ceil(3*Pts.escala(i))+1;
                DM=round(2*sqrt(2)*DM); 
                if DM<9
                    DM=9;
                end
                DM_diag=ceil(DM*sqrt(2));
                eliminar=floor(DM_diag/2);
                if (Pts.x(i)>eliminar) && (Pts.y(i)>eliminar) && (Pts.x(i)<size(Img,2)-eliminar) && (Pts.y(i)<size(Img,1)-eliminar)
                    aux=zeros(DM_diag);
                    ta=floor(DM_diag/2);
                   
                    for z=-ta:ta
                        for y=-ta:ta
                            aux(z+ta+1,y+ta+1)=Img(Pts.y(i)+z,Pts.x(i)+y);
                        end
                    end
                    
                    t = [cos(-Pts.theta(i)) sin(-Pts.theta(i)) 0; 
                         -sin(-Pts.theta(i)) cos(-Pts.theta(i)) 0;
                         0 0 1];
                    %
%                       figure(3)
%                       tiledlayout(2,2)
%                       nexttile
%                       imshow(aux)
%                       hold on
                    %
%                     rotacao=[cos(-Pts.theta(i)) sin(-Pts.theta(i));-sin(-Pts.theta(i)) cos(-Pts.theta(i))];
%                     xoffset=[-ta +ta -ta +ta];
%                     yoffset=[+ta +ta -ta -ta];
%                     for k=1:4
%                         transformada(:,k)=rotacao*[xoffset(k); yoffset(k)];
%                     end
%                     xbe=Pts.x(i)+transformada(1,1);
%                     xbd=Pts.x(i)+transformada(1,2);
%                     xce=Pts.x(i)+transformada(1,3);
%                     xcd=Pts.x(i)+transformada(1,4);
%                     ybe=Pts.y(i)+transformada(2,1);
%                     ybd=Pts.y(i)+transformada(2,2);
%                     yce=Pts.y(i)+transformada(2,3);
%                     ycd=Pts.y(i)+transformada(2,4);
%                     patch('Vertices',[[xbe xbd xcd xce]; [ybe ybd ycd yce]]','Faces',[1 2 3 4],'Edgecolor','red','Facecolor','none','Linewidth',1.2)
%                     hold on
                    %
                    aux_warp=imwarp(aux,affine2d(t));
                    %
%                     nexttile
%                     imshow(aux_warp)
%                     hold on
                    
                    %
                    for k=-floor(DM/2):floor(DM/2)
                        for a=-floor(DM/2):floor(DM/2)
                            rodada(k+floor(DM/2)+1,a+floor(DM/2)+1)=aux_warp(floor(size(aux_warp,1)/2)+1+k,floor(size(aux_warp,1)/2)+1+a);
                        end
                    end
                    %
%                     nexttile
%                     imshow(rodada)
%                     hold on
                    
                    %
                    rodada=imresize(rodada, [8 8]);
                    %
%                     nexttile
%                     imshow(rodada)
%                     hold on
                    
                    %
                    rodada_vetor(i,:)=normalize(reshape(rodada,1,[]),'center');
                end
        end
        Descriptors=rodada_vetor;
    end
        
end
        
        

       
        
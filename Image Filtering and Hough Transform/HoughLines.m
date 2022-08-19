function [rhos, thetas] = HoughLines(H, nLines,rhoScale,thetaScale)

[xH,yH]=size(H);
HH = numel(H);

Hrhotheta=zeros(HH,3);
tot=1;
for i=1:xH
    for j=1:yH
        aux=[i,j,H(i,j)];
        Hrhotheta(tot,:)=aux;
        tot=tot+1;
    end
end

Hrhothetasorted=sortrows(Hrhotheta,3,"descend");


rhointerval=3;
thethainterval=3;
Hrhothema_NMS=[];
[xhrho,yhrho]=size(Hrhothetasorted);
cont_linhas=1;
for i=1:xhrho
    
    if i==1
        Hrhothema_NMS=[Hrhothema_NMS;Hrhothetasorted(i,:)];
    else
        fica=0;
        icompare=find(Hrhothetasorted(:,3)==Hrhothetasorted(i,3));
        for z=1:length(icompare)
            if(icompare(z)<i)
                 distrho = pdist([Hrhothetasorted(i,1);Hrhothetasorted(icompare(z),1)],'euclidean');
                 disttheta= pdist([Hrhothetasorted(i,2);Hrhothetasorted(icompare(z),2)],'euclidean');
                if ((distrho<=rhointerval) && (disttheta<=thethainterval))
                     
                    fica = fica+1;
                end
            end
        end
        if fica==0
           Hrhothema_NMS=[Hrhothema_NMS;Hrhothetasorted(i,:)];
           
           cont_linhas=cont_linhas+1;
        end

    end
    if cont_linhas==nLines
        break
    end
end
rhos=Hrhothema_NMS(:,1);
thetas=Hrhothema_NMS(:,2);


end
        

function [Match] = FeatureMatching(Dscpt1,Dscpt2,Pts_N1,Pts_N2,Tresh,Metric_TYPE)
%Your implementation here
% ssd
    if strcmp(Metric_TYPE,'SSD')
        counter=1;
        for i=1:size(Dscpt1,1)
            for j=1:size(Dscpt2,1)
                distancia(j,:)=sqrt(sum((Dscpt1(i,:)-Dscpt2(j,:)).^2,'all'));
            end
            %verificar a menos distancia e depois fazer o match
            [distancia_minima,indj]=min(distancia);
            if distancia_minima<Tresh
                Match.x1(counter,1)=Pts_N1.x(i);
                Match.y1(counter,1)=Pts_N1.y(i);
                Match.x2(counter,1)=Pts_N2.x(indj);
                Match.y2(counter,1)=Pts_N2.y(indj);
                Match.distancia(counter,1)=distancia_minima;
                counter=counter+1;
    
    
            end
        end
    end
    % ratio
    if strcmp(Metric_TYPE,'ratio')
        counter=1;
        for i=1:size(Dscpt1,1)
            for j=1:size(Dscpt2,1)
                distancia(j,:)=sqrt(sum((Dscpt1(i,:)-Dscpt2(j,:)).^2,'all'));
            end
            %verificar a menos distancia e depois fazer o match
            [~,indj]=min(distancia);
            [distancia_minima,ind]=sort(distancia);
            ratio=distancia_minima(1)/distancia_minima(2);
            if ratio<Tresh
                Match.x1(counter,1)=Pts_N1.x(i);
                Match.y1(counter,1)=Pts_N1.y(i);
                Match.x2(counter,1)=Pts_N2.x(indj);
                Match.y2(counter,1)=Pts_N2.y(indj);
                Match.distancia(counter,1)=ratio;
                counter=counter+1;
    
    
            end
        end
    end
end
        
        
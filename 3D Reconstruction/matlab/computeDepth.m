function depthM = computeDepth(dispM, K1, K2, R1, R2, t1, t2, bits)
% computeDepth creates a depth map from a disparity map (DISPM).

f = K1(1,1);

c1 = -inv(K1*R1) * K1*t1;
c2 = -inv(K2*R2) * K2*t2;
b = norm(c1-c2); 
[mindispM,~]=min(min(dispM));
[maxdispM,~]=max(max(dispM));
values=2^bits;
vetor=linspace(mindispM,maxdispM,values);
for s=1:1:size(dispM,1)
    for l = 1:size(dispM,2)
        aux=abs(dispM(s,l)-vetor);
        [~,ind]=min(aux);
        dispM(s,l)=vetor(ind);
    end
end
for i = 1:size(dispM,1)
    for j = 1:size(dispM,2)
        if(dispM(i,j) == 0)
            depthM(i,j) = 0;
        else
            depthM(i,j) = b*f/dispM(i,j);
        end
    end
end

end
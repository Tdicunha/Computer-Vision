function [ K, R, C ] = decomposeQR(P)
%decompose P into K, R and t
    S=P(1:3,1:3);
    Sinv=inv(S);
    [Q,R] = qr(Sinv);
    
    K=inv(R);
    R=inv(Q);
    K=K/K(3,3);
    [~,~,v]=svd(P);
    
    C=v(:,end);
    C=C/C(4,1); 
    C=C(1:3,1);
end
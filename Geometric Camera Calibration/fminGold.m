function f = fminGold(p, xy, XYZ, w)

%reassemble P
P = [p(1:4);p(5:8);p(9:12)];

xycal=P*XYZ; 
xycal=[xycal(1,:)./xycal(3,:);xycal(2,:)./xycal(3,:);xycal(3,:)./xycal(3,:)];
%compute squared geometric error
erro_projecao=sum(sum(sqrt(([xy(1,:);xy(2,:)]-[xycal(1,:);xycal(2,:)]).^2)));

%compute cost function value
f = erro_projecao;
end
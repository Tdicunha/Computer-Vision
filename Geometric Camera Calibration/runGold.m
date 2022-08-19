function [K, R, t, error] = runGold(xy, XYZ, Dec_type)

%normalize data points
[xy_normalized,XYZ_normalized,T,U] = normalization(xy, XYZ);

%compute DLT
[P_n] = dlt(xy_normalized, XYZ_normalized);

%minimize geometric error
pn = [P_n(1,:) P_n(2,:) P_n(3,:)];
for i=1:20
    [pn] = fminsearch(@fminGold, pn, [], xy_normalized, XYZ_normalized);
end

%denormalize camera matrix
P_N = [pn(1:4);pn(5:8);pn(9:12)];
P=inv(T)*P_N*U;
%factorize camera matrix in to K, R and t
if strcmp(Dec_type,'QR')
    [K,R,C] = decomposeQR(P);
    t=-R*C;
end

if strcmp(Dec_type,'EXP')
    [K,R,C] = decomposeEXP(P);
    t=-R*C;
end

%compute reprojection error
XYZZ=XYZ;
XYZZ(4,:)=1;
xygold=P*XYZZ; %verificar com m1 e m2 dividindo por m3 a ver se é o mesmo

xygold=[xygold(1,:)./xygold(3,:);xygold(2,:)./xygold(3,:);xygold(3,:)./xygold(3,:)];
error=mean(sum(sqrt((xy-[xygold(1,:);xygold(2,:)]).^2)));

scatter(xygold(1,:),xygold(2,:),'x','blue')
hold on
end
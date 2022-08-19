function [K, R, t, Kd, error] = runGoldRadial(xy, XYZ, Dec_type)

%normalize data points
[xy_normalized,XYZ_normalized,T,U] = normalization(xy, XYZ);

%compute DLT
[Pn] = dlt(xy_normalized, XYZ_normalized);

% Distortion Coeficient Initial Values
Kd= [0 0];

%minimize geometric error
pn = [Pn(1,:) Pn(2,:) Pn(3,:) Kd];
for i=1:20
    [pn] = fminsearch(@fminGoldRadial, pn, [], xy_normalized, XYZ_normalized);
end

%denormalize camera matrix
P_N = [pn(1:4);pn(5:8);pn(9:12)];
Kd=[pn(13) pn(14)];
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
xygoldr=P*XYZZ; %verificar com m1 e m2 dividindo por m3 a ver se é o mesmo

xygoldr=[xygoldr(1,:)./xygoldr(3,:);xygoldr(2,:)./xygoldr(3,:);xygoldr(3,:)./xygoldr(3,:)];
error=mean(sum(sqrt((xy-[xygoldr(1,:);xygoldr(2,:)]).^2)));

scatter(xygoldr(1,:),xygoldr(2,:),'x','magenta')
hold on
legend('original', 'dlt', 'gold','gold radial')
end
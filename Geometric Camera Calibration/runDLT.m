function [K, R, t, error] = runDLT(xy, XYZ)

%normalize data points
[xy_normalized,XYZ_normalized,T,U] = normalization(xy, XYZ);
%compute DLT
[P_normalized] = dlt(xy_normalized, XYZ_normalized);

%denormalize camera matrix
P=inv(T)*P_normalized*U;
%factorize camera matrix in to K, R and t
[K,R,C] = decomposeQR(P);
t=-R*C;
%[K,R,t] = decomposeEXP(P);
%compute reprojection error
XYZZ=XYZ;
XYZZ(4,:)=1;
xydlt=P*XYZZ; 

xydlt=[xydlt(1,:)./xydlt(3,:);xydlt(2,:)./xydlt(3,:);xydlt(3,:)./xydlt(3,:)];
error=mean(sum(sqrt((xy-[xydlt(1,:);xydlt(2,:)]).^2)));

hold on
scatter(xy(1,:),xy(2,:),'o','green')
hold on
scatter(xydlt(1,:),xydlt(2,:),'x','red')
hold on


end
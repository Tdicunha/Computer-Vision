function [xyn, XYZn, T, U] = normalization(xy, XYZ)

%data normalization
%first compute centroid
xy_centroid=[mean(xy(1,:)); mean(xy(2,:))]; %corrigir e verificar
XYZ_centroid=[mean(XYZ(1,:)); mean(XYZ(2,:)); mean(XYZ(3,:))]; %corrigir e verificar


%create T and U transformation matrices
%then, compute scale
erromedio2d=sum(sqrt((xy(1,:)-xy_centroid(1)).^2+(xy(2,:)-xy_centroid(2)).^2))/length(xy);
s2d=erromedio2d/sqrt(2);
erromedio3d=sum(sqrt((XYZ(1,:)-XYZ_centroid(1)).^2+(XYZ(2,:)-XYZ_centroid(2)).^2+(XYZ(3,:)-XYZ_centroid(3)).^2))/length(XYZ);
s3d=erromedio3d/sqrt(3);

%create T and U transformation matrices
T = [s2d 0   xy_centroid(1);
     0   s2d xy_centroid(2);
     0    0   1];
T=inv(T);
U = [s3d    0    0    XYZ_centroid(1);
     0      s3d  0    XYZ_centroid(2);
     0      0    s3d  XYZ_centroid(3);
     0      0    0    1  ];
U=inv(U);
p=xy;
p(3,:)=1;
P=XYZ;
P(4,:)=1;


%and normalize the points according to the transformations
xyn = T*p; 
XYZn = U*P;

end
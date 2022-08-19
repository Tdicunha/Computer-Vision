function [P] = dlt(xy, XYZ)
%computes DLT, xy and XYZ should be normalized before calling this function
A=[];
for i=1:length(xy)
    aux=[XYZ(1,i) XYZ(2,i) XYZ(3,i) XYZ(4,i) 0 0 0 0 -xy(1,i)*XYZ(1,i) -xy(1,i)*XYZ(2,i) -xy(1,i)*XYZ(3,i) -xy(1,i)*XYZ(4,i);
         0 0 0 0 XYZ(1,i) XYZ(2,i) XYZ(3,i) XYZ(4,i) -xy(2,i)*XYZ(1,i) -xy(2,i)*XYZ(2,i) -xy(2,i)*XYZ(3,i) -xy(2,i)*XYZ(4,i)];
    A=[A;aux];
end
[U D V]=svd(A);

P=[V(1,12) V(2,12) V(3,12) V(4,12);
   V(5,12) V(6,12) V(7,12) V(8,12);
   V(9,12) V(10,12) V(11,12) V(12,12)];
end
function F = computeF(pts1, pts2)
% computeF:
%   pts1 - Nx2 matrix of (x,y) coordinates
pts1t(1,:)=pts1(:,1);
pts1t(2,:)=pts1(:,2);
pts1_centroid=[mean(pts1t(1,:)); mean(pts1t(2,:))];

erromedio2d_pts1=sum(sqrt((pts1t(1,:)-pts1_centroid(1)).^2+(pts1t(2,:)-pts1_centroid(2)).^2))/length(pts1t);
s2d_pts1=erromedio2d_pts1/sqrt(2);

T_pts1 = [s2d_pts1 0   pts1_centroid(1);
           0   s2d_pts1 pts1_centroid(2);
           0    0   1];

T_pts1=inv(T_pts1);
pts1t(3,:)=1;
pts1norm = T_pts1*pts1t; 
%   pts2 - Nx2 matrix of (x,y) coordinates

pts2t(1,:)=pts2(:,1);
pts2t(2,:)=pts2(:,2);

pts2_centroid=[mean(pts2t(1,:)); mean(pts2t(2,:))];

erromedio2d_pts2=sum(sqrt((pts2t(1,:)-pts2_centroid(1)).^2+(pts2t(2,:)-pts2_centroid(2)).^2))/length(pts2t);
s2d_pts2=erromedio2d_pts2/sqrt(2);

T_pts2 = [s2d_pts2 0   pts2_centroid(1);
           0   s2d_pts2 pts2_centroid(2);
           0    0   1];
T_pts2=inv(T_pts2);
pts2t(3,:)=1;
pts2norm = T_pts2*pts2t;

%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'
A=[];
for i=1:length(pts1t)
    aux=[pts1norm(1,i)*pts2norm(1,i),pts1norm(2,i)*pts2norm(1,i),pts2norm(1,i),pts1norm(1,i)*pts2norm(2,i),pts1norm(2,i)*pts2norm(2,i),pts2norm(2,i),pts1norm(1,i),pts1norm(2,i),1];
    A=[A;aux];
end

[~,~,v]=svd(A);
F=[v(1,9) v(2,9) v(3,9);
   v(4,9) v(5,9) v(6,9);
   v(7,9) v(8,9) v(9,9)];




%alteração de rank de F
[U,S,V]=svd(F);
S(end,end)=0;
F_linha=U*S*V';

F=refineF(F_linha,pts1norm',pts2norm');
%desnormalização
F= T_pts2' * F * T_pts1;    
end

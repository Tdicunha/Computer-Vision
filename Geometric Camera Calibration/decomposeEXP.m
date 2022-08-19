function [ K, R, C ] = decomposeEXP(P)
%decompose P into K, R and t
A=P(1:end,1:end-1);
b=P(1:end,end);


a1=A(1,:);
a2=A(2,:);
a3=A(3,:);


if(b(3)>0)
    e=1;
end
if(b(3)<0)
    e=-1;
end

p=e/norm(a3);
r3=p*a3;
u0=p^2*dot(a1,a3);
v0=p^2*dot(a2,a3);

eu=1;
ev=1;

costheta=-eu*ev*(dot(cross(a1,a3),cross(a2,a3))/(norm(cross(a1,a3))*norm(cross(a2,a3))));
theta=acos(costheta);
alfa=eu*p^2*norm(cross(a1,a3))*sin(theta);
beta=ev*p^2*norm(cross(a2,a3))*sin(theta);

r1=(1/(norm(cross(a2,a3))))*cross(a2,a3);
r2=cross(r3,r1);

R=[r1;r2;r3];

K=[alfa,-alfa*cot(theta),u0;
   0,beta/sin(theta),v0;
   0,0,1];


C=-inv(A)*b;
end
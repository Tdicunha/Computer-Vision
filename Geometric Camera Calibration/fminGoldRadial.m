function f = fminGoldRadial(p, xy, XYZ, w)

%reassemble P
P = [p(1:4);p(5:8);p(9:12)];
k1=p(13);
k2=p(14);

[K,R,C]=decomposeEXP(P);
t=-R*C;
%compute squared geometric error with radial distortion

Pontos2Du=[R t]*XYZ;
xu=Pontos2Du(1,:)./Pontos2Du(3,:);
yu=Pontos2Du(2,:)./Pontos2Du(3,:);


ru=sqrt((xu).^2+(xu).^2);
L=1+k1*(ru.^2)+k2*(ru.^4);

xd=L.*xu;
yd=L.*yu;

Ppixel=inv(K)*xy;
Ppixel=Ppixel./Ppixel(3,:);


erro_projecao=sum(sum(sqrt(([Ppixel(1,:);Ppixel(2,:)]-[xd(1,:);yd(1,:)]).^2)));
%compute cost function value
f = erro_projecao;
end
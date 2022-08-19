function ShowMatching(MatchList,img1,img2,Dscpt1,Dscpt2)
% Show all matches by ploting the line that connects both matched keypoints. 
% Create a composed image with the original and query image to plot the connected points.
% Allow also the possibility to visualise the 8x8 (or 5x5) feature patches
% per matching.

%Your implementation here.


if (size(img1,1)>size(img2,1)) && (size(img1,2)>size(img2,2))
    delta1=size(img1,1)-size(img2,1);
    delta2=size(img1,2)-size(img2,2);
    img2=padarray(img2,[delta1 delta2],0,'post');

end

if (size(img1,1)<size(img2,1)) && (size(img1,2)<size(img2,2))
    delta1=size(img2,1)-size(img1,1);
    delta2=size(img2,2)-size(img1,2);
    img1=padarray(img1,[delta1 delta2],0,'post');
end



figure(10)
imgfinal=[img1,img2];
imshow(imgfinal)
hold on

for i=1:size(MatchList.x1,1)
    plot([MatchList.x1(i) MatchList.x2(i)+size(img1,2)],[MatchList.y1(i) MatchList.y2(i)],'LineWidth',1.2);
    hold on

end



end
        
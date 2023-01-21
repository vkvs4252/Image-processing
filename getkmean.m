function xx = getkmean(enhanced)

% %applying K-mean clustering

%type 1
% ik=imread("sample2.png");
% k=10;
% L = imsegkmeans( ik , k );
% figure;
% imshow(L);
% title("upon K mean");
% 

%type 2
%input image
gray_lab=rgb2lab(enhanced);

ab = gray_lab(:,:,2:3);
ab = im2single(ab);
k= 100;
L2 = imsegkmeans(ab,k);
figure;
imshow(L2)
%show change
B2 = labeloverlay(img,L2);

figure;
imshow(B2)
title("Labeled Image a*b*")
figure;
imhist(B2);
title('upon k-means');


xx=0;

end


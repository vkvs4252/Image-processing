function t = getCLAHE(enhanced)

%########################## clahe #############

%input images
%gray_lab=rgb2lab(img); %original
gray_lab=rgb2lab(enhanced); %enhanced from algorithm

max_luminosity = 200;
L = gray_lab(:,:,1)/max_luminosity;

gray_adjt = gray_lab;
gray_adjt(:,:,1) = imadjust(L)*max_luminosity;
gray_adjt = lab2rgb(gray_adjt);
%view
figure;
imshow(gray_adjt);

% show gray_ahe with its hist plot
figure;
subplot(1,3,1)
imshow(gray_adjt)
subplot(1,3,2:3)  % for ratio
imhist(gray_adjt)

gray_he = gray_lab;
gray_he(:,:,1) = histeq(L)*max_luminosity;
gray_he = lab2rgb(gray_he);
%view
figure;
imshow(gray_he);

% show gray_ahe with its hist plot
figure;
subplot(1,3,1)
imshow(gray_he)
subplot(1,3,2:3)  % for ratio
imhist(gray_he)

gray_ahe = gray_lab;
gray_ahe(:,:,1) = adapthisteq(L)*max_luminosity;
gray_ahe = lab2rgb(gray_ahe);
%view
figure;
imshow(gray_ahe);
%show gray_ahe with its hist plot
figure;
subplot(1,3,1)
imshow(gray_ahe)
subplot(1,3,2:3)  % for ratio
imhist(gray_ahe)

%grand montage
figure;
montage({img,gray_adjt,gray_he,gray_ahe},"Size",[1 4])
title("Original Image and Enhanced Images using " + ...
    "imadjust, histeq, and adapthisteq",FontSize=9)

t=0;

end


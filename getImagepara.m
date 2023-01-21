%get Image parameters
function gg= getImagepara(image1,image2)

%PSNR
psnr_=getPSNR(image1,image2);
%SSIM
ssim_=getMSSIM(image1,image2);

%fprintf('PSNR= %f - SSIM= %f\n',psnr_,ssim_);

%MSE
mse_=getMSE(image1,image2);
mse1_=immse(image1, image2);
%AMBE
ambe_=getAMBE(image1,image2);


%print parameters
fprintf('MSE_code= %f - MSE_direct= %f\n',mse_,mse1_);
%fprintf('MSE= %f\n',mse_);
fprintf('PSNR= %f\n',psnr_);
fprintf('SSIM= %f\n',ssim_);
fprintf('AMBE= %f\n',ambe_);
gg=0;


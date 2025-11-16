% Topic: Image Super-Resolution using Interpolation and Wavelets

clc; clear; close all;

img = imread('mandrill.jpg'); 
if size(img,3) == 1
    img = repmat(img, [1 1 3]);
end

img = im2double(img);

% Convert to YCbCr for luminance , blue chrominance , red chrominance
ycbcr = rgb2ycbcr(img);
Y = ycbcr(:,:,1);

% Bicubic Interpolation (Upscaling) 
scale = 2;   % Upscale factor
Y_up = imresize(Y, scale, 'bicubic');
Cb_up = imresize(ycbcr(:,:,2), scale, 'bicubic');
Cr_up = imresize(ycbcr(:,:,3), scale, 'bicubic');

% Wavelet Decomposition and Fusion
[LL1, LH1, HL1, HH1] = dwt2(Y_up, 'db2');

% Sharpened version to get more high-frequency detail
Ysharp = imsharpen(Y_up, 'Radius', 2, 'Amount', 1.5);
[LL2, LH2, HL2, HH2] = dwt2(Ysharp, 'db2');

% Fuse wavelet detail coefficients (max-abs fusion)
LH_f = max(abs(LH1), abs(LH2)) .* sign(LH1 + LH2);
HL_f = max(abs(HL1), abs(HL2)) .* sign(HL1 + HL2);
HH_f = max(abs(HH1), abs(HH2)) .* sign(HH1 + HH2);
LL_f = (LL1 + LL2) / 2;

% Inverse Wavelet Reconstruction
Yfused = idwt2(LL_f, LH_f, HL_f, HH_f, 'db2');
Yfused = mat2gray(Yfused);

% Combine channels back
SRycbcr = cat(3, Yfused, Cb_up, Cr_up);
SRimg = ycbcr2rgb(SRycbcr);

% Comparison Images
bicubic_only = imresize(img, scale, 'bicubic');

% Display All Results on One Screen
figure('Name', 'Super-Resolution using Interpolation and Wavelets', 'NumberTitle', 'off');

subplot(2,3,1);
imshow(img);
title('Original Low-Resolution');

subplot(2,3,2);
imshow(Y_up);
title('Upscaled Luminance (Bicubic)');

subplot(2,3,3);
imshow(Ysharp);
title('Sharpened Luminance');

subplot(2,3,4);
imshow(bicubic_only);
title('Only Bicubic Upscale');

subplot(2,3,5);
imshow(SRimg);
title('Wavelet + Bicubic SR Result');

subplot(2,3,6);
imshow(abs(SRimg - bicubic_only)*5);
title('Detail Difference (Enhanced Edges)');

sgtitle('Image Super-Resolution using Interpolation and Wavelets');

% PSNR + SSIM Quality Metrics 
psnrval = psnr(SRimg, bicubic_only);
ssimval = ssim(SRimg, bicubic_only);
fprintf('\nSuper-Resolution Completed\n');
fprintf('PSNR Improvement: %.2f dB\n', psnrval);
fprintf('SSIM Improvement: %.4f\n', ssimval);

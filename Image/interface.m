%-------------
% Leitura da imagem e conversão para gray
%-------------
image = imread('images/image4.png', 'png');
im_size = size(image);
im_gray = rgb2gray(image);

%-------------
% Filtro Passa baixa
%-------------
gauss_m2 = imsmooth(im_gray,"Gaussian");

%-------------
% Downsampling
%-------------
m = imresize(gauss_m2, 0.5);

%-------------
% Filtros
%-------------
b = bli(m, im_size(1), im_size(2));
n = nn(m, im_size(1), im_size(2));
h = sinc_filter(m,im_size(1),im_size(2));

%-------------
% Imagem
%-------------
%figure
subplot(2,3,1);imagesc(im_gray);colormap(gray);title('Original Gray','fontsize',14),set(gca, "fontsize", 10);
subplot(2,3,2);imagesc(m);colormap(gray);title('Lowpass and Downsampling','fontsize',14),set(gca, "fontsize", 10);
subplot(2,3,4);imagesc(n);colormap(gray);title('Nearest Neighbour','fontsize',14),set(gca, "fontsize", 10);
subplot(2,3,5);imagesc(b);colormap(gray);title('Bilinear','fontsize',14),set(gca, "fontsize", 10);
subplot(2,3,6);imagesc(h);colormap(gray);title('Sinc Function','fontsize',14),set(gca, "fontsize", 10);

%-------------
% Métricas comparativas
%-------------
 % ERROR MÁX
 err_nn = max(max(im_gray - n)) % Original <-> NN
 err_bli = max(max(im_gray - b)) % Original <-> BLI
 err_sincf = max(max(im_gray - h)) % Original <-> SINC
 
 % CORRELAÇÃO
 corr_nn = corr2 (im_gray,n)  % Original <-> NN
 corr_bli = corr2 (im_gray,b) % Original <-> BLI
 corr_sincf = corr2 (im_gray,h)  % Original <-> SINC
 
 % MEAN SQUARED ERROR (MSE)
 mse_nn = immse(im_gray, n)   % Original <-> NN
 mse_bli = immse(im_gray, b)   % Original <-> BLI
 mse_sincf = immse(im_gray, h)   % Original <-> SINC
 
 % PEAK SIGNAL-TO-NOISE RATIO
 [psnr_nn snr_nn]= psnr(n, im_gray)   % Original <-> NN
 [psnr_bli snr_bli] = psnr(b, im_gray)  % Original <-> BLI
 [psnr_sincf snr_bli]= psnr(h, im_gray)  % Original <-> SINC

%clear all;
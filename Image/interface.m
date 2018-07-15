%-------------
% Leitura da imagem e conversão para gray
%-------------
image = imread('images/image4.png', 'png');
im_size = size(image);
im_gray = rgb2gray(image);
 
%im = imresize(I, 0.5); No alliasing
%b = ds(a, 2, 2); No alliasing

%-------------
% Filtro Passa baixa
%-------------
mpad = padarray(im_gray, [4 4], "symmetric");
f_gauss = fspecial("gaussian", 9, 2);
gauss_m = filter2(f_gauss, mpad, "valid");
gauss_m = uint8(gauss_m);

%-------------
% Downsampling
%-------------
m = imresize(gauss_m, 1);

%-------------
% Histograma
%-------------
%figure
%imhist(m);

%figure
%imhist(gauss_m);

%-------------
% Filtros
%-------------
b = bli(m, im_size(1), im_size(2));
n = nn(m, im_size(1), im_size(2));


%-------------
% Imagem
%-------------
subplot(2,2,1);imagesc(im_gray);colormap(gray);title('Original Gray');
subplot(2,2,2);imagesc(m);colormap(gray);title('Lowpass and Downsampling');
subplot(2,2,3);imagesc(b);colormap(gray);title('Neighbour');
subplot(2,2,4);imagesc(n);colormap(gray);title('Bilinear');

clear all;
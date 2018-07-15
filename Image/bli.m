% Bilinear Interpolation function

function output_image = bli(input_image, x_res, y_res)
  % output_image  : imagem com dimensões x_res e y_res
  % input_image   : imagem de entrada
  % x_res         : tamanho horizontal da nova imagem
  % y_res         : tamanho vestical da nova imagem
  
  %Importando a imagem original 
  I = input_image;
  
  %Fazendo a conversão para grayscale
  %I = rgb2gray(I);
  
  %Determinando as dimensões da imagem original
  % 3 Valores: Largura, altura e cor.
  [j k] = size(I);
  
  %Determinando as dimensões da nova imagem
  x_new = x_res
  y_new = y_res
  
  %Determinando as dimensões da imagem original comparada com a nova imagem
  x_scale = x_new./(j-1);
  y_scale = y_new./(k-1);
  
  %Inicializando o buffer para a nova imagem
  M = zeros(x_new, y_new);
  
  %Gerando a nova imagem
  for count1 = 0:x_new-1
    for count2 = 0:y_new-1
      W = -(((count1./x_scale)-floor(count1./x_scale))-1);
      H = -(((count2./y_scale)-floor(count2./y_scale))-1);
      I11 = I(1+floor(count1./x_scale), 1+floor(count2./y_scale));
      I12 = I(1+ceil(count1./x_scale), 1+floor(count2./y_scale));
      I21 = I(1+floor(count1./x_scale), 1+ceil(count2./y_scale));
      I22 = I(1+ceil(count1./x_scale), 1+ceil(count2./y_scale));
      M(count1+1, count2+1) = (1-W).*(1-H).*I22 + (W).*(1-H).*I21 + (1-W).*(H).*I12 + (W).*(H).*I11;
      
    endfor
  endfor
  
  output_image = M;
  
endfunction
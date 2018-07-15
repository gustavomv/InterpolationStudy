%Nearest neighbour code

function output_image = nn(input_image, x_res, y_res)
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
      M(count1+1, count2+1) = I(1+round(count1./x_scale), 1+round(count2./y_scale));
    endfor
  endfor
  
  output_image = uint8(M) ;
  
endfunction

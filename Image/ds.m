
function downsampling = ds(input_image, factor_x, factor_y)
  # Importando a imagem
  im = input_image;

  # Convertendo a imagem RGB para grayscale
  #para simplificar o processamento
  im = rgb2gray(im);

  # Determinando a dimensão da imagem
  # Valores: Largura, altura e vetor de cor.
  [j k]= size(im)

  # Specify the new image dimensions we want for our smaller output image.
  # In this case we will downsampling the image by a fixed ratio
  # Since the ratios are different, the image will appear distored
  # We can also set x_new and y_new to arbitrary values, but it will now work
  # If they are larger than j and k. That would be upsampling/interpolation,
  # and will be covered in a future tutorial.

  x_new = j./factor_x;
  y_new = k./factor_y;

  # Determine the ratio of the old dimensions compared to the new dimensions.
  x_scale = j./x_new;
  y_scale = k./y_new;

  # Declare and initialize an output image buffer
  Mds = zeros(x_new, y_new);

  # Generate the output image
  for count1 = 1:x_new
    for count2 = 1:y_new
      Mds(count1, count2) = im(count1.*x_scale, count2.*y_scale);
    endfor
  endfor

  downsampling = uint8(Mds);

endfunction
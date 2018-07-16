pkg load signal %Carregando os pacotes necessarios para utilizarmos funcoes de tratamento de sinais
clear all %Excluindo as variaveis existentes
clc

[AudioSample Fs]= audioread('AudioFile.wav'); %Leitura e amostragem do arquivo de audio escolhido
Audio = transpose(AudioSample); %Transformando as amostras do audio em um vetor 1xN

M = 5; %Fator a ser utilizado na decimacao do sinal
n = numel(Audio); %Numero de elementos das amostras do sinal original

DownS = decimate(Audio, M); %Utilizamos a funcao decimate() por conter um tratamento com filtro anti-aliasing, passa-baixa
                            %mais especificamente, um filtro Chebyshev tipo I de oitava ordem
DownS_Values = 0:length(DownS)-1; %Criando um vetor com a mesma quantidade de elementos da amostra pos-decimacao
AudioSamples_Length = linspace(0, length(DownS), length(Audio)); %Criando um vetor com a mesma quantidade de elementos da amostra do 
                                                                 % sinal original, baseado nas amostras existentes pos-decimacao
Linear = interp1(DownS_Values, DownS, AudioSamples_Length, 'linear'); %Interpolacao Linear, onde temos o vetor de elementos pos-decimacao
                                                                      % e a quantidade de elementos que queremos pos-interpolacao

for i=1:n
    if isnan(Linear(1,i)) %Caso haja elementos que "nao sao numeros" na reconstrucao, substituimos eles por zeros
        Linear(1,i) = 0;
    end
end

%------------------ Analise das Metricas ----------------------------%
ME = abs(Audio - Linear); %Erro Maximo

aux = 0;
for i=1:n
  aux = aux + abs(Audio(1,i) - Linear(1,i));
end
MAE = aux/n; %Erro Medio Absoluto

aux = 0;
for i=1:n
  aux = aux + (abs(Audio(1,i) - Linear(1,i)))^2;
end
MSE = aux/n; %Erro Medio Quadratico
RMSE = sqrt(MSE); %Raiz do Erro Medio Quadratico

aux = 0;
for i=1:n
  aux = aux + Audio(1,i)^2;
end 
NMSE = (MSE*n)/aux;  %Erro Medio Quadratico Normalizado

SNR = 10*log10(aux/(MSE*n)); %Relacao Sinal-Ruido

AudioDFT = fft(Audio); %Transformada de Fourier do sinal original
AudioMag = abs(AudioDFT); %Magnitude no dominio da frequencia
LinearDFT = fft(Linear); %Transformada de Fourier do sinal reconstruido
LinearMag = abs(LinearDFT);  %Magnitude no dominio da frequencia

%-----------------------------Results----------------------------------%
figure(1);
%subplot(2,2,1);
plot(Audio, 'b');hold on
plot(DownS, 'r');hold off
xlabel('Time(s)', "fontsize", 16);
ylabel('Amplitude',"fontsize", 16);
h=legend('Input Signal', 'Downsampled');
set(h, "fontsize", 10);
title('Downsampled',"fontsize", 18);
grid on

figure(2);
%subplot(2,2,2);
plot(Audio, 'b');hold on
plot(Linear, 'r');hold off
xlabel('Time(s)',"fontsize", 16);
ylabel('Amplitude',"fontsize", 16);
h=legend('Input Signal', 'Linear Interpolation');
set(h, "fontsize", 10);
title('Linear Interpolation Result', "fontsize", 18);
grid on

figure(3);
%subplot(2,2,3);
plot(AudioMag, 'b'); hold on
plot(LinearMag, 'r'); hold off
xlabel('Frequency(Hz)',"fontsize", 12);
ylabel('Amplitude Spectrum',"fontsize", 12);
h=legend('Input Signal', 'Linear Interpolation');
set(h,"fontsize", 10);
title('Magnitude',"fontsize", 18);

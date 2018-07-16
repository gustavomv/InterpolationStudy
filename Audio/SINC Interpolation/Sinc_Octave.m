pkg load signal; %Carregando os pacotes necessarios para utilizarmos funcoes de tratamento de sinais
clear %Excluindo as variaveis existentes
clc

[AudioSample Fs] = audioread('AudioFile.wav'); %Leitura e amostragem do arquivo de audio escolhido
Audio = transpose(AudioSample); %Transformando as amostras do audio em um vetor 1xN

M = 5;  %Fator a ser utilizado na decimacao do sinal
N = numel(Audio); %Numero de elementos das amostras do sinal original

DownS = decimate(Audio, M); %Utilizamos a funcao decimate() por conter um tratamento com filtro anti-aliasing, passa-baixa
                            %mais especificamente, um filtro Chebyshev tipo I de oitava ordem
Sinc = resampleSINC(DownS, M); %utilizcao da interpolacao sinc por meio de uma funcao criada no arquivo resampleSINC.m
Sinc = Sinc(1:N); %ajustando o numero de elementos do sinal reconstruido para o mesmo numero de elementos do sinal original

%------------------ Analise das Metricas ----------------------------%
ME = abs(Audio - Sinc); %Erro Maximo

aux = 0;
for i=1:N
  aux = aux + abs(Audio(1,i) - Sinc(1,i));
end
MAE = aux/N; %Erro Medio Absoluto

aux = 0;
for i=1:N
  aux = aux + (abs(Audio(1,i) - Sinc(1,i)))^2;
end
MSE = aux/N %Erro Medio Quadratico
RMSE = sqrt(MSE); %Raiz do Erro Medio Quadratico

aux = 0;
for i=1:N
  aux = aux + Audio(1,i)^2;
end 
NMSE = (MSE*N)/aux; %Erro Medio Quadratico Normalizado

SNR = 10*log10(aux/(MSE*N); %Relacao Sinal-Ruido

AudioDFT = fft(Audio); %Transformada de Fourier do sinal original
AudioMag = abs(AudioDFT); %Magnitude no dominio da frequencia
SincDFT = fft(Sinc); %Transformada de Fourier do sinal reconstruido
SincMag = abs(SincDFT); %Magnitude no dominio da frequencia
%-----------------------------------------------------------------------%

figure(1);
plot(AudioSample, 'b');hold on
plot(DownS, 'r');hold off
xlabel('Time(s)',"fontsize", 16);
ylabel('Amplitude',"fontsize", 16);
h = legend('Input Signal', 'Downsampled');
set(h,"fontsize", 16);
grid on

figure(2)
plot(AudioSample, 'b');hold on
plot(Sinc, 'r');hold off
xlabel('Time(s)',"fontsize", 16);
ylabel('Amplitude',"fontsize", 16);
h = legend('Input Signal', 'SINC Interpolation');
set(h,"fontsize", 16);
grid on

figure(3);
plot(AudioMag, 'b'); hold on
plot(SincMag, 'r'); hold off
xlabel('Frequency(Hz)',"fontsize", 16);
ylabel('Amplitude Spectrum',"fontsize", 16);
h = legend('Input Signal', 'SINC Interpolation');
set(h,"fontsize", 16);
title('Magnitude',"fontsize", 16);

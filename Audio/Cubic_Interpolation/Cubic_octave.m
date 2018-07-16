pkg load signal  %Carregando os pacotes necessarios para utilizarmos funcoes de tratamento de sinais
clear  %Excluindo as variaveis existentes
clc

[Audio Fs]= audioread('Super Mario World Music.wav'); %Leitura e amostragem do arquivo de audio escolhido
%[Audio Fs]= audioread('Register.wav'); %Transformando as amostras do audio em um vetor 1xN
AudioT = transpose(Audio);
M = 5; %Fator a ser utilizado na decimacao do sinal
n= numel(AudioT) %Numero de elementos das amostras do sinal original

DownS = decimate(AudioT, M);%Utilizamos a funcao decimate() por conter um tratamento com filtro anti-aliasing, passa-baixa
                            %mais especificamente, um filtro Chebyshev tipo I de oitava ordem
DownS_Values = 0:length(DownS)-1; %Criando um vetor com a mesma quantidade de elementos da amostra pos-decimacao
Audio_Length = linspace(0, length(DownS), length(AudioT)); %Criando um vetor com a mesma quantidade de elementos da amostra do 
                                                           % sinal original, baseado nas amostras existentes pos-decimacao

Cubic = interp1(DownS_Values, DownS, Audio_Length, 'cubic');%Interpolacao Cubica, onde temos o vetor de elementos pos-decimacao
                                                            % e a quantidade de elementos que queremos pos-interpolacao

for i=1:n
    if isnan(Cubic(1,i)) %Caso haja elementos que "nao sao numeros" na reconstrucao, substituimos eles por zeros
        Cubic(1,i) = 0;
    end
end

%------------------ Analise das Metricas ----------------------------%
ME = abs(AudioT - Cubic); %Erro Maximo

aux = 0;
for i=1:n
  aux = aux + abs(AudioT(1,i) - Cubic(1,i)); %Erro Medio Absoluto
end
MAE = aux/n;  %Erro Medio Quadratico

aux = 0;
for i=1:n
  aux = aux + (abs(AudioT(1,i) - Cubic(1,i)))^2;
end
MSE = aux/n;  %Erro Medio Quadratico
RMSE = sqrt(MSE); %Raiz do Erro Medio Quadratico

aux = 0;
for i=1:n
  aux = aux + AudioT(1,i)^2;
end 
NMSE = (MSE*n)/aux; %Erro Medio Quadratico Normalizado

SNR = 10*log10(aux/(MSE*n)); %Relacao Sinal-Ruido

AudioDFT = fft(AudioT);  %Transformada de Fourier do sinal original
AudioMag = abs(AudioDFT); %Magnitude no dominio da frequencia
CubicDFT = fft(Cubic);  %Transformada de Fourier do sinal reconstruido
CubicMag = abs(CubicDFT);  %Magnitude no dominio da frequencia

plot(AudioMag, 'b');hold on;
plot(CubicMag, 'r');hold off;

figure(1);
subplot(2,1,1);
plot(AudioT, 'b');hold on
plot(DownS, 'r');hold off
xlabel('Time(s)',"fontsize", 16);
ylabel('Amplitude',"fontsize", 16);
h = legend('Input Signal', 'Downsampled');
set(h,"fontsize", 16);
grid on


subplot(2,1,2)
plot(AudioT, 'b');hold on
plot(Cubic, 'r');hold off
xlabel('Time(s)',"fontsize", 16);
ylabel('Amplitude',"fontsize", 16);
h = legend('Input Signal', 'Cubic Interpolation');
set(h,"fontsize", 16);
grid on

figure(3);
plot(AudioMag, 'b'); hold on
plot(CubicMag, 'r'); hold off
xlabel('Frequency(Hz)',"fontsize", 16);
ylabel('Amplitude Spectrum',"fontsize", 16);
h = legend('Input Signal', 'Cubic Interpolation');
set(h,"fontsize", 16);
title('Magnitude',"fontsize", 16);

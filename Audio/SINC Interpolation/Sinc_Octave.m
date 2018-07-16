pkg load signal;
clear
clc

[AudioSample Fs] = audioread('Super Mario World Music.wav');
Audio = transpose(AudioSample);

M = 5;
n = numel(Audio);

DownS = decimate(Audio, M);
Sinc = resampleSINC(DownS, M);
Sinc = Sinc(1:n);

%------------------ Analise das Metricas ----------------------------%
ME = abs(Audio - Sinc);

aux = 0;
for i=1:n
  aux = aux + abs(Audio(1,i) - Sinc(1,i));
end
MAE = aux/n;

aux = 0;
for i=1:n
  aux = aux + (abs(Audio(1,i) - Sinc(1,i)))^2;
end
MSE = aux/n;
RMSE = sqrt(MSE);

aux = 0;
for i=1:n
  aux = aux + Audio(1,i)^2;
end 
NMSE = (MSE*n)/aux;

SNR = 10*log10(aux/(MSE*n));

AudioDFT = fft(Audio);
AudioMag = abs(AudioDFT);
SincDFT = fft(Sinc);
SincMag = abs(SincDFT);
%-----------------------------------------------------------------------%

plot(AudioMag, 'b'); hold on
plot(SincMag, 'r'); hold off
xlabel('Frequency(Hz)',"fontsize", 16);
ylabel('Amplitude Spectrum',"fontsize", 16);
h = legend('Input Signal', 'SINC Interpolation');
set(h,"fontsize", 16);
title('Magnitude',"fontsize", 16);
%figure(1);
%subplot(2,1,1);
%plot(AudioSample, 'b');hold on
%plot(DownS, 'r');hold off
%xlabel('Time(s)');
%ylabel('Amplitude');
%legend('Input Signal', 'Downsampled');
%grid on

%subplot(2,1,2)
%plot(AudioSample, 'b');hold on
%plot(Sinc, 'r');hold off
%xlabel('Time(s)');
%ylabel('Amplitude');
%legend('Input Signal', 'SINC Interpolation');
%grid on

%figure(2);

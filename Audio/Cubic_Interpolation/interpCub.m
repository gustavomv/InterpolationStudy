pkg load signal
clear
clc

[Audio Fs]= audioread('Super Mario World Music.wav');
%[Audio Fs]= audioread('Register.wav');
AudioT = transpose(Audio);
M = 5;
n= numel(AudioT)

DownS = decimate(AudioT, M);
DownS_Values = 0:length(DownS)-1;
Audio_Length = linspace(0, length(DownS), length(AudioT));

Cubic = interp1(DownS_Values, DownS, Audio_Length, 'cubic');

for i=1:n
    if isnan(Cubic(1,i))
        Cubic(1,i) = 0;
    end
end

%------------------ Analise das Metricas ----------------------------%
ME = abs(AudioT - Cubic);

aux = 0;
for i=1:n
  aux = aux + abs(AudioT(1,i) - Cubic(1,i));
end
MAE = aux/n;

aux = 0;
for i=1:n
  aux = aux + (abs(AudioT(1,i) - Cubic(1,i)))^2;
end
MSE = aux/n;
RMSE = sqrt(MSE);

aux = 0;
for i=1:n
  aux = aux + AudioT(1,i)^2;
end 
NMSE = (MSE*n)/aux;

SNR = 10*log10(aux/(MSE*n));

AudioDFT = fft(AudioT);
AudioMag = abs(AudioDFT);
CubicDFT = fft(Cubic);
CubicMag = abs(CubicDFT);

plot(AudioMag, 'b');hold on;
plot(CubicMag, 'r');hold off;

%figure(1);
%subplot(2,1,1);
%plot(AudioT, 'b');hold on
%plot(DownS, 'r');hold off
%xlabel('Time(s)');
%ylabel('Amplitude');
%legend('Input Signal', 'Downsampled');
%grid on

%subplot(2,1,2)
%plot(AudioT, 'b');hold on
%plot(Cubic, 'r');hold off
%xlabel('Time(s)');
%ylabel('Amplitude');
%legend('Input Signal', 'Cubic Interpolation');
%grid on

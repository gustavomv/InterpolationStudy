pkg load signal
clear
clc

[AudioSample Fs]= audioread('Super Mario World Music.wav');
Audio = transpose(AudioSample);

M = 5;
n = numel(Audio);

DownS = decimate(Audio, M);
DownS_Values = 0:length(DownS)-1;
AudioSamples_Length = linspace(0, length(DownS), length(Audio));

Linear = interp1(DownS_Values, DownS, AudioSamples_Length, 'linear');

for i=1:n
    if isnan(Linear(1,i))
        Linear(1,i) = 0;
    end
end

%------------------ Analise das Metricas ----------------------------%
ME = abs(Audio - Linear);

aux = 0;
for i=1:n
  aux = aux + abs(Audio(1,i) - Linear(1,i));
end
MAE = aux/n;

aux = 0;
for i=1:n
  aux = aux + (abs(Audio(1,i) - Linear(1,i)))^2;
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
LinearDFT = fft(Linear);
LinearMag = abs(LinearDFT);

plot(AudioMag, 'blue');hold on
plot(LinearMag, 'red');hold off
%-----------------------------------------------------------------------%

%figure(1);
%subplot(2,1,1);
%plot(Audio, 'b');hold on
%plot(DownS, 'r');hold off
%xlabel('Time(s)');
%ylabel('Amplitude');
%legend('Input Signal', 'Downsampled');
%grid on

%subplot(2,1,2)
%plot(Audio, 'b');hold on
%plot(Linear, 'r');hold off
%xlabel('Time(s)');
%ylabel('Amplitude');
%legend('Input Signal', 'Linear Interpolation');
%grid on
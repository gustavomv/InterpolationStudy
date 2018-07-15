[AudioSample Fs] = audioread('Register.wav');
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

plot(AudioMag, 'blue');hold on
plot(SincMag, 'red');hold off
%-----------------------------------------------------------------------%

%figure(1);
%subplot(2,1,1);
%plot(AudioSample, 'blue');hold on
%plot(DownS, 'red');hold off
%xlabel('Time(s)');
%ylabel('Amplitude');
%lgd = legend('Input Signal', 'Downsampled');
%lgd.FontSize = 10;
%lgd.FontWeight = 'bold'
%grid on

%subplot(2,1,2)
%plot(AudioSample, 'blue');hold on
%plot(Sinc, 'red');hold off
%xlabel('Time(s)');
%ylabel('Amplitude');
%lgd2 = legend('Input Signal', 'SINC Interpolation');
%lgd2.FontSize = 10;
%lgd2.FontWeight = 'bold'
%grid on

%figure(2);
%plot(ME);
%plot(AudioF, AudioMag, 'blue'); hold on
%plot(SincF, SincMag, 'red'); hold off
%lgd3 = legend('Input Signal', 'SINC Interpolation');
%lgd3.FontSize = 10;
%lgd3.FontWeight = 'bold'
%title('Magnitude');

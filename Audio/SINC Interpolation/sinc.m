[AudioSample Fs] = audioread('Super Mario World Music.wav');
Audio = transpose(AudioSample);
M = 5;

DownS = decimate(Audio, M);
Sinc = resampleSINC(DownS, M);

AudioF = (0:length(AudioSample)-1)*100/length(AudioSample); %Frequency vector
SincF = (0:length(Sinc)-1)*100/length(Sinc);

AudioDFT = fft(AudioSample);
SincDFT = fft(Sinc);
AudioMag = abs(AudioDFT);
SincMag = abs(SincDFT);

figure(1);
subplot(2,1,1);
plot(AudioSample, 'blue');hold on
plot(DownS, 'red');hold off
xlabel('Time(s)');
ylabel('Amplitude');
lgd = legend('Input Signal', 'Downsampled');
lgd.FontSize = 10;
lgd.FontWeight = 'bold'
grid on

subplot(2,1,2)
plot(AudioSample, 'blue');hold on
plot(Sinc, 'red');hold off
xlabel('Time(s)');
ylabel('Amplitude');
lgd2 = legend('Input Signal', 'SINC Interpolation');
lgd2.FontSize = 10;
lgd2.FontWeight = 'bold'
grid on

figure(2);
plot(AudioF, AudioMag, 'blue'); hold on
plot(SincF, SincMag, 'red'); hold off
lgd3 = legend('Input Signal', 'SINC Interpolation');
lgd3.FontSize = 10;
lgd3.FontWeight = 'bold'
title('Magnitude');

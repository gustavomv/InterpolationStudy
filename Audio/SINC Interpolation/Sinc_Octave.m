pkg load signal;
clear
clc

[AudioSample Fs] = audioread('Voice.wav');
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
plot(AudioSample, 'b');hold on
plot(DownS, 'r');hold off
xlabel('Time(s)');
ylabel('Amplitude');
legend('Input Signal', 'Downsampled');
grid on

subplot(2,1,2)
plot(AudioSample, 'b');hold on
plot(Sinc, 'r');hold off
xlabel('Time(s)');
ylabel('Amplitude');
legend('Input Signal', 'SINC Interpolation');
grid on

figure(2);
plot(AudioF, AudioMag, 'b'); hold on
plot(SincF, SincMag, 'r'); hold off
legend('Input Signal', 'SINC Interpolation');
title('Magnitude');
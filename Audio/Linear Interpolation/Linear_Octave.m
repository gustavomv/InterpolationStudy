pkg load signal
clear
clc

[AudioSample Fs]= audioread('Super Mario World Music.wav');
Audio = transpose(AudioSample);
M = 5;

DownS = decimate(Audio, M);
DownS_Values = 0:length(DownS)-1;
AudioSamples_Length = linspace(0, length(DownS), length(Audio));

Linear = interp1(DownS_Values, DownS, AudioSamples_Length, 'linear');

figure(1);
subplot(2,1,1);
plot(Audio, 'b');hold on
plot(DownS, 'r');hold off
xlabel('Time(s)');
ylabel('Amplitude');
legend('Input Signal', 'Downsampled');
grid on

subplot(2,1,2)
plot(Audio, 'b');hold on
plot(Linear, 'r');hold off
xlabel('Time(s)');
ylabel('Amplitude');
legend('Input Signal', 'Linear Interpolation');
grid on
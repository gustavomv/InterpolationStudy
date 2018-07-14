[AudioSample Fs] = audioread('Super Mario World Music.mp3');
Audio = transpose(AudioSample);
M = 5;

DownS = decimate(Audio, M);
Sinc = resampleSINC(DownS, M);

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

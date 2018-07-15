[AudioSample Fs]= audioread('Register.wav');
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
%plot(Audio, 'blue');hold on
%plot(DownS, 'red');hold off
%xlabel('Time(s)');
%ylabel('Amplitude');
%lgd = legend('Input Signal', 'Downsampled');
%lgd.FontSize = 10;
%lgd.FontWeight = 'bold'
%grid on

%subplot(2,1,2)
%plot(Audio, 'blue');hold on
%plot(Linear, 'red');hold off
%xlabel('Time(s)');
%ylabel('Amplitude');
%lgd2 = legend('Input Signal', 'Linear Interpolation');
%lgd2.FontSize = 10;
%lgd2.FontWeight = 'bold'
%grid on

%figure(2);
%plot(AudioF, AudioMag, 'blue'); hold on
%plot(LinearF, LinearMag, 'red'); hold off
%lgd3 = legend('Input Signal', 'Linear Interpolation');
%lgd3.FontSize = 10;
%lgd3.FontWeight = 'bold'
%title('Magnitude');
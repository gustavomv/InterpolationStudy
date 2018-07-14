%Preparando Ambiente
pkg load signal
close all
clear all

% Abrindo arquivo de audio
Fs=16000;
%[audio, Fs]=wavread ('Super Mario World Music.wav');
[audio Fs]=wavread ('Register.wav');
figure(1);
subplot(2,2,1);
plot(audio,'b')					%Plota grafico do audio original
hold;
grid;
xlabel('Tempo');
ylabel('Amplitude');
title('Comparação entre amostras');

%------------------------------------Downsampling-----------------------------------
n=2;						%Fator da taxa de amostragem
audio_down = downsample(audio,n);		%Diminui o valor da taxa de amostragem da matriz
plot(audio_down, 'r');				%Plota grafico do audio diminuido

%------------------------------------Interolacao------------------------------------
audio_inter=interp2(audio_down, 'linear');	%Realiza a filtragem com o filtro linear

%figure(2);
subplot(2,2,2);
hold
grid
xlabel('Tempo');
ylabel('Amplitude');
title('Audio Filtrado x Audio Diminuído');
plot(audio_inter,'g')
plot(audio_down,'r')

%figure(3);
subplot(2,2,3);
hold;
grid;
xlabel('Tempo');
ylabel('Amplitude');
title('três audios');
plot(audio,'r')
plot(audio_down,'g:*')
plot(audio_inter,'b:.')

sound(audio, Fs)
sound(audio_down, Fs)
sound(audio_inter,Fs)

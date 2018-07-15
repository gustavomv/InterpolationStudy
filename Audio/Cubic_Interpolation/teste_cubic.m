pkg load signal
clear
clc

[Audio Fs]= audioread('Super Mario World Music.wav');
AudioT = transpose(Audio);
M = 5;

DownS = decimate(AudioT, M);
DownS_Values = 0:length(DownS)-1;
Audio_Length = linspace(0, length(DownS), length(AudioT));

Cubic = interp1(DownS_Values, DownS, Audio_Length, 'cubic');
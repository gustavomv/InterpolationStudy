pkg load signal
close all
clear all

[AudioSample Fs] = audioread('Super Mario World Music.wav');
AudTransp = transpose(AudioSample); 
M=5;

DownS = decimate(Audio, M);

TimeAudDowns = linspace (1,columns(DownS),columns(Downs));

AmpAudDowns = transpose(DownS);

lagrangepoly(TimeAudDowns,AmpAudDowns);

plot(lagrangepoly(TimeAudDowns,AmpAudDowns));
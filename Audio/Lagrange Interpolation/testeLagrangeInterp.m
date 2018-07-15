pkg load signal
close all
clear all

[Audio Fs] = audioread('Super Mario World Music.wav');
%AudTransp = transpose(Audio); 
M=5;

DownS = decimate(Audio, M);

TimeAudDownS = linspace (1,rows(DownS),rows(DownS));

AmpAudDownS = transpose(DownS);

lagrangepoly(TimeAudDownS,AmpAudDownS);

plot(lagrangepoly(TimeAudDownS,AmpAudDownS));
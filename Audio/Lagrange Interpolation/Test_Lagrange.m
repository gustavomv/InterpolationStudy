x = linspace(0,2*pi,50);
y = sin(x);
M = 5;

DownS = decimate(y, M);
xi = 0:length(DownS)-1;
Lag = lagrange(x,xi,DownS);

plot(Lag)

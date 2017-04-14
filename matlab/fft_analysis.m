
% Normalize the input
m = (max(y)-min(y))/2;
y1 = y/(y-m);

Y = fft(y1,NFFT)/NFFT;
f = linspace(0,1,NFFT/2+1);
subplot

% Plot single-sided amplitude spectrum.
subplot(1,2,1);
plot(f,20*log(abs(Y(1:NFFT/2+1)))) 
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')

% Plot time domain
subplot(1,2,2);
plot(y1(1:250));
title('Time domain')
xlabel('time')
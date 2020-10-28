function main() 
load dataset.mat

Fs = 256; 
L = length(eeg);
T= 1/Fs; 
t = (0:L-1)*T;


f = Fs*(0:(L/2))/L;

converted = fft(eeg); 
P2 = abs(converted/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

figure(1)
plot(f,P1);
xlabel('Frequency Hz')
ylabel('Amplitude')
title(' Fourier Domain of EEG Data')
figure(2)
stft(eeg,max(t),'Window',hann(64,'symmetric') )
end 
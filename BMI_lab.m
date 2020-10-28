
function main()
close all 
Fs = 10;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 10000;             % Length of signal
t = (0:L-1)*T;        % Time vector
max(t)
%sampling frequency is 256 hz  for the data 
%period is 2pi / B   we want 
% period  

f1 = @(x) 10*sin(2*pi*x/50); 
f2 = @(x) 10*sin(2*pi*x/5); 
f3 = @(x) 10*sin(2*pi*x/10); 
f4 = @(x) 10*sin(2*pi*x/2); 
f5 = @(x) 10*sin(2*pi*x); 
y = f1(t) + f2(t) + f3(t) + f4(t) +f5(t); 
funcs = {f1,f2,f3,f4,f5};
figure(1)
for i=1:5
    subplot(5,1,i)
    plot(t,funcs{i}(t) ); 
    xlabel('Time (ms)')
    ylabel('Amplitude') 
end
figure(2)
plot(t,y) 

f = Fs*(0:(L/2))/L;

P1  = getFFT(y,L); 
figure(3)
plot(f,P1);
xlabel('Frequency Hz')
ylabel('Amplitude')
xlim([0,2])

y_small_noise = y  + randn(size(y)); 
smal_noise_p1 = getFFT(y_small_noise,L); 
y_large_noise = y + 10*randn(size(y));
large_noise_p1 = getFFT(y_large_noise,L); 
figure(4)
subplot(1,2,1)
plot(f,smal_noise_p1) 
title('0 to 1 noise added')
xlabel('Frequency Hz')
ylabel('Amplitude')
xlim([0,2])
subplot(1,2,2)
plot(f,large_noise_p1)
title(' 0 to 10 noise added')
xlabel('Frequency Hz')
ylabel('Amplitude')
xlim([0,2])


%%Problem C: 

data = [] 
for i =1:4
    tmp = funcs{i}(t); 
    scaleA = ( 1:10000 )./5000
    tmp = scaleA.* tmp; 
    data = [data tmp]; 
    
end
size(data)
figure(5)
plot(data)
xlabel('Time (ms)')
ylabel('Amplitude')
figure(6) 
domain_merged = getFFT(data,40000)
L= 40000;
merged_f = Fs*(0:(L/2))/L;
plot(merged_f,domain_merged);
xlim([0,1])
xlabel('Frequency Hz')
ylabel('Amplitude') 
figure(7)
stft(data,10,'Window',hann(64,'symmetric'));
title(' SFT Window size 64') 
figure(8)
stft(data,10,'Window',hann(32,'symmetric'));
title(' SFT Window size 32') 

% trial proceses of brain stimulus 
% when you present a stimulus you obtain a response 
%  we have data as snippets of multiple trials 
% we have a continious trial  data 
%can we detect how many trials have been done 


end 


function powerDomain = getFFT(y,L)
    converted = fft(y); 
    P2 = abs(converted/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
   powerDomain= P1; 
end 


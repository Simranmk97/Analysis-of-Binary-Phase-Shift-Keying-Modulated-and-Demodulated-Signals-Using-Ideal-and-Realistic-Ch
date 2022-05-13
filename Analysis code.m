%% Simran Karim 
%% Simulate a BPSK system in MATLAB and apply DPSK on it
clear all, clc
% Generate a bit sequence/message

c = randn(25,1); % taken from a normal distrubution % 100  bits in part 3
b = (c>=0)*2-1; % using Matlab logic operation to create random discrete 
% sequence of bits with values +1 and -1
% b(t) 

% Modulate the bit sequence

T = 0.001; % bit duration in s
fc = 100e3; % A carier frequnency Hz
phi = 0; % carrier phase is 0 radians
fs = 1e6; % a sampling frequency in samples/s
wc = 2*pi*fc; 

[x,btilde] = BPSK(b,fc,phi,T,fs); % fc = 1 % BPSK results
saveas(gcf,'btilde.png')
DBPSK(x,fc,phi,T,fs); % DPSK results
saveas(gcf,'bhat.png')

%% Demodulate on a custom message
clear all, clc
mysignal = get_message('u1110980');


T = 0.001; % bit duration in s
fc = 100e3; % A carier frequnency Hz
phi = 0; % carrier phase is 0 radians
fs = 1e6; % a sampling frequency in samples/s
wc = 2*pi*fc; 

    N = 1000; %cutoff 
    Wn = N/(0.5*fs);
    h = fir1(N,Wn);
    figure;
    freqz(h,1,1024,fs)
    wc = 2*pi*fc;
    samples_total = 1056000;
    t = 1/fs:1/fs:samples_total/fs;
    x1 = mysignal.*cos(wc.*t+phi)*2;
    bhat = conv(x1,h,'same'); % demodulated continuous time signal
    figure;
    subplot(2,1,1);
    plot(t,bhat);
    xlabel('Time [s]'); 
    ylabel('Magnitude');
    title('Estimated Signal mysignal');

    [H,F] = f_analysis(bhat,fs);
    subplot(2,1,2);
    plot(F,abs(H));            % Plot magnitude of the Fourier transform.
    xlabel('Frequency [Hz]');  % Label the x-axis
    ylabel('Magnitude');       % Label the y-axis
    title('Frequency Representation of bhat(t)');  % Plot title

% Converting continuous signal to binary signal

samples_bit_duration = T*fs;
cur_length = samples_bit_duration;
est = [];
while cur_length <= length(mysignal)
    est = [est bhat(cur_length-samples_bit_duration/2)>0];
    cur_length = cur_length + samples_bit_duration;
end

ascii = bin2ascii(est)

%% Study your design  in realistic conditions
clear all, clc
% Channel Noise

% Generate a 100 bit sequence/message

c = randn(100,1)>0; % original signal
b = c*2-1; % using Matlab logic operation to create random discrete 
% sequence of bits with values +1 and -1
% b(t) 

% Modulate the bit sequence

T = 0.001; % bit duration in s
fc = 100e3; % A carier frequnency Hz
phi = 0; % carrier phase is 0 radians
fs = 1e6; % a sampling frequency in samples/s


% BPSK part
    wc = 2*pi*fc;
    samples_bit_duration = T*fs;
    samples_total = length(b)*samples_bit_duration;
    modulated_b = repmat(b,[1,samples_bit_duration]);
    modulated_b = reshape(modulated_b.',[],1).';
    t = 1/fs:1/fs:samples_total/fs;
    BPSK_b = modulated_b.*cos(wc*t+phi);
    x = BPSK_b;

% DPSK part on signal that is introduced to noise

N = 1000; %cutoff
Wn = N/(0.5*fs);
h = fir1(N,Wn);
freqz(h,1,1024,fs);

BER = [];
for sigma = 0:0.1:50
    L = length(x); % number of samples
    x_noisy = x + sigma*randn(1,L);

    bhat = DBPSK(x_noisy,h,fc,phi,T,fs);

    samples_bit_duration = T*fs;
    cur_length = samples_bit_duration;
    est = [];
    while cur_length <= length(bhat)
        est = [est bhat(cur_length-samples_bit_duration/2)>0];
        cur_length = cur_length + samples_bit_duration;
    end
    
    bit_error = sum(abs(est-c.'));
    BER = [BER bit_error/length(b)];
end

figure;
plot([0:0.1:50],BER);
xlabel('Sigma');
ylabel('BER');
title('Increasing BER with Increasing Sigma')
saveas(gcf,'Channel Noise plot.png')


%% Carrier frequency error

clear all, clc
% Carrier Frequency varriation

% Generate a 100 bit sequence/message

c = randn(100,1)>0; % original signal
b = c*2-1; % using Matlab logic operation to create random discrete 
% sequence of bits with values +1 and -1
% b(t) 

% Modulate the bit sequence

T = 0.001; % bit duration in s
fc = 100e3; % A carier frequnency Hz
phi = 0; % carrier phase is 0 radians
fs = 1e6; % a sampling frequency in samples/s


% BPSK part
    wc = 2*pi*fc;
    samples_bit_duration = T*fs;
    samples_total = length(b)*samples_bit_duration;
    modulated_b = repmat(b,[1,samples_bit_duration]);
    modulated_b = reshape(modulated_b.',[],1).';
    t = 1/fs:1/fs:samples_total/fs;
    BPSK_b = modulated_b.*cos(wc*t+phi);
    x = BPSK_b;

% DPSK part on signal that is introduced to noise

N = 1000; %cutoff
Wn = N/(0.5*fs);
h = fir1(N,Wn);
freqz(h,1,1024,fs);

BER = [];
for carrier_freq_varriation = 0:0.5:100
    est_freq = fc+carrier_freq_varriation;
    bhat = DBPSK(x,h,est_freq,phi,T,fs);
    samples_bit_duration = T*fs;
    cur_length = samples_bit_duration;
    est = [];
    while cur_length <= length(bhat)
        est = [est bhat(cur_length-samples_bit_duration/2)>0];
        cur_length = cur_length + samples_bit_duration;
    end
    
    bit_error = sum(abs(est-c.'));
    BER = [BER bit_error/length(b)];
end

figure;
plot([0:0.5:100],BER);
xlabel('Carrier Frequency Variation [Hz]');
ylabel('BER');
title('Changes in BER with Increasing Carrier Frequency')
saveas(gcf,'Carrier Freq var plot.png')

%% Phase Variation

clear all, clc
% Channel Noise

% Generate a 100 bit sequence/message

c = randn(100,1)>0; % original signal
b = c*2-1; % using Matlab logic operation to create random discrete 
% sequence of bits with values +1 and -1
% b(t) 

% Modulate the bit sequence

T = 0.001; % bit duration in s
fc = 100e3; % A carier frequnency Hz
phi = 0; % carrier phase is 0 radians
fs = 1e6; % a sampling frequency in samples/s


% BPSK part
    wc = 2*pi*fc;
    samples_bit_duration = T*fs;
    samples_total = length(b)*samples_bit_duration;
    modulated_b = repmat(b,[1,samples_bit_duration]);
    modulated_b = reshape(modulated_b.',[],1).';
    t = 1/fs:1/fs:samples_total/fs;
    BPSK_b = modulated_b.*cos(wc*t+phi);
    x = BPSK_b;

% DPSK part on signal that is introduced to noise

N = 1000; %cutoff
Wn = N/(0.5*fs);
h = fir1(N,Wn);
freqz(h,1,1024,fs);

BER = [];
for phase_varriation = 0:pi/100:pi
    est_phase = phi+phase_varriation;
    bhat = DBPSK(x,h,fc,est_phase,T,fs);
    samples_bit_duration = T*fs;
    cur_length = samples_bit_duration;
    est = [];
    while cur_length <= length(bhat)
        est = [est bhat(cur_length-samples_bit_duration/2)>0];
        cur_length = cur_length + samples_bit_duration;
    end
    
    bit_error = sum(abs(est-c.'));
    BER = [BER bit_error/length(b)];
end

figure;
plot([0:pi/100:pi],BER);
xlabel('Phase varriation [rad]');
ylabel('BER');

title('Changes in BER with Increasing Phase')
saveas(gcf,'Phase var plot.png')




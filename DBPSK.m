% function bhat = DBPSK(x,fc,phi,T,fs)
%     
%     N = 100; %cutoff
%     Wn = N/(0.5*fs);
%     h = fir1(N,Wn);
%     freqz(h,1,1024,fs);
%     wc = 2*pi*fc;
%     samples_bit_duration = T*fs;
%     samples_total = 25*samples_bit_duration;
%     t = 1/fs:1/fs:samples_total/fs;
%     x1 = x.*cos(wc*t+phi)*2;
%     bhat = conv(x1,h,'same');
%     figure;
%     subplot(2,1,1);
%     plot(t,bhat);
%     xlabel('Time [s]');
%     ylabel('Magnitude');
%     title('Estimated Signal bhat(t)');
% 
% %     frequncy analysis
% 
%     [H,F] = f_analysis(bhat,fs);
%     subplot(2,1,2);
%     plot(F,abs(H));            % Plot magnitude of the Fourier transform.
%     xlabel('Frequency [Hz]');  % Label the x-axis
%     ylabel('Magnitude');       % Label the y-axis
%     title('Frequency Representation of bhat(t)');  % Plot title
%     xlim([0,5000])
% end


%% Reusing function differently for part 3:
function bhat = DBPSK(x,h,fc,phi,T,fs)
    wc = 2*pi*fc;
    samples_bit_duration = T*fs;
    samples_total = 100*samples_bit_duration;
    t = 1/fs:1/fs:samples_total/fs;
    x1 = x.*cos(wc*t+phi)*2;
    bhat = conv(x1,h,'same'); % demodulated cont. time signal, estimate of tilde b

end


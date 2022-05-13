function [x,btilde] = BPSK(b,fc,phi,T,fs)
    samples_bit_duration = T*fs;
    samples_total = 25*samples_bit_duration;
    modulated_b = repmat(b,[1,samples_bit_duration]);
    modulated_b = reshape(modulated_b.',[],1).';
    t = 1/fs:1/fs:samples_total/fs;
    subplot(2,1,1);
    btilde = modulated_b;
    plot(t,modulated_b); 
    xlabel('Time [s]');
    ylabel('Magnitude');
    title('Continunous-Time Signal tilde(b)(t)');
    
    wc = 2*pi*fc;
    BPSK_b = modulated_b.*cos(wc*t+phi);
      x = BPSK_b;
%     subplot(4,1,2);
%     plot(t,BPSK_b);
%     xlabel('Time [s]');
%     ylabel('Magnitude');
%     title('BPSK Transmitted Signals tilde(b)(t)');


    % the maximum frequncy of 1/T = 1000 Hz

    [H,F] = f_analysis(modulated_b,fs);
    subplot(2,1,2);
    plot(F,abs(H));            % Plot magnitude of the Fourier transform.
    xlabel('Frequency [Hz]');  % Label the x-axis
    ylabel('Magnitude');       % Label the y-axis 
    title('Frequency Representation of tilde(b)(t)');  % Plot title
    xlim([0 5000])

%     [H,F] = f_analysis(BPSK_b,fs);
%     subplot(4,1,4);
%     plot(F,abs(H));            % Plot magnitude of the Fourier transform.
%     xlabel('Frequency [Hz]');  % Label the x-axis
%     ylabel('Magnitude');       % Label the y-axis
%     title('Frequency Representation of x(t)');  % Plot title
%     xlim([0 10e5])
%     axis([0.95e5 1.05e5 0 10000])
   
end



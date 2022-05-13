function [H,F]=f_analysis(x,fs)

Npoints = 2*length(x);
[H,F]  = freqz(x,1,Npoints,fs); % Perform Fourier transform.
% figure()
% plot(F,abs(H));            % Plot magnitude of the Fourier transform.
% xlabel('Frequency [Hz]');  % Label the x-axis
% ylabel('Magnitude');       % Label the y-axis
% title('Frequency representation');  % Plot title
end
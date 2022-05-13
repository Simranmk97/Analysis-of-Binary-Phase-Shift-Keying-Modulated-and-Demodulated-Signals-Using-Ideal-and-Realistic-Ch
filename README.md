# Analysis of Binary Phase Shift Keying Modulated and Demodulated Signals Using Ideal and Realistic Channel and Receiver Conditions

Abstract. This laboratory demonstrates the BPSK modulation and demodulation process on arbitrary signals using MATLAB. A series of experiments demonstrate the effects of realistic and ideal channel and receiver conditions may have on the quality of the estimated signals.

## INTRODUCTION AND MOTIVATION

### Motivation

In the field of communications system, the process of modulation to a signal is an essential process that allows the conversion of a low-frequency signal to a high-frequency signal to make it suitable for transmission over a variety of physical communication channel. Modulation process can be used to transmit signals over air, in optic fibers and across outer space. Additionally, modulation process is useful in terms of transferring multiple signals with their unique frequency range over a smaller antenna, which prevents usage of large/long channels. On the other hand, demodulation is an equally important process that converts a high-frequency signal back to its low-frequency signal, or in other words, it separates the signal from the modulated carrier back to its original form. It is essential to demodulate a signal since high-frequency signal are not useful, for example, high-frequency audio signal is above the human hearing range. Therefore, understanding these two processes becomes important, which was the goal of this laboratory and this report details on the methodology and results of these two processes.

### Overview

This report details on two parts that the laboratory consisted of. First, the lab focused on simulating a Binary Phase Shift Keying (BPSK) modulation and BPSK demodulation of that modulated signal, where it was assumed that the communication channel was ideal.  The second part of the lab focused on analyzing the effects of channel noise, ISI and other noise at the receiver end to simulate ‘realistic’ conditions. Finally, the results were analyzed to understand how the processes work and how is a signal affected in realistic conditions. 

### Summary of Methodology

In the first part of the lab, a binary, baseband signal was first modulated through a BPSK modulator system and a receiver system demodulated the transmitted signal. These systems were built in the programming software MATLAB. The second part of the lab simulated realistic channel errors by introducing white Gaussian noise to the modulated signal, inducing carrier frequency error (carrier frequency of modulated signal doesn’t match up perfectly with carrier frequency at demodulator system) by varying the carrier frequency at the demodulator system and inducing phase error (phase of modulated signal doesn’t match up perfectly with phase at demodulator system) by varying the phase at the demodulator system. This was also executed in MATLAB.

### Summary of Results

The results were successfully able to show the impacts of realistic and unrealistic channel and receiver conditions would have on the BPSK modulated and demodulated systems. With unrealistic settings, the difference between the original and the estimated signal was insignificant. With realistic settings, the Bit error rate was significant, therefore, indicating that the difference between the estimate and original signal was significant.

## EXPERIMENTAL METHODS
In this lab, the signal that was modulated was a binary, baseband signal that had values of 1 and -1 before passing it into the modulator or the BPSK transmitter system. The BPSK is one of the form of phase shift keying modulation so the BPSK system used the bit information to modulate the phase of the carrier signal cos(ωct), for example, if bit was 1, then cos(ωct +0), and if bit was -1, then cos(ωct + π). To design this BPSK system, a simple MATLAB function was created that took in parameters such as bit duration T, carrier frequency fc, carrier phase φ, and a sampling frequency fs, as inputs. The function calculated the carrier frequency, ωc using the formula ωc = 2πfc and multiped the binary, baseband signal tilde_b(t) with the carrier signal as follows to get the signal x(t) = tilde_b(t) * cos(ωct + φ). 

The goal of the demodulator system or the DBPSK system was to demodulate the signal x(t) to its high-frequency to its original low-frequency signal. A simple DBPSK function was also created in a similar manner with inputs such as that took in inputs such as the modulated signal x(t), bit duration T, carrier frequency fc, carrier phase φ, and a sampling frequency fs, as inputs. The function demodulated the carrier signal and the halved amplitude by the following calculation x1(t) = x(t) cos(ωct + φ) * 2 to get x1(t) which is the demodulated signal. To get rid of the high-frequency content in x1(t), the function consisted of a low pass filter h(t) with a cutoff frequency of N = 1000. The function utilized the MATLAB built in function fir1 to obtain h(t) = fir1(N,Wn) where Wn is N/(0.5*fs). The function freqz was used to view the magnitude and phase of the h(t). Finally, the high-frequency content of x1(t) was removed by convolving b_hat(t) = x1(t) ∗ h(t) using the conv function, where b_hat is an estimate of tilde_b(t), and the signal is demodulated. 

As mentioned above, in order to do BPSK modulation, binary baseband signal is necessary. The BPSK function also had the operation to generate an arbitrary, random binary signal of 25 bits. The vector of 25 values were initially taken from a normal distribution using the randn function in MATLAB. This vector C[n] of values were converted to 1 and -1 values when C ≥ 0 and C < 0, respectively, to create vector B[n]. The signal B[n] with the 1 and -1 values is a discrete-time signal since MATLAB cannot work with continuous-time signal. Using inputs such as bit duration, and sampling frequency, the total number of samples was calculated. The following operations were used in MATLAB to obtain the time values and the modulated B[n], which is tilde_b as mentioned above:

modulated_B = repmat(b,[1,samples_bit_duration]);

modulated_B = reshape(modulated_b.',[],1).';

t = 1/fs:1/fs:samples_total/fs;

To test the DPSK system, a random message generating function was utilized in this part. The message was a BPSK modulated signal of 105600 bits. The DPSK function was applied to this signal through the process mentioned above. Once the DPSK function was applied and b_hat signal was obtained (demodulated signal), the signal was converted back from continuous time to binary signal. The sample bit duration was calculated by multiplying bit duration with sampling frequency. Then using a while loop, at half a sample bit duration for all values, all the values of b_hat was checked to see if it was greater than zero. This generated a sequence of binary digits. The binary digits were then passed through a binary-to-ascii converting function to convert the binary message to characters/alphabets. 

The lab simulates channel noise to create realistic conditions to see how the demodulated signal may appear comparing to the original when the channel is not ideal. To model noise, an additive white Gaussian noise was introduced to the modulated signal of 100 bits as follows,= xr(t) = x(t) + η(t), where x(t) is the modulated BPSK singal, η(t) is the added noise. In MATLAB, the η(t) was equivalent to sigma*randn(L,1), where sigma was the standard deviation of the noise, which was key parameter that was varied from 0 to 50 in increments of 0.1. Using a for loop, for every new value of sigma, a new noisy signal was generated using all the procedures mentioned above. The goal of this simulation was to obtain the bit error difference, which is the estimated/demodulated signal subtracted from the original/unmodulated signal. From that the bit error rate (BER) was calculated by dividing the total number of bits. BER allows to see how variation in sigma causes the increase in entropy or uncertainty and at what point. 

Similarly, the carrier frequency was varied to simulate imperfect demodulator system that doesn’t have the exact frequency of the BPSK carrier signal’s frequency. Every parameter and method was kept the same except the carrier frequency value was varied from 0 Hz to 100 Hz in increments of 0.5 Hz. Using a for loop, for every carrier frequency value, a new demodulated signal was generated and this demodulated signal was compared with the original signal using the BER. 

Finally, in the same manner, the phase at the demodulator system was varied to simulate an imperfect system as well. For loop was also used to only vary the phase (from 0 radians to π radians in increments of π/2) and everything else was kept the same, so then every new demodulated signal generated was compared against the original signal through the BER. 

## RESULTS AND DISCUSSIONS
Figure 1 illustrates the continuous-time signal tilde_b on top and its frequency representation on the bottom. Figure 2 depicts the estimated, demodulated continuous time signal b_hat on top and its frequency representation in the bottom. The demodulated signal b_hat was generated under the conditions that the channel was ideal, i.e. no noise, or ISI. Upon inspection, it can be seen that b_hat is a very accurate estimate of tilde_b. The amplitude matches up accurately and values coincide at every time point on both figures. However, b_hat upon close inspection has lightly slanted sides, but that does not significantly make it different from tilde_b. That slanted edges could be due to how convolution works in MATLAB programming software.




<img width="397" alt="image" src="https://user-images.githubusercontent.com/105514187/168344200-bdd085e1-a55f-439e-9b79-03ffdbcf7a48.png">
Figure 1




<img width="397" alt="image" src="https://user-images.githubusercontent.com/105514187/168344265-b54c7f94-2986-4465-8c95-2f21ee330aeb.png">
Figure 2


















 


The next plot below show the differences between tilde_b and b_hat with channel noise. Without channel noise, there was no significant difference between the two signals. But there was significant difference between them as the channel noise was increased. This difference is be shown in terms of Bit Error Rate (BER). The of sigma, which was the standard deviation of the noise vs BER in shown in Figure 3. Upon inspection, it is clear that as sigma values ranges from 0 to ~5, the BER is almost zero, indicating almost zero uncertainty or entropy. It can be inferred that the estimated/demodulated signals produced with these sigma values accurately represent the original signal since the BER value is small. As signal value ranges from ~5.5 to 50, the BER values keeps increasing and becomes almost constant at some value near 0.5, reaching maximum saturated uncertainty or entropy. This can be interpreted as the estimated signal varies significantly from the original signal as the sigma values increase. 






<img width="382" alt="image" src="https://user-images.githubusercontent.com/105514187/168344321-cd0dc5eb-1417-4777-945c-a53c231f2962.png">
Figure 3



















The next two plots below show the differences between tilde_b and b_hat with carrier frequency (CF) and phase variation. Inspecting the both of the plots in Figure 4 and Figure 5, it can be said that there is no significant difference between the two signals when CF and phase was not varied. But there was significant difference between them as the CF variation was increased, and differently when phase values was increased. This difference is also shown in terms of Bit Error Rate (BER) in the two plots. In Figure 4, it is clear that as CF was increased, the BER values ranged near ~0.5, indicating that maximum uncertainty or entropy value was reached at this region. This can be further interpreted that the Bit error difference between the estimated signals and the original signal increased as CF at the demodulator system increased, since it couldn’t perfectly match up with the carrier signal’s frequency. In Figure 5, it can be shown that the BER value was zero when the phase value was below ~1.5 radians. Interestingly, the BER value jumps from zero to 1 beyond ~1.5 radians. This can be interpreted as the estimated signals produced using those phase values above ~1.5 have opposite signs as the original signal. Therefore, the BER values indicate maximum uncertainty or entropy at phase values above ~1.5 radians.

<img width="363" alt="image" src="https://user-images.githubusercontent.com/105514187/168344385-81be7a7b-b427-403f-8629-fe12ddeb6c67.png">
Figure 4
<img width="377" alt="image" src="https://user-images.githubusercontent.com/105514187/168344404-63917a24-3d71-4d33-b391-cc814cbac230.png">
Figure 5


### CONCLUSIONS

To conclude, the laboratory goals were met as the results depict successful demonstration of the BPSK modulation and demodulation process on signals with realistic and non-realistic channel and receiver conditions. The methodology was very capable of demonstrating the true picture of the experiments. However, for more demonstration purposes, it could be improved by looking at other realistic factors that can interfere with the estimated signals quality. This experiment allows us to deeply understand how signals can be better processed at the receiving end at engineering settings for example in brain research to decode neural signals in the brain. This experiment can be seen as a stepping stone to understand how undesirable interference can impact the quality of estimated signals and how a receiver can be improved to achieve signals as close to the original signals.

REFERENCES

1.	Retrieved from https://en.wikipedia.org/wiki/Modulation
2.	Retrieved from https://padakuu.com/need-of-modulation-and-demodulation-33-article#:~:text=Need%20of%20demodulation&text=The%20diaphragm%20of%20a%20telephone,from%20radio%2D%20frequency%20carrier%20waves.


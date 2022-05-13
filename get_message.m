function mysignal = get_message( uid )
%GET_MESSAGE Function that gets a BPSK modulated signal based on your UID.
%   MYSIGNAL = get_message(UID) takes your UID and provides a binary phase 
%   shift keyed (BPSK) modulated signal. The modulated signal contains 
%   ASCII from the 1980 and 1981 text adventure games 
%   Zork I and Zork II. 
%
%   INPUTS:
%       UID: A string of your uid (starting with 'u', not '0')
%
%   OUTPUTS:
%  MYSIGNAL: A BPSK modulated signal that, when demodulated, contains the
%            binary form of ascii text
%  
%   
%

%   Function has been precompiled into get_message.p
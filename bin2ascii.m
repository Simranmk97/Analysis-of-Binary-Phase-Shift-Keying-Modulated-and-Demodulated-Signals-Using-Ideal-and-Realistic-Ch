function [ ascii ] = bin2ascii( bin )
%BEST2ASCII Convert a binary string into ASCII text
%   INPUTS:
%       BIN: Vector of values. Value less than 0 are considered binary "0" 
%            and values greater than 0 are considered binary "1" 
%
%  OUTPUTS:
%     ASCII: A character string of the converted binary data. Note that
%     this function assumes each character is 16 bits long. 
%  
%   

    ascii = char(bin2dec(reshape(num2str(bin(:) > 0), length(bin)/16, 16))).';

end


%Calculates the central mode number as the modenumber of the mode closest
%to the mean frequency (which must be provided)
function [mu0,freq0,index] = calmu0(amn,freq,fmean)
absdiff = abs(freq-fmean); %Absolute deviation of the frequencies of modes away from the central frequency
index = find(absdiff==min(absdiff));
mu0 = amn(index); %No need to fix because "find" returns a single index instead of an array of indices in this scenario
freq0 = freq(index);
end
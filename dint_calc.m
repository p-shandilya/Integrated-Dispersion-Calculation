%Originally written on: 04-04-22
%Last updated on: 04-06-22
%Author: Pradyoth Shandilya - shandilya@umbc.edu

%Calculates the integrated dispersion from Greg's data
close all

clearvars
clc

data = readtable('Dispersion.csv','NumHeaderLines',0); %First column is the azimuthal mode number and second column is the linear resonance frequency
data = data{:,:}; %Converts table into matrix

amn = data(:,1); %Azimuthal mode number
freq = data(:,2); %Linear resonance frequency

figure(1);
plot(amn,freq)
xlabel('Azimuthal Mode Number')
ylabel('Frequency')
title('Mode Number - Frequency Plot')

%Reference: Equation 1 from Ultra-efficient frequency comb generation in
%AlGaAs-on-insulator microresonators (Bowers)

vlength = length(amn);
FSR = zeros(vlength,1);

FSR(2:end-1) = 0.5*(freq(3:end)-freq(1:end-2));
FSR(1) = freq(2)-freq(1);
FSR(end) = freq(end)-freq(end-1);


fmean = median(freq); %Mean frequency. Use weighted averages when available
fmean = 281e+12;

[mu0,freq0,index] = calmu0(amn,freq,fmean); 

w_rel = 2*pi*(freq-freq0);
mu_rel = amn - mu0;
D1 = 2*pi*FSR(index);

Dint = (w_rel - mu_rel*D1)/(2*pi);

figure(2);
plot(mu_rel,Dint)
xlabel('Relative Mode Number')
ylabel('D_{int}/(2\pi)')
title('Integrated Dispersion')

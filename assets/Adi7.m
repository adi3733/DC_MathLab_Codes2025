clc;
clear all;
close all;
nr_data_bits = 8192; % Number of data bits
b_data = (randn(1, nr_data_bits)) > 0.5; % Random binary data
b = b_data; % Store binary data
d = zeros(1, length(b)); % Initialize the modulated symbols
% BPSK Modulation
for n = 1:length(b)
    if(b(n) == 0)
        d(n) = exp(1j*2*pi); % Phase shift for bit 0
    end
    if(b(n) == 1)
        d(n) = exp(1j*pi); % Phase shift for bit 1
    end
end
bpsk = d; % BPSK data
% Plotting BPSK Constellation
figure(1);
plot(real(bpsk), imag(bpsk), 'o');
axis([-2 2 -2 2]);
grid on;
xlabel('Real');
ylabel('Imaginary');
title('BPSK Constellation');
% SNR Range
SNRdB = 0:24; % SNR in dB
BER1 = []; % Array to store BER values
SNR1 = []; % Array to store SNR values
% Loop over SNR values
for snr = SNRdB
    sigma = sqrt(10^(-snr / 10)); % Noise standard deviation
    snbpsk = (real(bpsk) + sigma * randn(size(bpsk))) + 1j * (imag(bpsk) + sigma * randn(size(bpsk))); % Add noise
    % Plotting BPSK data with noise
    figure(2);
    plot(real(snbpsk), imag(snbpsk), 'o');
    axis([-2 2 -2 2]);
    grid on;
    xlabel('Real');
    ylabel('Imaginary');
    title('BPSK Constellation with Noise');

    % Receiver: Demodulation
    r = snbpsk;
    bhat = [real(r) < 0]; % Demodulate (decision based on real part)
    bhat = bhat(:)'; % Ensure the result is a row vector
    ne = sum(b ~= bhat); % Count number of errors
    BER = ne / nr_data_bits; % Calculate the Bit Error Rate (BER)
    % Store BER and SNR
    BER1 = [BER1 BER];
    SNR1 = [SNR1 snr];
end
% Plotting of BER vs SNR
figure(3);
semilogy(SNR1, BER1, '-*');
grid on;
xlabel('SNR (dB)');
ylabel('BER');
title('Simulation of BER for BPSK');
legend('BER-simulated');

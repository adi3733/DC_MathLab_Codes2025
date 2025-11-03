clc;
clear all;
close all;

% Comparison of Constellation diagrams of 16-PSK and 16-QAM 
% in presence of noise

M = input('Enter modulation order (e.g., 16 for 16-PSK/QAM): ');
SNR = input('Enter SNR in dB: ');

% Generate random symbols
x1 = randi([0 M-1], 1000, 1);

%% ----- 16-PSK -----
y1 = pskmod(x1, M);
y1n = awgn(y1, SNR, 'measured');
figure;
scatterplot(y1n);
title(['16-PSK Constellation (SNR = ', num2str(SNR), ' dB)']);

y1r = pskdemod(y1n, M);
[num_error_psk, er_rate_psk] = symerr(x1, y1r);
fprintf('16-PSK Symbol Errors = %d, Error Rate = %f\n', num_error_psk, er_rate_psk);

%% ----- 16-QAM -----
y2 = qammod(x1, M);
y2n = awgn(y2, SNR, 'measured');
figure;
scatterplot(y2n);
title(['16-QAM Constellation (SNR = ', num2str(SNR), ' dB)']);

y2r = qamdemod(y2n, M);
[num_error_qam, er_rate_qam] = symerr(x1, y2r);
fprintf('16-QAM Symbol Errors = %d, Error Rate = %f\n', num_error_qam, er_rate_qam);

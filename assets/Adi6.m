clc;
clear all;
close all;
 
N = 4*10^3;             % number of symbols
M = 16;                  % size
k = log2(M);             % bits/symbol
 
 
% for 16-QAM
Re = [-(2*sqrt(M)/2-1):2:-1 1:2:2*sqrt(M)/2-1];
 
Im = [-(2*sqrt(M)/2-1):2:-1 1:2:2*sqrt(M)/2-1];
 
k_QAM = 1/sqrt(10);
 
bdB  = 3:1:13; % SNR range
 
sdB  = bdB + 10*log10(k);
 
% binary to gray code 
 
a = [0:k-1];
 
map = bitxor(a,floor(a/2));
 
[tt ind] = sort(map);                                
 
for i = 1:length(bdB)
    
 
    c = rand(1,N*k,1)>0.5; % random 1's and 0's
    d = reshape(c,k,N).';
    bd = ones(N,1)*(2.^((k/2-1):-1:0)) ; % conversion from binary to decimal
 
    % real
    
    cRe =  d(:,(1:k/2));
    e = sum(cRe.*bd,2);
    f = bitxor(e,floor(e/2));
    
   % imaginary
    cIm =  d(:,(k/2+1:k));
    g = sum(cIm.*bd,2);
    h = bitxor(g,floor(g/2)); 
    
    % mapping the Gray coded symbols into constellation
    modRe = Re(f+1);
    modIm = Im(h+1);
    
    % constellation
    
    mod = modRe + 1i*modIm;
    s = k_QAM*mod; 
    
    % noise
    
    n = 1/sqrt(2)*[randn(1,N) + 1i*randn(1,N)];  
    
%    reciever
    r = s + 10^(-sdB(i)/20)*n; 
 
    % demodulation
    
    r_re = real(r)/k_QAM; 
    r_im = imag(r)/k_QAM; 
 
    % rounding off
    
    
    m = 2*floor(r_re/2)+1;
    m(m>max(Re)) = max(Re);
    m(m<min(Re)) = min(Re);
    
    n= 2*floor(r_im/2)+1;
    n(n>max(Im)) = max(Im);
    n(n<min(Im)) = min(Im);
 
    % To Decimal conversion
    
    oRe = ind(floor((m+4)/2+1))-1; 
    oIm = ind(floor((n+4)/2+1))-1; 
 
    % To binary string
    pRe = dec2bin(oRe,k/2);
    pIm = dec2bin(oIm,k/2);
 
    % binary string to number
    pRe = pRe.';
    pRe = pRe(1:end).';
    pRe = reshape(str2num(pRe).',k/2,N).' ;
    
    pIm = pIm.';
    pIm = pIm(1:end).';
    pIm = reshape(str2num(pIm).',k/2,N).' ;
 
    % counting errors for real and imaginary
    Err(i) = size(find([cRe- pRe]),1) + size(find([cIm - pIm]),1) ;
 
end 
sBer = Err/(N*k);
tBer = (1/k)*3/2*erfc(sqrt(k*0.05*(10.^(bdB/10))));
 
% plot
figure
semilogy(bdB,tBer,'rs-','LineWidth',2);
hold on
semilogy(bdB,sBer,'kx-','LineWidth',2);
grid on
legend('theory', 'simulation');
xlabel('SNR dB')
ylabel('Bit Error Rate')
title('BER VS SNR')
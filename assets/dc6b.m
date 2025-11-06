%Comparison of Constellation diagrams of 16-PSK and 16-QAM 
%in presence of noise, SNR=20 dB 
%16-PSK 

M=input('Number_Symbols='); 
SNR=input('SNR of QPSK system in dB='); 
x1=randint(1000,1,M); 
y1=pskmod(x1,M); 
y1n=awgn(y1,SNR,'measured'); 
scatterplot(y1n); 
y1r=pskdemod(y1n,M); 
[num_error,er_rate]=symerr(x1,y1r) 
%Constellation diagram of QAM in presence of noise with SNR=5dB y2=qammod(x1,M); 
y2n=awgn(y2,SNR,'measured'); 
scatterplot(y2n); 
y2r=qamdemod(y2n,M); 
[num_error,er_rate]=symerr(x1,y2r)

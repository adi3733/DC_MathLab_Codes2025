clc;
clear all;
close all;
n=input('enter the length of code word frame n:');
l=input('enter the length of msg vector l:');
m=input('enter the number of flip flops m:');
msg=input('enter the number of actual msg bits:');
g1=input('enter the impulse response of adder 1:');
g2=input('enter the impulse response of adder2:');
k=n+1;
a=n+(l+k-1);
msg=[msg zeros(1,k-1)];
b=num2str(g1);
c=num2str(g2);
cv1=str2num(dec2base(bin2dec(b),8));
cv2=str2num(dec2base(bin2dec(c),8));
cv=[cv1,cv2]
trellis=poly2trellis(k,cv)
code=convenc(msg,trellis)

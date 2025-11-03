clc;
clear;
%disp('Aditya R Ghayal ROLL NO: 23');
msg=input('enter the msg sequence=');
display(msg);
a=str2num(dec2base(bin2dec('111'),8));
b=str2num(dec2base(bin2dec('110'),8));
g=[a b];
trellis=poly2trellis(3,g);
code=convenc(msg,trellis)
tblen=1;
decoded=vitdec(code,trellis,tblen,'trunc','hard')

clc;
clear all;
close all;
n= input('enter the code length n');
k=input('Enter message length k');
msg=input('Enter message(k bits)');
gpol=cyclpoly(n,k);
disp(gpol);
encdata=encode(msg,n,k,'cyclic/binary',gpol);
disp('The Codeword is');
disp(encdata);
r=input('enter the received codeword');
G_mat=cyclgen(n,gpol);
disp('The generator matrix is');
disp(G_mat);
err_vec=syndtable(G_mat);
disp('Thr error vector table is');
disp(err_vec);
decData=decode(r,n,k,'cyclic/binary',gpol,err_vec);
disp('The correct message is');
disp(decData)


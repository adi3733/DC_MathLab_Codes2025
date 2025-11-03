clc;
clear all;
close all;
G = input('Enter the generator polynomial: ');
[p, k] = size(G);
n = k + k - 1;
e = eye(n);
for i = 1:n
[~, R(i,1:n)] = deconv(e(i,1:n), G);
end
R = mod(R,2);
c = input('Enter the received codeword: ');
[~, r] = deconv(c, G);
r = mod(r,2);
if isequal(r, zeros(1, length(r)))
disp('Received code word is correct');
else
for i = 1:n
if isequal(r, R(i,1:n))
disp(['Error is in bit no. ', num2str(i)]);
if c(i) == 0
c(i) = 1;
else
c(i) = 0;
end
end
end
disp('The corrected codeword is:');
disp(c);
end
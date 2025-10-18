%% Entering Symbols and their probabilities
symbol = input('Enter the symbols: ');
p = input('Enter the symbol probabilities: ');

% Create Huffman Dictionary
[dict, avglen] = huffmandict(symbol, p);

%% Printing the codewords
disp('Huffman Code Dictionary:');
for i = 1:length(dict)
    codeword = num2str(dict{i,2});
    codeword = regexprep(codeword, ' ', ''); % remove spaces
    fprintf('Symbol: %d | Codeword: %s\n', dict{i,1}, codeword);
end

%% Printing entropy, efficiency and redundancy
Hx = 0;
for c = 1:length(p)
    hx = p(c) * log2(1/p(c));
    Hx = Hx + hx;
end

fprintf('Calculation of Entropy:\n%.4f\n', Hx);

% Calculation of coding efficiency
n1 = Hx / avglen;
Efficiency = n1 * 100;
fprintf('Calculation of Coding Efficiency:\nEfficiency = %.2f %%\n', Efficiency);

% Calculation of redundancy
Redundancy = 1 - n1;
fprintf('Calculation of Redundancy:\nRedundancy = %.2f %%\n', Redundancy * 100);

%% Printing encoded and decoded symbols
sig = input('Enter the symbols to be transmitted: ');
disp('Symbols after encoding are:');
hcode = huffmanenco(sig, dict);
disp(hcode');

disp('Encoded signals after decoding are:');
dhsig = huffmandeco(hcode, dict);
disp(dhsig');

if isequal(sig, dhsig)
    disp('? Encoded signal is completely recovered');
else
    disp('? Encoded signal is not properly recovered');
end

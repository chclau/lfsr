% Generate LFSR

a = uint32(0);

% Order of the polynom, up to 32
% Matlab range 1 to 32, VHDL 0 to 31
order = 16;

av = zeros(2^order-1, 1);

ii = 1;

while (ii < 2^order)
    fb1 = bitxor(bitget(a, 15), bitget(a, 14));
    fb2 = bitxor(bitget(a, 13), bitget(a, 6));
    feedback = not( xor (fb1, fb2));
    
    a = bitshift( a, 1, order) + uint32(feedback);
    av(ii, 1) = a;
    ii = ii + 1;
end

y = zeros(size(av));

for ii = 1:length(av)
    [rows] = find(av == (ii-1));
    y(ii) = size(rows, 1);
end

max(y)
min(y)
    

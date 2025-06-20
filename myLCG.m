function mat = myLCG(seed, M)
    % Fully double-based LCG for FreeMat to avoid integer overflow
    a = 1664525;
    c = 1013904223;
    m = 2^64;   

    state = double(seed);
    mat = zeros(1, M);   

    for i = 1:M
        state = mod(a * state + c, m);   
        mat(i) = (state / m) * 100;      
    end
end

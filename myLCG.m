function mat = myLCG(seed, M)
    a = 1664525;
    c = 1013904223;
    m = 2^32;
    
    state = double(seed);
    N = 3;
    mat = zeros(M, N);

    for i = 1:M
        for j = 1:N
            state = mod(a * state + c, m);
            mat(i, j) = round(abs(state / m) * 99) + 1;
        end
    end
end

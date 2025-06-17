function mat = myLCG(seed, M, N)
    % Fully double-based LCG for FreeMat to avoid integer overflow
    a = 1664525;
    c = 1013904223;
    m = 2^32;

    state = double(seed);
    mat = zeros(M, N);

    for i = 1:M
        for j = 1:N
            state = mod(a * state + c, m);       % use all double math
            mat(i, j) = state / m;               % normalize to [0,1)
        end
    end
end

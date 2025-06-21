function r = xorshiftr(seed, n)
    %initialize state
    state = [mod(seed, 2^32), mod(seed + 123456789, 2^32)];
    r = zeros(n, 3);

    for i = 1:n*3
        x = state(1);
        x = mod(x + mod(x * 2^26, 2^32), 2^32);
        x = mod(x + floor(x/2^17), 2^32);
        x = mod(x + mod(x * 2^23, 2^32), 2^32);
        
        y = state(2);
        state(1) = mod(y + x, 2^32);
        state(2) = mod(x + mod(y * 2^5, 2^32), 2^32);

        if i <= n
            r(i, 1) = floor(state(1)/2^32 * 100) + 1; 
        elseif i <= 2*n
            r(i-n, 2) = floor(state(1)/2^32 * 100) + 1; 
        else
            r(i-2*n, 3) = floor(state(1)/2^32 * 100) + 1;
        end
    end
end

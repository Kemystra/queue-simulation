function r = xorshiftr(seed, n)
    %initialize state
    state = [mod(seed, 2^32), mod(seed + 123456789, 2^32)];
    r = zeros(n, 3);

    for i = 1:n*3
    %this is the xorshiftr+ operations 
        %this performs the arithmetic operations for bit shifts
        x = state(1); %gets x value from state
        x = mod(x + mod(x * 2^26, 2^32), 2^32); %left shift 26
        x = mod(x + floor(x/2^17), 2^32); %right shift 17
        x = mod(x + mod(x * 2^23, 2^32), 2^32); %left shift 23
        
        %updates the state vector and also maintaining two state variables
        y = state(2);
        state(1) = mod(y + x, 2^32); %combines old y and transformed x
        state(2) = mod(x + mod(y * 2^5, 2^32), 2^32); %combines x and transformed y

        %output matrix column by column 
        if i <= n
            r(i, 1) = floor(state(1)/2^32 * 100) + 1; 
        elseif i <= 2*n
            r(i-n, 2) = floor(state(1)/2^32 * 100) + 1; 
        else
            r(i-2*n, 3) = floor(state(1)/2^32 * 100) + 1;
        end
    end
end

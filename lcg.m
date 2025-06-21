function g = lcg(seed, M)

    a = 1664525;       % set multiplier 
    c = 1013904223;    % set increment
    m = 2^32;         % modulus to turn values into 32 bit

    state = uint32(seed*2^32);
 

    g = zeros(M, 3);

    % Loop to fill the matrix with values
    for i = 1:M*3
            % Update the state using the LCG formula: state = (a * state + c) mod m
            state = mod(a * double(state) + c, m);

            % Scale the generated value to the range [1, 100] and store it in the matrix
            g(i) = round(abs(state / m) * 99) + 1;  % Map to range [1, 100]
    end
end

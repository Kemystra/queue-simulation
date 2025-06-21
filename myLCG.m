function mat = myLCG(seed, M)

    a = 1664525;       
    c = 1013904223;     
    m = 2^64;         

    state = double(seed);

    N = 3; 

    mat = zeros(M, N);

    % Loop to fill the matrix with values
    for i = 1:M
        for j = 1:N
            % Update the state using the LCG formula: state = (a * state + c) mod m
            state = mod(a * state + c, m);

            % Scale the generated value to the range [1, 100] and store it in the matrix
            mat(i, j) = round(abs(state / m) * 99) + 1;  % Map to range [1, 100]
        end
    end
end

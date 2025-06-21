function g = lcg(seed, M)

    a = 1664525;        
    c = 1013904223;  
    m = 2^32;        

    state = uint32(seed*2^32);  %convert seed to 32 bit unsigned number 

    g = zeros(M, 3);   %use to store random number

    %Loop the number
    for i = 1:M*3
            % change state to double and use formula = (a * state + c) mod m 
            state = mod(a * double(state) + c, m);

            % become a integer between [0,100] and store in matrix
            g(i) = round(abs(state / m) * 99) + 1;  % Map to range [1, 100]
    end
end

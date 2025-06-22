function r = permcg(seed, n)

    % Constants (from PCG spec)
    multiplier = uint32(hex2dec('5851F42D'));  % 1481765933, lower 32 bits of the og 64 bit const
    increment = uint32(hex2dec('4C957F2D'));   % 1284865837, same thing as above
    modulus = uint32(2^32);

    % Initialize state
    state = uint32(seed);
    r = zeros(n,3);

    for k = 1:n*3
        % Advance state using LCG with modulo 2^32
        state = mod(double(state) * double(multiplier) + double(increment), 2^32);
        state = uint32(state);  % Ensure it's uint32 again

        % Xor-shift: xorshifted = state ^ (state >> 11)
        shifted = floor(double(state) / 2^11);
        xorshifted = bitxor(state, uint32(shifted));

        % Rotation amount: bottom 5 bits of state
        rot = bitand(state, uint32(31));  % equivalent to state % 32

        % Emulate rotate-right:
        val = double(xorshifted);
        rot = double(rot);
        right = floor(val / 2^rot);
        left = mod(val, 2^rot) * 2^(32 - rot);
        rotated = mod(right + left, 2^32);

        % Map to range [1, 100]
        r(k) = mod(rotated, 100) + 1;
    end
end

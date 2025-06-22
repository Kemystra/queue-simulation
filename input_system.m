% Input parameter: nothing
% Output: an array of format [number of cars, seed value, PRNG selection]

function [car_num, seed, prng_selection] = get_user_input()
    printf('Welcome to Queue Simulator\n');

    % Get number of cars
    car_num = cast(input('Enter no. of cars: '), 'int32');

    % Get seed or randomize
    seed_decision = getline('Do you want to set your own seed value? [Y/n] : ');
    seed_decision = lower(seed_decision);
    seed = 0;

    if (strcmp('y', seed_decision(1)))
        seed = uint64(input('Enter your seed value: '));
    elseif (strcmp('n', seed_decision(1)))
        % rand() returns the number in [0,1)
        seed = rand() * 2^64;
    else
        error('Wrong input, expected Y or N');
        return;
    end

    % Get PRNG selection
    disp('Please select a PRNG to use');
    disp('(1) Linear Congruential Generator (LCG)');
    disp('(2) Permuted Congruential Generator (PCG)');
    disp('(3) XOR-Shift-Reduced Plus (xorshiftr+)');
    prng_input = int32(input('Choose between 1 and 3: '));

    prng_selection = -1;
    switch(prng_input)
        case 1
            prng_selection = 1;
        case 2
            prng_selection = 2;
        case 3
            prng_selection = 3;
        otherwise
            error('Wrong input, expected 1 to 3');
            return;
    end
end

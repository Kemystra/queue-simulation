% Input parameter: nothing
% Output: an array of format [number of cars, seed value, PRNG selection]

function [car_num, seed, prng_selection, is_peak_time] = get_user_input()
    print_main_banner();
    fprintf('Welcome to Queue Simulation\n');

    while (true)
        car_num = cast(input('Enter no. of cars: '), 'int32');
        if (car_num <= 0)
            disp('Wrong input format. Please try again');
            continue;
        end
        break;
    end

    seed = -1;
    while(true)
        print_seed_banner();
        seed = get_seed_input();
        if (seed == -1)
            disp('Wrong input, expected Y or N');
            continue;
        end
        break;
    end

    is_peak_time = -1;
    while(true)
        print_peak_banner();
        is_peak_time = get_is_peak_input();
        if (is_peak_time == -1)
            disp('Wrong input, expected Y or N');
            continue;
        end
        break;
    end


    prng_selection = -1;
    while(true)
        prng_selection = get_prng_input();
        if (prng_selection == -1)
            disp('Wrong input, expected Y or N');
            continue;
        end
        break;
    end
end


function seed = get_seed_input()
    % Get seed or randomize
    seed_decision = getline('Do you want to set your own seed value? [Y/n] : ');
    seed_decision = lower(seed_decision);
    seed = 0;

    if (strcmp('y', seed_decision(1)))
        print_enter_seed_banner();
        seed = uint64(input('Enter your seed value: '));
    elseif (strcmp('n', seed_decision(1)))
        % rand() returns the number in [0,1)
        seed = rand() * 2^32;
    else
        seed = -1;
    end
end


function is_peak_time = get_is_peak_input()
    peak_time_decision = getline('Is this simulation on peak hours? [Y/n] : ');
    peak_time_decision = lower(peak_time_decision);
    is_peak_time = 0;

    if (strcmp('y', peak_time_decision(1)))
        is_peak_time = true;
    elseif (strcmp('n', peak_time_decision(1)))
        is_peak_time = false;
    else
        is_peak_time = -1;
    end
end


function prng_selection = get_prng_input()
    % Get PRNG selection
    print_rng_banner();
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
            prng_selection = -1;
    end
end

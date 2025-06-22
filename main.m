% result format: {car_num, seed, prng_selection};
[number_of_cars, seed, selected_prng, is_peak_time] = input_system();

randomised = zeros(number_of_cars,3);      % initialise matrix to hold car values

% ARRAY STRUCTURE:
% For each car we have 3 randomised values, so we will have 3 coloumns of N values in the randomised array
% For N  number of cars, the first coloumn of the matrix will be for petrol type,
% the second coloumn of the matrix will be for interarrival
% and the third coloumn will be for service time

% eg: for 2 cars,
% [1, 3, 5;
%  2, 4, 6]
% Petrol type = [1,2]
% Interarrival = [3,4]
% Service time =[5,6]
% generate randomised values based on the selected PRNG
switch selected_prng
    case 1
        randomised = permcg(seed, number_of_cars);
    case 2
        randomised = lcg(seed, number_of_cars);
    case 3
        randomised = xorshiftr(seed, number_of_cars);
    otherwise
        error('Invalid PRNG selection');
end

vehicles = [];

% The randomized number results is split with array splicing

petrol_type_rng = randomised(:, 1);
petrol_type_values = zeros(1, number_of_cars);

interarrival_rng = randomised(:, 2);
interarrival_values = zeros(1, number_of_cars);

refueling_amount_rng = randomised(:, 3);
refueling_amount_values = zeros(1, number_of_cars);

if (is_peak_time)
  % If is peak time, then increase the randomised num for fuel quantity, so that higher fuel quantity is generated
  refueling_amount_rng = refueling_amount_rng + 20; % Increase by 20;
end

for i = 1:number_of_cars
    % Get the random number and get the value according to the probability table
    % Since we have a Nx3 matrix
    % We can access each row with this syntax
    petrol_type = get_petrol_value(petrol_type_rng(i));
    interarrival = get_interarrival_value(interarrival_rng(i));
    refueling_amount = get_refueling_amount_value(refueling_amount_rng(i));

    % Special case for interarrival time
    % The first car will always have this value as zero
    if (i == 1)
        interarrival = 0;
    end

    % Save the results into separate arrays for display
    petrol_type_values(i) = petrol_type;
    interarrival_values(i) = interarrival;
    refueling_amount_values(i) = refueling_amount;

    v = create_vehicle(interarrival, interarrival_rng(i), petrol_type, refueling_amount, refueling_amount_rng(i));
    vehicles = [vehicles, v];
end

vehicles = simulate(vehicles, number_of_cars);

table_printing(vehicles);

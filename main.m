% result format: {car_num, seed, prng_selection};
[number_of_cars, seed, selected_prng] = input_system()

randomised = zeros(number_of_cars,3);      % initialise matrix to hold car values

disp(randomised);
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
        randomised = xorshiftrp(seed, number_of_cars);
    otherwise
        error('Invalid PRNG selection');
end
disp(randomised)

vehicles = []

% The randomized number results is split with array splicing

petrol_type_rng = randomised(:, 1);
petrol_type_values = zeros(1, number_of_cars);

interarrival_rng = randomised(:, 2);
interarrival_values = zeros(1, number_of_cars);

refueling_time_rng = randomised(:, 3);
refueling_time_values = zeros(1, number_of_cars);

for i = 1:number_of_cars
    % Get the random number and get the value according to the probability table
    % Since we have a Nx3 matrix
    % We can access each row with this syntax
    petrol_type = get_petrol_value(randomised(i, 1));
    interarrival = get_interarrival_value(randomised(i, 2));
    refueling_time = get_refueling_time_value(randomised(i, 3));

    % Special case for interarrival time
    % The first car will always have this value as zero
    if (i == 1)
        interarrival = 0;
    end

    % Save the results into separate arrays for display
    petrol_type_values(i) = petrol_type;
    interarrival_values(i) = interarrival;
    refueling_time_values(i) = refueling_time;

    v = create_vehicle(interarrival, interarrival_rng(i), petrol_type, refueling_time, refueling_time_rng(i));
    vehicles = [vehicles, v]
end

vehicles = simulate(vehicles, number_of_cars);

disp(vehicles);

% Display results (for testing only)
for i = 1:length(vehicles)
    fprintf('Vehicle %d: Lane=%d, Pump=%d, InterArrival Time=%d, Arrival=%.1f, Wait=%.1f, Service Duration=%d\n', ...
            i, vehicles(i).lane, vehicles(i).pump, vehicles(i).iat, ...
            vehicles(i).arrivalTime, vehicles(i).waitingDuration, ...
            vehicles(i).serviceDuration);
end

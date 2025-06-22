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
% initialise array to hold petrol type values
petrol_type_rng = zeros(1, number_of_cars);
petrol_type_values = cell(1, number_of_cars);
% fill petrol type rng array
for i = 1:number_of_cars
    petrol_type_rng(i) = randomised(i);
    petrol_type_values{i} = get_petrol_value(randomised(i));
    fprintf('Car %d, petrol type: %d, %s \n', i, petrol_type_rng(i), petrol_type_values{i});
end

% initialise array to hold interarrival times
interarrival_rng = zeros(1, number_of_cars);
interarrival_values = zeros(1, number_of_cars);
% fill interarrival rng array
% The first car arrive at exactly 0, so its interarrival time must also be 0
% So we start randomizing the value from the 2nd car onwards
for i = 2:number_of_cars
    interarrival_rng(i) = randomised(number_of_cars + i);
    interarrival_values(i) = get_interarrival_value(randomised(number_of_cars + i));
    fprintf('Car %d, interarrival time: %d, %d\n', i, interarrival_rng(i),interarrival_values(i));
end

% initialise array to hold refueling time
refueling_time_rng = zeros(1, number_of_cars);
refueling_time_values = zeros(1, number_of_cars);
% fill refueling time rng array
for i = 1:number_of_cars
    refueling_time_rng(i) = randomised(2*number_of_cars + i);
    refueling_time_values(i) = get_refueling_time_value(randomised(2*number_of_cars + i));
    fprintf('Car %d, refueling time: %d, %d\n', i, refueling_time_rng(i), refueling_time_values(i));
end

vehicles = []
for i = 1:number_of_cars
    v = create_vehicles(interarrival_values, petrol_type_values, refueling_time_values);
    vehicles = [vehicles, v]
end

vehicles = simulate(vehicles, number_of_cars);

% Display results (for testing only)
for i = 1:length(vehicles)
    fprintf('Vehicle %d: Lane=%d, Pump=%d, Arrival=%.1f, Wait=%.1f, Initial Line Number=%d\n', ...
            i, vehicles(i).lane, vehicles(i).pump, ...
            vehicles(i).arrivalTime, vehicles(i).waitingDuration, ...
            vehicles(i).initialLineNumber);
end

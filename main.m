user_input = input_system()

% Process user input, generate random numbers accordingly, and generate a list of cars
% Note that at this point the Car object must already have its appropriate value

% This is the format of a Vehicle object. Replace variables with the appropriate value when constructing a Vehicle
% vehicle = struct('iat', iat,'fuelType', fuelType,'refuelQuantity', refuelQuantity,'arrivalTime', 0,'waitingDuration', 0,'initialLineNumber', 0);

simulate(vehicles);

% Print cars data
table_printing(vehicles);

%   BELOW THIS IS THE RNG SHITEEEEE

number_of_cars = 10;                     % Number of cars to generate, replace this with user input
selected_prng = 1;                      % Selected PRNG, replace this with user input
seed = rand();                          % randomise the seed

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
for i = 1:number_of_cars
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

user_input = input_system()

% Process user input, generate random numbers accordingly, and generate a list of cars
% Note that at this point the Car object must already have its appropriate value

% cars = generate_car();

% This is the format of a Car object. Replace zero with the appropriate value when constructing a Car
car = struct(
    'iat', 0,
    'fuelType', 0,
    'refuelDuration', 0,
    'arrivalTime', 0,
    'waitingDuration', 0,
    'initialLineNumber', 0
);

simulate(cars);

% Print cars data
table_printing(cars);

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
% fill petrol type rng array 
for i = 1:number_of_cars
    petrol_type_rng(i) = randomised(i);
    fprintf('Car %d, petrol type: %d\n', i, petrol_type_rng(i));
end

% initialise array to hold interarrival times
interarrival_rng = zeros(1, number_of_cars);
% fill interarrival rng array
for i = 1:number_of_cars
    interarrival_rng(i) = randomised(number_of_cars + i);
    fprintf('Car %d, interarrival time: %d\n', i, interarrival_rng(i));
end

% initialise array to hold refueling time
refueling_time_rng = zeros(1, number_of_cars);
% fill refueling time rng array
for i = 1:number_of_cars
    refueling_time_rng(i) = randomised(2*number_of_cars + i);
    fprintf('Car %d, refueling time: %d\n', i, refueling_time_rng(i));
end
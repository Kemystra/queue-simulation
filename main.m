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

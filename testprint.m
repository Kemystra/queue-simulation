result = [
    test_vehicle(0, 0, 'Petrol', 20, 20.0, 0, 0, 0),
    test_vehicle(22, 0, 'Petrol', 40, 40.0, 22.0, 0, 0),
    test_vehicle(8, 0, 'Diesel', 150, 150.0, 30.0, 0, 0),
    test_vehicle(9, 0, 'Petrol', 150, 150.0, 39.0, 0, 0),
    test_vehicle(3, 0, 'Petrol', 1500, 1500.0, 42.0, 0, 0),
    test_vehicle(6, 0, 'Petrol', 1500, 1500.0, 48.0, 16, 0),
    test_vehicle(10, 0, 'Petrol', 2000, 2000.0, 58.0, 60.0, 0),
    test_vehicle(10, 0, 'Petrol', 20, 20.0, 68.0, 114.0, 0),
    test_vehicle(10, 0, 'Petrol', 20, 20.0, 78.0, 240.0, 0),
    test_vehicle(10, 0, 'Petrol', 20, 20.0, 88.0, 170.0, 0),
    test_vehicle(10, 0, 'Petrol', 20, 20.0, 98.0, 1653.0, 0),
    test_vehicle(10, 0, 'Petrol', 20, 20.0, 108.0, 170.0, 0)
];

table_printing(result);

function v = test_vehicle(iat, randomIAT, fuelType, randomRefuel, refuelQuantity, arrivalTime, waitingDuration, initialLineNumber)
    % How much fuel can enter the tank per minute
    flowRate = 1;
    serviceDuration = refuelQuantity / flowRate;

    v = struct('iat', iat,'fuelType', fuelType,'refuelQuantity', refuelQuantity, 'serviceDuration', serviceDuration, 'arrivalTime', arrivalTime,'waitingDuration', waitingDuration,'initialLineNumber', initialLineNumber);
end

% To use the `test_vehicle` object, you can directly access its variables (just like member variables in C++)
% e.g:
%
% v = result[1];
% v.fuelType (this will get the fuelType of the vehicle)

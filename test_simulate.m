% Main simulation function
vehicles = [
    create_vehicle(0, 'Petrol', 20);
    create_vehicle(22, 'Petrol', 40);
    create_vehicle(8, 'Diesel', 150);
    create_vehicle(9, 'Petrol', 150);
    create_vehicle(3, 'Petrol', 1500);
    create_vehicle(6, 'Petrol', 1500);
    create_vehicle(10, 'Petrol', 2000);
    create_vehicle(10, 'Petrol', 20);
    create_vehicle(10, 'Petrol', 20);
    create_vehicle(10, 'Petrol', 20);
    create_vehicle(10, 'Petrol', 20);
    create_vehicle(10, 'Petrol', 20);
];

vehicles = simulate(vehicles, length(vehicles));
% Display results
for i = 1:length(vehicles)
    fprintf('Vehicle %d: Lane=%d, Pump=%d, Arrival=%.1f, Wait=%.1f, Initial Line Number=%d\n', ...
            i, vehicles(i).lane, vehicles(i).pump, ...
            vehicles(i).arrivalTime, vehicles(i).waitingDuration, ...
            vehicles(i).initialLineNumber);
end

function table_printing(vehicles)

    petrolPrice = [2.05, 3.07, 2.74];
    countFS95 = 0;
    countVP97 = 0;
    countDiesel = 0;
    totalRefuelQuantity = 0; 
    maxRefuelQuantity = 0; 

    printf('\n\n  ========  RESULTS OF SIMULATION  \n\n'); 
    printf('  +==============================================================================================================================================+\n');
    printf('  | Vehicle Number |        Type of Petrol        | Quantity (litre) | Total Price (RM) | Random Num for Inter-Arrival Time | Inter-Arrival Time |\n');
    printf('  +==============================================================================================================================================+\n');

    for i = 1:length(vehicles)
        fuel = vehicles(i).fuelType;
        % checks the fuel type user picked, to set respective price 
        % keeps count of fuel picked too 
        switch fuel  
            case 'FuelSave 95'
                price = petrolPrice(1);
                countFS95 = countFS95 + 1; 
            case 'V-Power 97'
                price = petrolPrice(2);
                countVP97 = countVP97 + 1;
            case 'FuelSave Diesel Euro 5'
                price = petrolPrice(3);
                countDiesel = countDiesel + 1; 
            otherwise
                price = 0;
        end

        % checks for the highest value of refuel quantity 
        if vehicles(i).refuelQuantity > maxRefuelQuantity
            maxRefuelQuantity = vehicles(i).refuelQuantity;
        end

        totalRefuelQuantity = totalRefuelQuantity + vehicles(i).refuelQuantity;

        totalPrice = price * vehicles(i).refuelQuantity;

        printf('  | %14d | %27s  | %16.2f | %15.2f  |   %30d  | %18d |\n', ...
            i, fuel, vehicles(i).refuelQuantity, totalPrice, ...
            vehicles(i).iatRandomValue, vehicles(i).iat);
    end

    printf('  +==============================================================================================================================================+\n\n');

    %% Arrival Info Table
    printf('  +===============================================================+\n');
    printf('  | Arrival Time | Line Number | Random Number for Refueling Time |\n');
    printf('  +===============================================================+\n');

    for i = 1:length(vehicles)
        printf('  | %12d | %11d |  %30d  |\n', ...
            vehicles(i).arrivalTime, vehicles(i).initialLineNumber, vehicles(i).refuelQuantityRandomValue);
    end

    printf('  +===============================================================+\n\n\n');


    % tables for the lanes and pumps 

    lanes = [1, 2];

    %initialising arrays to keep track of them 
    totalServiceTime = zeros(1, length(lanes));
    totalVehicleLane = zeros(1, length(lanes)); 

    for l = 1:length(lanes)
        lane = lanes(l);
        printf('  ========  VEHICLE PUMP LANE %d  ========\n\n', lane); 
        printf('  +====================================================================================+\n');
        % if lane 1, pumps are 1 and 2, if lane 2, pumps are 3 and 4
        if lane == 1
            printf('  | Vehicle Number |              Pump 1             |              Pump 2             |\n');
        else
            printf('  | Vehicle Number |              Pump 3             |              Pump 4             |\n');
        end
        printf('  +------------------------------------------------------------------------------------+\n');
        printf('  |                | Refuel Time |  Begin  |   End   | Refuel Time |   Begin   |  End  |\n');
        printf('  +====================================================================================+\n');

        for i = 1:length(vehicles)
            v = vehicles(i);
            if v.lane == lane
                totalVehicleLane(l) = totalVehicleLane(l) + 1; 
                totalServiceTime(l) = totalServiceTime(l) + v.serviceDuration;

                printf('  | %14d |', i);
                % simulate.py, only recognises the pumps as 1 or 2 in each lane therefore only check for 1 and 2, not 3 or 4
                for p = 1:2  
                    if v.pump == p
                        printf('%10.2f   |  %6.2f |  %6.2f |', v.serviceDuration, v.refuelBegins, v.refuelEnds);
                    else
                        printf('%10s   |  %6s |  %6s |', '-', '-', '-');
                    end
                end
                printf('\n');
            end
        end

        printf('  +====================================================================================+\n\n');
    end

    %% Waiting and Time Spent Table

    totalWaitTime = 0;
    totalTimeSpent = 0; 
    waitingVehicles = 0;
    maxWaitTime = 0;

    printf('  +============================================+\n');
    printf('  | Vehicle Number | Waiting Time | Time Spent |\n');
    printf('  +============================================+\n');

    for i = 1:length(vehicles)
        waitTime = vehicles(i).waitingDuration;
        timeSpent = vehicles(i).refuelEnds - vehicles(i).arrivalTime;

        totalWaitTime = totalWaitTime + waitTime;
        totalTimeSpent = totalTimeSpent + timeSpent;

        % increment wait vehicles of their wait time is more than 0 (aka currently waiting)
        if waitTime > 0
            waitingVehicles = waitingVehicles + 1;
        end

        % checks for the highest value of wait time 
        if waitTime > maxWaitTime
            maxWaitTime = waitTime;
        end

        printf('  | %14d |     %8.2f |   %8.2f |\n', i, waitTime, timeSpent);
    end
    
    printf('  +============================================+\n\n\n'); 


    % finding and printing the averages

    avgWaitTime = totalWaitTime / length(vehicles);
    avgTimeSpent = totalTimeSpent / length(vehicles); 
    probabilityWaitingVehicles = waitingVehicles / length(vehicles);
    avgRefuelQuantity = totalRefuelQuantity / length(vehicles);

    % get the highest number and its index pos 
    [maxFuelCount, maxFuelIndex] = max([countFS95, countVP97, countDiesel]); 

    printf('\n\n');
    % ===== Summary Table =====
    printf('  ========  EVALUATION OF SIMULATION  ========\n\n');
    printf('  +=====================================================================+\n');
    printf('  | %-40s | %-24s |\n', 'Metric', 'Value');
    printf('  +=====================================================================+\n');
    printf('  | %-40s | %24.2f |\n', 'Average Time Spent in System', avgTimeSpent);
    printf('  | %-40s | %24.2f |\n', 'Average Waiting Time', avgWaitTime);
    printf('  | %-40s | %24.2f |\n', 'Average Refuel Quantity (Litres)', avgRefuelQuantity);
    printf('  | %-40s | %24d |\n',   'Highest Waiting Time', maxWaitTime);
    printf('  | %-40s | %24d |\n',   'Highest Refueling Quantity', maxRefuelQuantity);
    printf('  | %-40s | %24.2f |\n', 'Probability of Vehicles That Has to Wait', probabilityWaitingVehicles);
    printf('  | %-40s | %24s |\n',   'Most Popular Fuel', vehicles(maxFuelIndex).fuelType);
    for l = 1:length(lanes)
        lane = lanes(l);
        if totalVehicleLane(l) > 0 % checks for vehicles
            avgServiceTime = totalServiceTime(l) / totalVehicleLane(l);
            printf('  | %-40s | %24.2f |\n', ['Average Service Time Lane ', num2str(lane)], avgServiceTime);
        else
            printf('  | %-40s | %24s |\n', ['Average Service Time Lane ', num2str(lane)], 'No vehicles'); % changes to number of the lanes to strings 
        end
    end
    printf('  +=====================================================================+\n');
end



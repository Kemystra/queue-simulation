function table_printing(vehicles)

    petrolPrice = [2.05, 3.07, 2.74];
    countFS95 = 0;
    countVP97 = 0;
    countDiesel = 0;
    totalRefuelQuantity = 0; 
    maxRefuelQuantity = 0; 

    printf('\n\n  ========  Results of Simulation  ========\n\n'); 
    printf('  +==============================================================================================================================================+\n');
    printf('  | Vehicle Number |        Type of Petrol        | Quantity (litre) | Total Price (RM) | Random Num for Inter-Arrival Time | Inter-Arrival Time |\n');
    printf('  +==============================================================================================================================================+\n');

    for i = 1:length(vehicles)
        fuel = vehicles(i).fuelType;
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

    totalServiceTime = zeros(1, length(lanes));
    totalVehicleLane = zeros(1, length(lanes)); 

    for l = 1:length(lanes)
        lane = lanes(l);
        printf('  ======== Vehicle Pump Table Lane %d ========\n\n', lane); 
        printf('  +====================================================================================+\n');
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
    maxWaitTime = 0 

    printf('  +============================================+\n');
    printf('  | Vehicle Number | Waiting Time | Time Spent |\n');
    printf('  +============================================+\n');

    for i = 1:length(vehicles)
        waitTime = vehicles(i).waitingDuration;
        timeSpent = vehicles(i).refuelEnds - vehicles(i).arrivalTime;

        totalWaitTime = totalWaitTime + waitTime;
        totalTimeSpent = totalTimeSpent + timeSpent;

        if waitTime > 0
            waitingVehicles = waitingVehicles + 1;
        end

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

    [maxFuelCount, maxFuelIndex] = max([countFS95, countVP97, countDiesel]); % get the highest number and its index pos 
    % mostPopularFuel = vehicles(maxFuelIndex).fuelType;

    printf('  Average Time Spent in System: %.2f \n', avgTimeSpent);
    printf('  Average Waiting Time: %.2f \n', avgWaitTime);
    printf('  Average Refuel Quantity: %.2f \n', avgRefuelQuantity);
    printf('  Highest Waiting Time: %d \n', maxWaitTime);
    printf('  Highest Refueling Time: %d \n', maxRefuelQuantity);
    printf('  Probability of Vehicles That Has to Wait: %.2f \n', probabilityWaitingVehicles);
    printf('  Most Popular Fuel: %s \n', vehicles(maxFuelIndex).fuelType);

    for l = 1:length(lanes) % for each lane, rather than both of them at the same time 
        lane = lanes(l);
        if totalVehicleLane(l) > 0
            avgServiceTime = totalServiceTime(l) / totalVehicleLane(l);
            printf('  Average service time at Lane %d: %.2f \n', lane, avgServiceTime);
        else
            printf('  No vehicles at Lane %d.\n', lane);
        end
    end

    printf('\n\n');
end



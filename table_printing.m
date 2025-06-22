function table_printing(vehicles)

    % petrolType = {'FuelSave 95', 'V-Power 97', 'FuelSave Diesel Euro 5'};  
    petrolPrice = [2.05, 3.07, 2.74];

    % n = length(vehicles);
    % petrol = {vehicles(i).fuelType};
    % quantity = [vehicles(i).refuelQuantity];
    % iat = [vehicles(i).iat];
    % arrival = [vehicles(i).arrivalTime];
    % lineNum = [vehicles(i).initialLineNumber];
    % randIAT = [vehicles(i).randomIAT];
    % randRefuel = [vehicles(i).randomRefuel]; 

    printf('  ========  Results of Simulation  ========\n\n'); 
    printf('  +==============================================================================================================================================+ \n');
    printf('  | Vehicle Number |        Type of Petrol        | Quantity (litre) | Total Price (RM) | Random Num for Inter-Arrival Time | Inter-Arrival Time | \n');
    printf('  +==============================================================================================================================================+ \n');

    for i = 1:length(vehicles)
        fuel = vehicles(i).fuelType;
        switch fuel
            case 'FuelSave 95'
                price = petrolPrice(1);
            case 'V-Power 97'
                price = petrolPrice(2);
            case 'FuelSave Diesel Euro 5'
                price = petrolPrice(3);
            otherwise
                price = 0; % false input 
        end

        totalPrice = price * vehicles(i).refuelQuantity;

        printf('  | %14d | %27s  | %16.2f | %15.2f   | %30d | %18d |\n', ...
                i, fuel, vehicles(i).refuelQuantity, totalPrice, vehicles.iatRandomValue(i), vehicles(i).iat);;
    end

    printf('  +=============================================================================================================================================+ \n');
    printf('\n'); 

    printf('  +===============================================================+ \n');
    printf('  | Arrival Time | Line Number | Random Number for Refueling Time | \n');
    printf('  +===============================================================+ \n');

    for i = 1:length(vehicles)
        printf('  | %12.2f | %11d | %30d |\n', vehicles(i).arrivalTime, vehicles(i).initialLineNumber, vehicles.refuelQuantityRandomValue(i));
    end

    printf('  +===============================================================+ \n');
    printf('\n\n\n'); 

    lanes = [1,2]; 

    for lane = lanes
        printf('  ======== Vehicle Pump Table Lane %d ========\n\n', lane); 
        printf('  +========================================================================+ \n');
        printf('  | Vehicle Number |           Pump 1          |           Pump 2          | \n');
        printf('  +------------------------------------------------------------------------+ \n');
        printf('  |                | Refuel Time | Begin | End | Refuel Time | Begin | End |\n');
        printf('  +========================================================================+ \n');

        for i = 1:length(vehicles)
            v = vehicles(i); 

            if v.lane == lane
                printf('  | %14d |', i);
                
                for p = 1:2
                    if v.pump == p
                        printf(' %5.2f | %5.2f | %5.2f |', ...
                            v.serviceDuration, v.refuelBegins, v.refuelEnds);
                    else
                        printf('   -   |   -   |   -   |');
                    end
                end

            printf('\n');

            end
        end
    end

    printf('  +===========================+ \n');
    printf('  | Waiting Time | Time Spent | \n');
    printf('  +===========================+ \n');

    for i = 1:length(vehicles)
        timeSpent = vehicles.arrivalTime(i) - vehicles.refuelEnds(i); 

        printf('  |     %8.2f |    %8.2f |\n', vehicles.waitingDuration, timeSpent)
    end

    printf('  +===========================+ \n');
    printf('\n\n\n'); 

end 

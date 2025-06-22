function table_printing(result)

    petrolType = {'FuelSave 95', 'V-Power 97', 'FuelSave Diesel Euro 5'};  
    petrolPrice = [2.05, 3.07, 2.74];

    n = numel(result);
    car_num = 1:n;
    petrol = {result.fuelType};
    quantity = [result.refuelQuantity];
    iat = [result.iat];
    arrival = [result.arrivalTime];
    lineNum = [result.initialLineNumber];
    randIAT = [result.randomIAT];
    randRefuel = [result.randomRefuel]; 

    printf('  ========  Results of Simulation  ========\n\n'); 
    printf('  +==============================================================================================================================================+ \n');
    printf('  | Vehicle Number |        Type of Petrol        | Quantity (litre) | Total Price (RM) | Random Num for Inter-Arrival Time | Inter-Arrival Time | \n');
    printf('  +==============================================================================================================================================+ \n');

    for i = 1:car_num
        switch(petrolType{i})
            case 'FuelSave 95'
                price = petrolPrice(1);
            case 'V-Power 97'
                price = petrolPrice(2);
            case 'FuelSave Diesel Euro 5'
                price = petrolPrice(3);
            otherwise
                price = 0; 
        end

        totalPrice = price * quantity;

                
        printf('  | %14d | %27s  | %16.2f | %15.2f   | %30d | %18d |\n', ...
                n, petrol, quantity(i), totalPrice, randIAT(i), iat(i));;
    end

    printf('  +=============================================================================================================================================+ \n');
    printf('\n'); 

    printf('  +===============================================================+ \n');
    printf('  | Arrival Time | Line Number | Random Number for Refueling Time | \n');
    printf('  +===============================================================+ \n');

    for i = 1:car_num
        printf('  | %12.2f | %11d | %30d |\n', arrival(i), lineNum(i), randRefuel(i));
    end

    printf('  +===============================================================+ \n');
    printf('\n\n\n'); 


    % printf('  ======== Vehicle Pump Table ========\n\n'); 
    % printf('  +================================================================================================================================+ \n');
    % printf('  | Vehicle Number |           Pump 1          |           Pump 2          |            Pump 3         |           Pump 4          | \n');
    % printf('  +--------------------------------------------------------------------------------------------------------------------------------+ \n');
    % printf('  |                | Refuel Time | Begin | End | Refuel Time | Begin | End | Refuel Time | Begin | End | Refuel Time | Begin | End |\n');
    % printf('  +================================================================================================================================+ \n');

    % for i = 1:numel(car_num)
    %     printf('  | %7d        | %27s  | %9d        | %9d        | %18d              |\n', car_num(i), petrol{i}, quantity(i), totalPrice(i), randIAT(i));
    % end

    % printf('  +================================================================================================================================+ \n');
    % printf('\n\n\n'); 

end 

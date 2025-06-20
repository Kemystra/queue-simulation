function table_printing()

    IAT = [2, 4, 6, 8, 10];  
    IATProbability = [0.2, 0.25, 0.25, 0.2, 0.1]; 
    IATcdf = [0.20, 0.45, 0.70, 0.90, 1.00];
    IATrange = {'1-20', '21-45', '46-70', '71-90', '91-100'}; 

    printf('           ===Probability table: Inter-Arrival Time===\n'); 
    printf('  +--------------------------------------------------------------+ \n');
    printf('  | Inter-Arrival Time | Probability | CDF | Random Number Range | \n');
    printf('  +--------------------------------------------------------------+ \n');

    for i = 1:numel(IAT)
        printf('  |%11d         | % 8.2f    |%.2f | %13s       |\n', IAT(i), IATProbability(i), IATcdf(i), IATrange{i});
    end

    printf('  +--------------------------------------------------------------+ \n');
    printf('\n\n\n'); 

    petrol = {'FuelSave 95', 'V-Power 97', 'V-Power Racing', 'FuelSave Disel Euro 5', ' FuelSave Diesel Euro 5 B7'};  
    petrolProbability = [0.3, 0.2, 0.1, 0.2, 0.2]; 
    petrolCDF = [0.30, 0.5, 0.60, 0.80, 1.00];
    petrolRange = {'1-30', '31-50', '51-60', '61-80', '81-100'}; 
    petrolPrice = [2.05, 3.07, 6.04, 2.74, 2.94];

    printf('                             ===Probability table: Type of Petrol===\n'); 
    printf('  +-------------------------------------------------------------------------------------------+ \n');
    printf('  |        Type of Petrol        | Probability | CDF |  Random Number Range | Price Per Litre |\n');
    printf('  +-------------------------------------------------------------------------------------------+ \n');

    for i = 1:numel(petrol)
        printf('  |%27s   | % 8.2f    |%1.2f | %10s           |%9d        |\n', petrol{i}, petrolProbability(i), petrolCDF(i), petrolRange{i}, petrolPrice(i));
    end

    printf('  +-------------------------------------------------------------------------------------------+ \n');
    printf('\n\n\n');

    refuel = [2, 4, 6, 8];  
    refuelProbability = [0.15, 0.25, 0.45, 0.15]; 
    refuelCDF = [0.15, 0.40, 0.85, 1.00];
    refuelRange = {'1-15', '16-40', '41-85', '86-100'}; 

    printf('          ===Probability table: Refueling Time===\n'); 
    printf('  +------------------------------------------------------+ \n');
    printf('  | Refueling Time | Probability  | CDF | Rand Num Range | \n');
    printf('  +------------------------------------------------------+ \n');

    for i = 1:numel(refuel)
        printf('  |%7d         | % 8.2f     |%1.2f | %10s     |\n', refuel(i), refuelProbability(i), refuelCDF(i), refuelRange{i});
    end

    printf('  +------------------------------------------------------+ \n');
    printf('\n\n\n');

    car_num = [1, 2, 3, 4, 5];  
    quantity = [0, 0, 0, 0, 0]; 
    totalPrice = [0, 0, 0, 0, 0];
    randIAT = [0, 0, 0, 0, 0];
    arrivalTime = [0, 0, 0, 0, 0];
    lineNum = [1, 2, 1, 2, 1];  
    randRefuel = [0, 0, 0, 0, 0];

    printf('                                                 ===Results of Simulation===\n'); 
    printf('  +=========================================================================================================================+ \n');
    printf('  | Vehicle Number |        Type of Petrol        | Quantity (litre) | Total Price (RM) | Random Num for Inter-Arrival Time | \n');
    printf('  +=========================================================================================================================+ \n');

    for i = 1:numel(car_num)
        printf('  | %7d        | %27s  | %9d        | %9d        | %18d                |\n', car_num(i), petrol{i}, quantity(i), totalPrice(i), randIAT(i));
    end

    printf('  +=========================================================================================================================+ \n');
    printf('\n'); 

    printf('  +===============================================================+ \n');
    printf('  | Arrival Time | Line Number | Random Number for Refueling Time | \n');
    printf('  +===============================================================+ \n');

    for i = 1:numel(car_num)
        printf('  | %8d     | %7d     | %15d                  |\n', arrivalTime(i), lineNum(i), randRefuel(i));
    end

    printf('  +===============================================================+ \n');
    printf('\n\n\n'); 


    % printf('                                                 ===Results of Simulation===\n'); 
    % printf('  +=========================================================================================================================+ \n');
    % printf('  | Vehicle Number |        Type of Petrol        | Quantity ( | Total Price (RM) | Random Num for Inter-Arrival Time | \n');
    % printf('  +=========================================================================================================================+ \n');

    % for i = 1:numel(car_num)
    %     printf('  | %7d        | %27s  | %9d        | %9d        | %18d              |\n', car_num(i), petrol{i}, quantity(i), totalPrice(i), randIAT(i));
    % end

    % printf('  +=========================================================================================================================+ \n');
    % printf('\n\n\n'); 

end 

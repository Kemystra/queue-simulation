function probability_table_print()

    IAT = [2, 4, 6, 8, 10];  
    IATProbability = [0.2, 0.25, 0.25, 0.2, 0.1]; 
    IATcdf = [0.20, 0.45, 0.70, 0.90, 1.00];
    IATrange = {'1-20', '21-45', '46-70', '71-90', '91-100'}; 

    printf('  ========  Probability table: Inter-Arrival Time  ========\n\n'); 
    printf('  +--------------------------------------------------------------+ \n');
    printf('  | Inter-Arrival Time | Probability | CDF | Random Number Range | \n');
    printf('  +--------------------------------------------------------------+ \n');

    for i = 1:numel(IAT)
        printf('  |%18d | %10.2f   | %4.2f | %20s |\n', IAT(i), IATProbability(i), IATcdf(i), IATrange{i});
    end

    printf('  +--------------------------------------------------------------+ \n');
    printf('\n\n\n'); 

    petrolType = {'FuelSave 95', 'V-Power 97', 'FuelSave Diesel Euro 5'};  
    petrolProbability = [0.45, 0.35, 0.20]; 
    petrolCDF = [0.45, 0.8, 1.00];
    petrolRange = {'1-45', '46-80', '81-100'}; 
    petrolPrice = [2.05, 3.07, 2.74];

    printf('  ========  Probability table: Type of Petrol  ========\n\n'); 
    printf('  +-------------------------------------------------------------------------------------------+ \n');
    printf('  |        Type of Petrol        | Probability | CDF |  Random Number Range | Price Per Litre |\n');
    printf('  +-------------------------------------------------------------------------------------------+ \n');

    for i = 1:numel(petrol)
        printf('  |%27s | %10.2f   | %4.2f | %20s | %15.2f |\n', petrol{i}, petrolProbability(i), petrolCDF(i), petrolRange{i}, petrolPrice(i));
    end

    printf('  +-------------------------------------------------------------------------------------------+ \n');
    printf('\n\n\n');

    refuel = [2, 4, 6, 8];  
    refuelProbability = [0.15, 0.25, 0.45, 0.15]; 
    refuelCDF = [0.15, 0.40, 0.85, 1.00];
    refuelRange = {'1-15', '16-40', '41-85', '86-100'}; 

    printf('  ========  Probability table: Refueling Time  ========\n\n'); 
    printf('  +-------------------------------------------------------+ \n');
    printf('  | Refueling Time | Probability  | CDF | Rand  Num Range | \n');
    printf('  +-------------------------------------------------------+ \n');

    for i = 1:numel(refuel)
        printf('  |%15d | %10.2f   | %4.2f | %17s |\n', refuel(i), refuelProbability(i), refuelCDF(i), refuelRange{i});
    end

    printf('  +-------------------------------------------------------+ \n');
    printf('\n\n\n');
end 
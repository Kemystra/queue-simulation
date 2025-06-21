function f = get_petrol_value(num)
    if num >=1 && num <= 45
        f = 'FuelSave 95';
    elseif num >= 46 && num <= 80
        f = 'V-Power 97';
    elseif num >= 81 && num <= 100
        f = 'FuelSave Diesel Euro 5';
    end
end
function e = get_refueling_amount_value(num)
    if num >=1 && num <=10
        e = 4;
    elseif num >= 11 && num <= 25
        e = 10;
    elseif num >= 26 && num <= 45
        e = 20;
    elseif num >= 46 && num <= 80
        e = 30;
    elseif num >= 81 && num <= 100
        e = 40;
    end
end
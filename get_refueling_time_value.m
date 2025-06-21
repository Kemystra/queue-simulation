function e = get_refueling_time_value(num)
    if num >=1 && num <=15
        e = 2;
    elseif num >= 16 && num <= 40
        e = 4;
    elseif num >= 41 && num <= 85
        e = 6;
    else
        e = 8;
    end
end
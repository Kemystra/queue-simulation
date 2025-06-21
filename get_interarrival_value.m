function d = get_interarrival_values(num)
    if num >=1 && num <=20
        d = 2;
    elseif num >= 21 && num <= 45
        d = 4;
    elseif num >= 46 && num <= 70
        d = 6;
    elseif num >= 71 && num <= 90
        d = 8;
    else
        d = 10;
    end
end
    
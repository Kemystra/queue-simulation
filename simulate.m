function simulate(&vehicles, totalVehicles)
    currentTime = 0
    % How much fuel can enter the tank per minute
    flowRate = 1;

    arrivalTime = 0;

    for i=1:totalVehicles
        v = vehicles(i)
        printf('Vehicle no. %d\n', i)

        arrivalTime = arrivalTime + v.iat;
        v.arrivalTime = arrivalTime;

        % If the vehicle arrives before the last one finishes
        % Wait first
        if (arrivalTime < currentTime)
            v.waitingDuration = currentTime - arrivalTime;
        % If they arrive after the last one finishes
        % The system will have some idle time, and currentTime have to be advanced till they arrive
        elseif (arrivalTime > currentTime)
            currentTime = currentTime + (arrivalTime - currentTime)
        end

        % Add the service time
        currentTime = currentTime + (v.refuelQuantity / flowRate);
        disp(v);
        disp(currentTime);
    end
end

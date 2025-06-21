function v = vehicle(iat, fuelType, refuelQuantity)
    % How much fuel can enter the tank per minute
    flowRate = 1;
    serviceDuration = refuelQuantity / flowRate;

    v = struct('iat', iat,'fuelType', fuelType,'refuelQuantity', refuelQuantity, 'serviceDuration', serviceDuration, 'arrivalTime', 0,'waitingDuration', 0,'initialLineNumber', 0);
end

function v = vehicle(iat, fuelType, refuelQuantity)
    v = struct('iat', iat,'fuelType', fuelType,'refuelQuantity', refuelQuantity,'arrivalTime', 0,'waitingDuration', 0,'initialLineNumber', 0);
end

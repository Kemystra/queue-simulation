% Next event based simulation

function simulate(&vehicles, totalVehicles)
    currentTime = 0
    events = ['nextArrival', 'nextDeparture'];
    lanes = [laneState(), laneState()]
    nextArrival = 0;

    nextEvent = events(1);
    timeDelta = 0;

    i = 1
    while(i <= totalVehicles)
        % Check next event
        [nextDeparture, laneIdx, pumpIdx] = getEarliestDepartures(lanes);
        if (nextDeparture ~= -1 && nextDeparture < nextArrival)
            nextEvent = 'departure';
        else
            nextEvent = 'arrival';
        end

        % Perform arrival, for now just alternate lanes
        if (strcmp(nextEvent, 'arrival'))
            selectedLane = mod(i, 2) + 1;
            timeDelta = nextArrival;
            handleVehicleArrival(lanes(selectedLane), i, vehicles(i).serviceDuration);
            updatePumpServiceDuration(lanes, timeDelta)

            i = i+1;
            nextArrival = vehicles(i).iat;
        elseif (strcmp(nextEvent, 'departure'))
            timeDelta = nextDeparture;
            handleVehicleDeparture(lanes(laneIdx), pumpIdx, vehicles(i));
            nextArrival = nextArrival - timeDelta;
        end

        % Advance current time by the event duration
        currentTime = currentTime + timeDelta;
        updateWaitingDuration(vehicles, timeDelta);
    end
end


function p = pumpState()
    p = struct('nextDeparture', -1);
end

function l = laneState()
    l = struct('queue', [], 'pumps', [pumpState(), pumpState()])
end

function [minTime, laneIdx, pumpIdx] = getEarliestDepartures(&lanes)
    minTime = inf;  % Start with infinity
    laneIdx = -1;
    pumpIdx = -1;
    
    numLanes = length(lanes);
    
    for i = 1:numLanes
        for j = 1:2  % Each lane has 2 pumps
            departure = lanes(i).pumps(j).nextDeparture;
            
            % Only consider active pumps (not -1)
            if (departure ~= -1 && departure < minTime)
                minTime = departure;
                laneIdx = i;
                pumpIdx = j;
            end
        end
    end
    
    % Handle case where no pumps are active
    if minTime == inf
        minTime = -1;
        laneIdx = -1;
        pumpIdx = -1;
    end
end

function handleVehicleArrival(&lane, vehicleIdx, serviceDuration)
    % Check if pump 1 is idle
    if lane.pumps(1).nextDeparture == -1
        % Assign to pump 1
        lane.pumps(1).nextDeparture = serviceDuration;
        
    % Check if pump 2 is idle
    elseif lane.pumps(2).nextDeparture == -1
        % Assign to pump 2
        lane.pumps(2).nextDeparture = serviceDuration;
        
    else
        % Both pumps busy, add to queue
        lane.queue = [lane.queue, vehicleIdx];
    end
end

function handleVehicleDeparture(lane, pumpIdx, v)
    % Check if there are vehicles waiting in queue
    if ~isempty(lane.queue)
        % Get next vehicle from queue (FIFO)
        nextVehicleIdx = lane.queue(1);
        lane.queue = lane.queue(2:end);  % Remove from queue
        
        % Generate service time for next vehicle
        serviceDuration = v.serviceDuration;
        
        % Assign to the pump that just became free
        lane.pumps(pumpIdx).nextDeparture = serviceDuration;
        
    else
        % No vehicles waiting, set pump to idle
        lane.pumps(pumpIdx).nextDeparture = -1;
    end
end

function updatePumpServiceDuration(&lanes, timeDelta)
    numLanes = length(lanes);
    
    for i = 1:numLanes
        for j = 1:2  % Each lane has 2 pumps
            % Only subtract from active pumps (not idle)
            if lanes(i).pumps(j).nextDeparture ~= -1
                lanes(i).pumps(j).nextDeparture = lanes(i).pumps(j).nextDeparture - timeDelta;
            end
        end
    end
end

function updateWaitingDuration(&vehicles, timeDelta)
    for i = 1:length(vehicles)
        vehicles(i).waitingDuration = vehicles(i).waitingDuration + timeDelta;
    end
end

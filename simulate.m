function vehicles = simulate(vehicles, total_vehicles)
    current_time = 0;
    lanes = [create_lane_state(), create_lane_state()];
    next_arrival = 0;

    i = 1;
    vehicle_served = 0;
    vehicle_finished = false;

    while vehicle_served < total_vehicles
        % Check next event
        [next_departure, lane_idx, pump_idx] = get_earliest_departures(lanes);

        if (next_departure ~= -1 && next_departure < next_arrival) || vehicle_finished
            next_event = 'departure';
        else
            next_event = 'arrival';
        end

        % Handle arrival
        if strcmp(next_event, 'arrival') && ~vehicle_finished
            selected_lane = select_lane(lanes);
            vehicles(i).lane = selected_lane;

            time_delta = next_arrival;
            current_time = current_time + time_delta;

            vehicles(i).arrivalTime = current_time;
            [lanes(selected_lane), vehicles] = handle_vehicle_arrival(lanes(selected_lane), i, vehicles, current_time);
            lanes = update_pump_service_duration(lanes, time_delta);

            i = i + 1;
            if i <= total_vehicles
                next_arrival = vehicles(i).iat;
            else
                vehicle_finished = true;
            end

        % Handle departure
        elseif strcmp(next_event, 'departure')
            time_delta = next_departure;
            current_time = current_time + time_delta;

            [lanes(lane_idx), vehicles] = handle_vehicle_departure(lanes(lane_idx), pump_idx, vehicles, current_time);
            vehicle_served = vehicle_served + 1;
            next_arrival = next_arrival - time_delta;
        end

        % Update waiting duration for queued vehicles
        for x = 1:2
            for j = 1:length(lanes(x).queue)
                y = lanes(x).queue(j);
                vehicles(y).waitingDuration = vehicles(y).waitingDuration + time_delta;
            end
        end
    end
end

function pump = create_pump_state()
    pump = struct('nextDeparture', -1);
end

function lane = create_lane_state()
    lane = struct(...
        'queue', [], ...
        'pumps', [create_pump_state(), create_pump_state()]);
end

function [min_time, lane_idx, pump_idx] = get_earliest_departures(lanes)
    min_time = inf;
    lane_idx = -1;
    pump_idx = -1;

    for i = 1:length(lanes)
        for j = 1:2
            departure = lanes(i).pumps(j).nextDeparture;

            if departure ~= -1 && departure < min_time
                min_time = departure;
                lane_idx = i;
                pump_idx = j;
            end
        end
    end

    if min_time == inf
        min_time = -1;
        lane_idx = -1;
        pump_idx = -1;
    end
end

function [lane, vehicles] = handle_vehicle_arrival(lane, v, vehicles, current_time)
    service_duration = vehicles(v).serviceDuration;

    % Check if pump 1 is idle
    if lane.pumps(1).nextDeparture == -1
        lane.pumps(1).nextDeparture = service_duration;
        vehicles = handle_vehicle_service(v, vehicles, 1, current_time);
    % Check if pump 2 is idle
    elseif lane.pumps(2).nextDeparture == -1
        lane.pumps(2).nextDeparture = service_duration;
        vehicles = handle_vehicle_service(v, vehicles, 2, current_time);
    else
        % Both pumps busy, add to queue
        lane.queue = [lane.queue, v];
        vehicles(v).initialLineNumber = length(lane.queue);
    end
end

function [lane, vehicles] = handle_vehicle_departure(lane, pump_idx, vehicles, current_time)
    % Check if there are vehicles waiting in queue
    if ~isempty(lane.queue)
        % Get next vehicle from queue (FIFO)
        v = lane.queue(1);
        lane.queue = lane.queue(2:end);

        % Generate service time for next vehicle
        service_duration = vehicles(v).serviceDuration;
        vehicles = handle_vehicle_service(v, vehicles, pump_idx, current_time);

        % Assign to the pump that just became free
        lane.pumps(pump_idx).nextDeparture = service_duration;
    else
        % No vehicles waiting, set pump to idle
        lane.pumps(pump_idx).nextDeparture = -1;
    end
end

function vehicles = handle_vehicle_service(v, vehicles, pump_idx, current_time)
    vehicles(v).pump = pump_idx;
    vehicles(v).refuelBegins = current_time;
    vehicles(v).refuelEnds = current_time + vehicles(v).serviceDuration;
end

function lanes = update_pump_service_duration(lanes, time_delta)
    for i = 1:length(lanes)
        for j = 1:2
            % Only subtract from active pumps (not idle)
            if lanes(i).pumps(j).nextDeparture ~= -1
                lanes(i).pumps(j).nextDeparture = lanes(i).pumps(j).nextDeparture - time_delta;
            end
        end
    end
end

function best_lane = select_lane(lanes)
    best_lane = 1;
    best_score = inf;

    for i = 1:length(lanes)
        % Count available (idle) pumps
        available_pumps = 0;
        for j = 1:2
            if lanes(i).pumps(j).nextDeparture == -1
                available_pumps = available_pumps + 1;
            end
        end

        score = length(lanes(i).queue) - available_pumps;

        if score < best_score
            best_score = score;
            best_lane = i;
        end
    end
end

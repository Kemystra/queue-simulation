def simulate(vehicles, total_vehicles):
    current_time = 0
    events = ['nextArrival', 'nextDeparture']
    lanes = [lane_state(), lane_state()]
    next_arrival = 0

    next_event = events[0]
    time_delta = 0

    i = 0
    vehicle_served = 0
    vehicle_finished = False
    while vehicle_served < total_vehicles:
        # Check next event
        next_departure, lane_idx, pump_idx = get_earliest_departures(lanes)
        if (next_departure != -1 and next_departure < next_arrival) or vehicle_finished:
            next_event = 'departure'
        else:
            next_event = 'arrival'
        # Perform arrival, for now just alternate lanes
        if next_event == 'arrival' and not vehicle_finished:
            selected_lane = i % 2
            time_delta = next_arrival
            vehicles[i]['arrivalTime'] = current_time + time_delta
            handle_vehicle_arrival(lanes[selected_lane], i, vehicles[i]['serviceDuration'])
            update_pump_service_duration(lanes, time_delta)

            i += 1
            if i < total_vehicles:
                next_arrival = vehicles[i]['iat']
            else:
                vehicle_finished = True
        elif next_event == 'departure':
            time_delta = next_departure
            handle_vehicle_departure(lanes[lane_idx], pump_idx, vehicles)
            vehicle_served += 1
            next_arrival = next_arrival - time_delta

        # Advance current time by the event duration
        current_time = current_time + time_delta
        for x in range(2):
            for y in lanes[x]['queue']:
                vehicles[y]['waitingDuration'] += time_delta


def pump_state():
    return {'nextDeparture': -1}


def lane_state():
    return {
        'queue': [],
        'pumps': [pump_state(), pump_state()]
    }


def get_earliest_departures(lanes):
    min_time = float('inf')
    lane_idx = -1
    pump_idx = -1

    num_lanes = len(lanes)

    for i in range(num_lanes):
        for j in range(2):  # Each lane has 2 pumps
            departure = lanes[i]['pumps'][j]['nextDeparture']

            # Only consider active pumps (not -1)
            if departure != -1 and departure < min_time:
                min_time = departure
                lane_idx = i
                pump_idx = j

    # Handle case where no pumps are active
    if min_time == float('inf'):
        min_time = -1
        lane_idx = -1
        pump_idx = -1

    return min_time, lane_idx, pump_idx


def handle_vehicle_arrival(lane, vehicle_idx, service_duration):
    # Check if pump 1 is idle
    if lane['pumps'][0]['nextDeparture'] == -1:
        # Assign to pump 1
        lane['pumps'][0]['nextDeparture'] = service_duration

    # Check if pump 2 is idle
    elif lane['pumps'][1]['nextDeparture'] == -1:
        # Assign to pump 2
        lane['pumps'][1]['nextDeparture'] = service_duration

    else:
        # Both pumps busy, add to queue
        lane['queue'].append(vehicle_idx)


def handle_vehicle_departure(lane, pump_idx, vehicles):
    # Check if there are vehicles waiting in queue
    if lane['queue']:
        # Get next vehicle from queue (FIFO)
        v = lane['queue'].pop(0)

        # Generate service time for next vehicle
        service_duration = vehicles[v]['serviceDuration']

        # Assign to the pump that just became free
        lane['pumps'][pump_idx]['nextDeparture'] = service_duration

    else:
        # No vehicles waiting, set pump to idle
        lane['pumps'][pump_idx]['nextDeparture'] = -1


def update_pump_service_duration(lanes, time_delta):
    num_lanes = len(lanes)

    for i in range(num_lanes):
        for j in range(2):  # Each lane has 2 pumps
            # Only subtract from active pumps (not idle)
            if lanes[i]['pumps'][j]['nextDeparture'] != -1:
                lanes[i]['pumps'][j]['nextDeparture'] -= time_delta


def vehicle(iat, fuelType, refuelQuantity):
    flowRate = 1
    serviceDuration = refuelQuantity / flowRate

    return {
        'iat': iat,
        'fuelType': fuelType,
        'refuelQuantity': refuelQuantity,
        'serviceDuration': serviceDuration,
        'arrivalTime': 0,
        'waitingDuration': 0,
        'initialLineNumber': 0
    }


if __name__ == "__main__":
    vehicles = [
        vehicle(0, 'Petrol', 20),
        vehicle(22, 'Petrol', 40),
        vehicle(8, 'Diesel', 150),
        vehicle(9, 'Petrol', 150),
        vehicle(3, 'Petrol', 1500),
        vehicle(6, 'Petrol', 1500),
        vehicle(10, 'Petrol', 2000),
        vehicle(10, 'Petrol', 20),
        vehicle(10, 'Petrol', 20),
        vehicle(10, 'Petrol', 20),
        vehicle(10, 'Petrol', 20),
        vehicle(10, 'Petrol', 20),
    ]
    # import pdb; pdb.set_trace()
    simulate(vehicles, len(vehicles))
    for v in vehicles:
        print(v)

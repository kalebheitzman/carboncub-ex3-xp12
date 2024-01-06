-------------------------------
-- GET BOUNDING BOX
-- lat/lon of current position
-- distance in miles
--
-- formula found at https://stackoverflow.com/questions/2628039/php-library-calculate-a-bounding-box-for-a-given-lat-lng-location
--------------------------------
get_bounding_box = function(lat, lon, distance)
    
    -- radius of earth in miles
    local sim_radius = globalProperty("sim/physics/earth_radius_m")
    local radius_meters = get(sim_radius)
    local radius = radius_meters*0.000621371

    -- bearings in radians
    local due_north = math.rad(0)
    local due_south = math.rad(180)
    local due_east = math.rad(90)
    local due_west = math.rad(270)

    -- lat/lon in radians
    local lat_r = math.rad(lat)
    local lon_r = math.rad(lon)

    -- find corners in radians
    local northmost_r = math.asin(math.sin(lat_r) * math.cos(distance/radius) + math.cos(lat_r) * math.sin (distance/radius) * math.cos(due_north))
    local southmost_r = math.asin(math.sin(lat_r) * math.cos(distance/radius) + math.cos(lat_r) * math.sin (distance/radius) * math.cos(due_south))
    
    local eastmost_r  = lon_r + math.atan2(math.sin(due_east)*math.sin(distance/radius)*math.cos(lat_r),math.cos(distance/radius)-math.sin(lat_r)*math.sin(lat_r))
    local westmost_r  = lon_r + math.atan2(math.sin(due_west)*math.sin(distance/radius)*math.cos(lat_r),math.cos(distance/radius)-math.sin(lat_r)*math.sin(lat_r))

    -- convert radians to degrees
    local northmost = math.deg(northmost_r)
    local southmost = math.deg(southmost_r)
    local eastmost = math.deg(eastmost_r)
    local westmost = math.deg(westmost_r)

    local lat1 = 0
    local lat2 = 0
    local lon1 = 0
    local lon2 = 0

    -- sort lat and lon
    if northmost > southmost then
        lat1 = southmost
        lat2 = northmost
    else
        lat1 = northmost
        lat2 = southmost
    end

    if eastmost > westmost then
        lon1 = westmost
        lon2 = eastmost
    else
        lon1 = eastmost
        lon2 = westmost
    end

    return {
        lat1 = round2(lat1, 6),
        lat2 = round2(lat2, 6),
        lon1 = round2(lon1, 6),
        lon2 = round2(lon2, 6)
    }

end

-- calculate distance between current coordinate and reporting coord
calculate_ll2_distance = function(lat, lon)
    coords = get(cc_gps_recording_fix)
    lat1 = math.rad(coords[1])
    lon1 = math.rad(coords[2])
    lat2 = math.rad(lat)
    lon2 = math.rad(lon)

    -- radius of earth in miles
    local sim_radius = globalProperty("sim/physics/earth_radius_m")
    local radius_meters = get(sim_radius)
    local radius = radius_meters*0.000621371

    local distance = math.acos(math.sin(lat1)*math.sin(lat2)+math.cos(lat1)*math.cos(lat2)*math.cos(lon2-lon1))*radius
    return distance
end

-- calculate distance between current coordinate and reporting coord
calculate_ll_2points_distance = function(c1, c2)
    lat1 = math.rad(c1.lat)
    lon1 = math.rad(c1.lon)
    lat2 = math.rad(c2.lat)
    lon2 = math.rad(c2.lon)

    -- radius of earth in miles
    local sim_radius = globalProperty("sim/physics/earth_radius_m")
    local radius_meters = get(sim_radius)
    local radius = radius_meters*0.000621371

    local distance = math.acos(math.sin(lat1)*math.sin(lat2)+math.cos(lat1)*math.cos(lat2)*math.cos(lon2-lon1))*radius
    return distance
end

-- rotate point
-- c        center
-- p        location of aircraft
-- angle    heading of aircraft
rotate_point = function(center, point, deg)

    local a = math.rad(deg)    
    local s = math.sin(a)
    local c = math.cos(a)

    local x1 = point.x-center.x
    local y1 = point.y-center.y

    local x2 = x1 * c - y1 * s
    local y2 = x1 * s + y1 * c

    local x = x2 + center.x
    local y = y2 + center.y
    
    return {
        x = x,
        y = y
    }
end
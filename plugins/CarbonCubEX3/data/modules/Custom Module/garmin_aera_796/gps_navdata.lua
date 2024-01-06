include("../common.lua")
include("gps_helpers.lua")

-- data
sim_navdata = {}

------------------
-- GET NAV DATA --
------------------
get_nav_data = function(nid)
    -- loop through data
    if nid ~= NAV_NOT_FOUND or nid ~= nill then
        type, latitude, longitude, height, frequency, heading, id, name, isInsideLoadedDSFs = sasl.getNavAidInfo(nid)

        table.insert(sim_navdata, { 
            t = type, 
            lat = latitude, 
            lon = longitude, 
            height = height, 
            freq = frequency, 
            hdg = heading, 
            id = id, 
            name = name, 
            insideLoadedDSFs = isInsideLoadedDSFs 
        })
        
        local xid = sasl.getNextNavAid(nid)
        if xid ~= NAV_NOT_FOUND then
            return get_nav_data(xid)
        end
    -- loop finished
    else
        return 1
    end
end

-- get the first item in the nav database
local fid = sasl.getFirstNavAid()

-- initiate navdata loop
get_nav_data(fid)

--------------------
-- BUILD NAV DATA --
--------------------

build_nav_data = function()
    logInfo("gps navdata:", "build")
    local latitude = globalProperty("sim/flightmodel/position/latitude")
    local longitude = globalProperty("sim/flightmodel/position/longitude")
        
    local lat = get(latitude)
    local lon = get(longitude)
    -- local bbox = get_bounding_box(lat, lon, get(cc_gps_map_range))
    local bbox_hd = get_bounding_box(lat, lon, 50)
    local bbox_ld = get_bounding_box(lat, lon, 100)

    local navdata = {}

    -- iterate through navdata and update 
    for k, v in ipairs(sim_navdata) do
        local data = get(v)
        if (
            tonumber(data.lat) > tonumber(bbox_hd.lat1) and 
            tonumber(data.lat) < tonumber(bbox_hd.lat2) and 
            tonumber(data.lon) > tonumber(bbox_hd.lon1) and 
            tonumber(data.lon) < tonumber(bbox_hd.lon2)
        ) then
            table.insert(navdata, data)
        elseif (
            tonumber(data.lat) > tonumber(bbox_ld.lat1) and 
            tonumber(data.lat) < tonumber(bbox_ld.lat2) and 
            tonumber(data.lon) > tonumber(bbox_ld.lon1) and 
            tonumber(data.lon) < tonumber(bbox_ld.lon2)
        ) then
            if (
                data.t == NAV_AIRPORT or
                data.t == NAV_NDB or
                data.t == NAV_VOR or
                data.t == NAV_DME
            ) then
                table.insert(navdata, data)
            end
        end            
    end

    return navdata
end

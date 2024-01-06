-- includes
include("../common.lua")
-- include("datarefs.lua")
include("gps_navdata.lua")
include("gps_markers.lua")

-- data
cc_navdata = {}

local pos = {
    xl = 0,
    xr = 1080,
    yb = 0,
    yt = 1375
}

gps_settings = {
    posx = pos.xr/2,
    posy = pos.yt/3
}


onMouseDown = function(component, x, y, button, parentX, parentY)
    logInfo("moving map click: ", x, y, parentX, parentY)

    if button == MB_LEFT then
        x_zoom = 1007
        y_in = 998
        y_out = 1120

        if x > x_zoom-60 and x < x_zoom+60 and y > y_in-60 and y < y_in+60 then
            zoom_in()
        end

        if x > x_zoom-60 and x < x_zoom+60 and y > y_out-60 and y < y_out+60 then
            zoom_out()
        end
    end
end

-- moving map
moving_map = function()

    -- directional info
    local heading = globalProperty("sim/cockpit2/gauges/indicators/heading_AHARS_deg_mag_pilot")
    local ground = { 0.27, 0.32, 0.10, 1.00 } 
    sasl.gl.drawRectangle(pos.xl, pos.yb, pos.xr, pos.yt, { 0.12, 0.12, 0.12, 1.00 })

    local latitude = globalProperty("sim/flightmodel/position/latitude")
    local longitude = globalProperty("sim/flightmodel/position/longitude")
    local altitude = globalProperty("sim/cockpit2/gauges/indicators/altitude_ft_pilot")

    local lat = get(latitude)
    local lon = get(longitude)

    local distance = calculate_ll2_distance(lat, lon)

    if distance > 20 then
        cc_navdata = build_nav_data()
        set(cc_gps_recording_fix, { lat, lon })
    end

    -- logInfo(tablelength(get(cc_navdata)))

    -- local x, y, z = sasl.worldToLocal(get(latitude), get(longitude), get(altitude))
    -- local result, locationX, locationY, locationZ, normalX, normalY, normalZ, velocityX, velocityY, velocityZ, isWet = sasl.probeTerrain(x,y,z)
    -- logInfo(locationX, locationY, locationZ)
    -- logInfo(normalX, normalY, normalZ)
    -- logInfo(velocityX, velocityY, velocityZ)
    -- logInfo(isWet)

    local proj = newStereographicProjection(lat, lon, get(cc_gps_map_range), pos.yt/2)

    -- draw navdata layer
    for k, v in ipairs(cc_navdata) do
        local data = get(v)
        gps_marker(data, proj, gps_settings)
    end

    -- aircraft marker on top layer
    local image = sasl.gl.loadImage("garmin_aera_796/images/aircraft_marker.png")
    sasl.gl.drawTexture(image, gps_settings.posx-(129/2), gps_settings.posy-(105/2), 129, 105)

    -- other components
    zoom_buttons()
    screen_data()
    draw_scale(proj, lat, lon)
end

zoom_buttons = function()
    local zoom_in = sasl.gl.loadImage("garmin_aera_796/images/zoom_in.png")
    sasl.gl.drawTexture(zoom_in, pos.xr-120, pos.yt-300, 95, 95)

    local zoom_out = sasl.gl.loadImage("garmin_aera_796/images/zoom_out.png")
    sasl.gl.drawTexture(zoom_out, pos.xr-120, pos.yt-420, 95, 95)
end

zoom_out = function()
    local zoom = get(cc_gps_map_range)

    if zoom == 1 then
        set(cc_gps_map_range, 3)
    elseif zoom == 3 then
        set(cc_gps_map_range, 5)
    elseif zoom == 5 then
        set(cc_gps_map_range, 10)
    elseif zoom == 10 then
        set(cc_gps_map_range, 20)
    elseif zoom == 20 then
        set(cc_gps_map_range, 50)
    elseif zoom == 50 then
        set(cc_gps_map_range, 100)
    elseif zoom == 100 then
        set(cc_gps_map_range, 200)
    else
        set(cc_gps_map_range, 500)
    end
end

zoom_in = function()
    local zoom = get(cc_gps_map_range)
    if zoom == 3 then
        set(cc_gps_map_range, 1)
    elseif zoom == 5 then
        set(cc_gps_map_range, 3)
    elseif zoom == 10 then
        set(cc_gps_map_range, 5)
    elseif zoom == 20 then
        set(cc_gps_map_range, 10)
    elseif zoom == 50 then
        set(cc_gps_map_range, 20)
    elseif zoom == 100 then
        set(cc_gps_map_range, 50)
    elseif zoom == 200 then
        set(cc_gps_map_range, 100)
    elseif zoom == 500 then
        set(cc_gps_map_range, 200)
    end
end

screen_data = function()
    local gnd_trk = globalProperty("sim/cockpit2/gauges/indicators/ground_track_mag_pilot")
    local heading = globalProperty("sim/cockpit2/gauges/indicators/heading_AHARS_deg_mag_pilot")

    -- direct track
    sasl.gl.drawText(font_regular, pos.xr-60, pos.yt-65, "DTK", 40, false, false, TEXT_ALIGN_RIGHT, white)
    sasl.gl.drawText(font_regular, pos.xr-60, pos.yt-145, math.floor(get(gnd_trk)), 80, false, false, TEXT_ALIGN_RIGHT, white)
    sasl.gl.drawText(font_regular, pos.xr-50, pos.yt-110, "o", 35, false, false, TEXT_ALIGN_LEFT, white)
    sasl.gl.drawText(font_regular, pos.xr-50, pos.yt-145, "M", 40, false, false, TEXT_ALIGN_LEFT, white)

    -- track
    sasl.gl.drawText(font_regular, pos.xl+150, pos.yt-65, "TRK", 40, false, false, TEXT_ALIGN_RIGHT, white)
    sasl.gl.drawText(font_regular, pos.xl+150, pos.yt-145, math.floor(get(gnd_trk)), 80, false, false, TEXT_ALIGN_RIGHT, white)
    sasl.gl.drawText(font_regular, pos.xl+155, pos.yt-110, "o", 35, false, false, TEXT_ALIGN_LEFT, white)
    sasl.gl.drawText(font_regular, pos.xl+158, pos.yt-145, "M", 40, false, false, TEXT_ALIGN_LEFT, white)

    -- ete
    sasl.gl.drawText(font_regular, pos.xr-50, pos.yb+135, "ETE", 40, false, false, TEXT_ALIGN_RIGHT, white)
    sasl.gl.drawText(font_regular, pos.xr-50, pos.yb+50, "00:00", 80, false, false, TEXT_ALIGN_RIGHT, white)

    -- arrow
    local arrow = sasl.gl.loadImage("garmin_aera_796/images/arrow.png")

    local ax = pos.xl+125
    local ay = pos.yt-260

    sasl.gl.drawRotatedTextureCenter(arrow, get(heading), ax+1, ay+9, ax-40, ay-33, 82, 109)
    sasl.gl.drawText(font_bold, ax, ay, "N", 30, false, false, TEXT_ALIGN_CENTER, black)

end

draw_scale = function(proj, lat, lon)

    local range = get(cc_gps_map_range)

    local dx = (range*1609.34)*math.sin(math.rad(180))
    local dy = (range*1609.34)*math.cos(math.rad(180))

    local delta_lat = dy/110540
    local delta_lon = dx/(111320*math.cos(lat))

    local oc = { lat = lat, lon = lon }
    local nc = { lat = lat+delta_lat, lon = lon+delta_lon }

    local ox, oy = proj:LLtoXY(oc.lat, oc.lon)
    local nx, ny = proj:LLtoXY(nc.lat, nc.lon)

    local length = (math.abs(oy)+math.abs(ny))/2 -- divide length and range by 2

    -- scale
    sasl.gl.drawWideLine(pos.xr-300-length, pos.yb+50, pos.xr-300, pos.yb+50, 6, white)
    sasl.gl.drawWideLine(pos.xr-300-length, pos.yb+50, pos.xr-300-length, pos.yb+100, 6, white)
    sasl.gl.drawWideLine(pos.xr-300, pos.yb+50, pos.xr-300, pos.yb+100, 6, white)
    
    sasl.gl.drawText(font_regular, pos.xr-370, pos.yb+80, get(cc_gps_map_range)/2, 40, false, false, TEXT_ALIGN_RIGHT, white)
    sasl.gl.drawText(font_regular, pos.xr-365, pos.yb+80, "nm", 40, false, false, TEXT_ALIGN_LEFT, white)
end

-- draw the moving map
draw = function()
    sasl.gl.setClipArea(pos.xl, pos.yb, pos.xr, pos.yt)
    moving_map()
    sasl.gl.drawWideLine(pos.xl, pos.yb, pos.xl, pos.yt, 2, white)
    sasl.gl.resetClipArea()
end

-- initialize gps with initial navdata nd bbox navdata
onModuleInit = function()
    local latitude = globalProperty("sim/flightmodel/position/latitude")
    local longitude = globalProperty("sim/flightmodel/position/longitude")

    set(cc_gps_recording_fix, { get(latitude), get(longitude) })
    cc_navdata = build_nav_data()
end
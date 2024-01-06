-- include("datarefs")
include("common")

-- NAV_UNKNOWN
-- NAV_AIRPORT
-- NAV_NDB
-- NAV_VOR
-- NAV_ILS
-- NAV_LOCALIZER
-- NAV_GLIDESCOPE
-- NAV_OUTERMARKER
-- NAV_MIDDLEMARKER
-- NAV_INNERMARKER
-- NAV_FIX
-- NAV_DME

gps_marker = function (data, proj, gps_settings)
    local heading = globalProperty("sim/cockpit2/gauges/indicators/heading_AHARS_deg_mag_pilot")
    local xp, yp = proj:LLtoXY(data.lat, data.lon)

    -- calculate projected x, y
    local x = gps_settings.posx+xp
    local y = gps_settings.posy+yp
    local deg = get(heading)

    local point = rotate_point({ x = gps_settings.posx, y = gps_settings.posy }, { x = x, y = y }, deg)
    -- logInfo(x, c.x, y, c.y)
    
    if data.t == NAV_UNKNOWN        then NAV_UNKNOWN_marker(point, data) end
    if data.t == NAV_AIRPORT        then NAV_AIRPORT_marker(point, data) end
    if data.t == NAV_NDB            then NAV_NDB_marker(point, data) end
    if data.t == NAV_VOR            then NAV_VOR_marker(point, data) end
    if data.t == NAV_ILS            then NAV_ILS_marker(point, data) end
    if data.t == NAV_LOCALIZER      then NAV_LOCALIZER_marker(point, data) end
    -- if data.t == NAV_GLIDESCOPE     then NAV_GLIDESCOPE_marker(point, data) end
    if data.t == NAV_OUTERMARKER    then NAV_OUTERMARKER_marker(point, data) end
    if data.t == NAV_MIDDLEMARKER   then NAV_MIDDLEMARKER_marker(point, data) end
    if data.t == NAV_INNERMARKER    then NAV_INNERMARKER_marker(point, data) end
    if data.t == NAV_FIX            then NAV_FIX_marker(point, data) end
    if data.t == NAV_DME            then NAV_DME_marker(point, data) end
end

NAV_UNKNOWN_marker = function(point, data)
    -- logInfo(data.name, data.id)
end

NAV_AIRPORT_marker = function(point, data)
    sasl.gl.drawCircle(point.x, point.y, 30, true, blue)
    sasl.gl.drawText(font_regular, point.x, point.y-60, data.id, 30, false, false, TEXT_ALIGN_CENTER, blue)
    sasl.gl.drawText(font_regular, point.x, point.y-90, data.name, 30, false, false, TEXT_ALIGN_CENTER, white)
end

NAV_NDB_marker = function(point, data)
    sasl.gl.drawCircle(point.x, point.y, 20, true, purple)
end

NAV_VOR_marker = function(point, data)
    x1 = point.x-34
    y1 = point.y

    x2 = point.x-17
    y2 = point.y+28

    x3 = point.x+17
    y3 = point.y+28

    x4 = point.x+34
    y4 = point.y

    x5 = point.x+17
    y5 = point.y-28

    x6 = point.x-17
    y6 = point.y-28

    sasl.gl.drawConvexPolygon({ x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6 }, false, 2, blue)
    sasl.gl.drawText(font_regular, point.x, point.y-60, data.id, 30, false, false, TEXT_ALIGN_CENTER, blue)
    sasl.gl.drawText(font_regular, point.x, point.y-90, data.freq/100, 30, false, false, TEXT_ALIGN_CENTER, blue)
end

NAV_ILS_marker = function(point, data)

end

NAV_LOCALIZER_marker = function(point, data)

end

NAV_GLIDESCOPE_marker = function(point, data)

end

NAV_OUTERMARKER_marker = function(point, data)

end

NAV_MIDDLEMARKER_marker = function(point, data)

end

NAV_INNERMARKER_marker = function(point, data)

end

NAV_FIX_marker = function(point, data)
    local gps_scale = get(cc_gps_map_range)
    if gps_scale < 50 then  
        x1 = point.x-15
        y1 = point.y-5
        x2 = point.x
        y2 = point.y+15
        x3 = point.x+15
        y3 = point.y-5

        sasl.gl.drawConvexPolygon({ x1, y1, x2, y2, x3, y3 }, false, 1, purple)
        sasl.gl.drawText(font_regular, point.x, point.y, data.id, 30, false, false, TEXT_ALIGN_LEFT, purple)
    end
end

NAV_DME_marker = function(point, data)
    x1 = point.x-34
    y1 = point.y-28
    x2 = point.x-34
    y2 = point.y+28
    x3 = point.x+34
    y3 = point.y+28
    x4 = point.x+34
    y4 = point.y-28
    sasl.gl.drawConvexPolygon({ x1, y1, x2, y2, x3, y3, x4, y4 }, false, 1, white)
end
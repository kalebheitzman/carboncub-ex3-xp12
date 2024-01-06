include("gps_pos.lua")

draw = function()
    -- get current magnetic heading
    local heading = get(globalProperty("sim/cockpit2/gauges/indicators/heading_electric_deg_mag_pilot"))

    -- draw dividers
    sasl.gl.drawWideLine(pos.xr, pos.yt-(140/2), pos.xl, pos.yt-(140/2), 140, black_t)

    -- heading ruler
    heading_ruler(pos)

    -- draw heading indicator
    local image = sasl.gl.loadImage("garmin_aera_796/images/hdg-box.png")
    sasl.gl.drawTexture(image, (pos.xr/2)-70, pos.yt-130, 140, 95)
    sasl.gl.drawText(font_regular, pos.xr/2, pos.yt-90, math.floor(heading), 70, false, false, TEXT_ALIGN_CENTER, white)

end

heading_ruler = function(pos)
    -- get current magnetic heading
    local hdg = get(globalProperty("sim/cockpit2/gauges/indicators/heading_electric_deg_mag_pilot"))

    -- tick markers
    local tick = pos.xr/7
    local tick_2 = tick/2
    local tick_10 = tick/10

    -- calculation vars
    local hdg_t = math.floor(hdg/10)*10

    -- build ias table
    local hdg_min = hdg_t-40
    local hdg_max = hdg_t+40
    local hdg_table = {}
    for i = hdg_min, hdg_max, 10 do
        i2 = i
        if i2 < 1 then
            i2 = 360+i
        end
        if i2 > 360 then
            i2 = i-360
        end
        table.insert(hdg_table, i2)
    end

    -- get the ias diff ratio
    local hdg_d = ((hdg-hdg_t)/10)*tick

    -- draw tick marks
    for k, v in pairs(hdg_table) do
        sasl.gl.drawWideLine((tick*k)-234-hdg_d, pos.yt-140, (tick*k)-234-hdg_d, pos.yt-106, 2, white)
        sasl.gl.drawText(font_regular, (tick*k)-234-hdg_d, pos.yt-90, v, 50, false, false, TEXT_ALIGN_CENTER, white)

        for i = tick_2, tick, tick_2 do
            sasl.gl.drawWideLine(((tick*k)-234-hdg_d)+i, pos.yt-140, ((tick*k)-234-hdg_d)+i, pos.yt-120, 2, white)        
        end

        for i = tick_10, tick, tick_10 do
            sasl.gl.drawWideLine(((tick*k)-234-hdg_d)+i, pos.yt-140, ((tick*k)-234-hdg_d)+i, pos.yt-130, 2, white)        
        end

    end

end
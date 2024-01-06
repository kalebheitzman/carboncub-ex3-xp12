include("gps_pos.lua")

-- position of divider lin
local xdiv = 260

draw = function()
    -- get current ias
    local ias = get(globalProperty("sim/cockpit2/gauges/indicators/airspeed_kts_pilot"))
    if ias < 10 then
        ias = 0
    end

    -- draw dividers
    sasl.gl.drawWideLine(pos.xl+130, pos.yb, pos.xl+130, pos.yt-140, 260, black_t)
    sasl.gl.drawWideLine(xdiv, pos.yb, xdiv, pos.yt-140, 2, white)
    sasl.gl.drawWideLine(pos.xl, pos.yt-140, pos.xl+260, pos.yt-140, 2, white)
    
    -- get speed ruler
    speed_ruler(pos)

    -- get current ias in mph
    local ias_mph = kts_to_mph(ias)
    if ias_mph < 0 then
        ias_mph = 0
    end

    -- draw indicator box
    local ais_box = sasl.gl.loadImage("garmin_aera_796/images/ais-box.png")
    sasl.gl.drawTexture(ais_box, xdiv-230, (pos.yt/2)-125, 221, 198)

    -- draw airspeed digits
    sasl.gl.drawText(font_regular, xdiv-82, (pos.yt/2)-50, math.floor(ias_mph/10), 80, false, false, TEXT_ALIGN_RIGHT)

    -- get movable digits
    ias_n_digits()
    
end

-- movable last digit
ias_n_digits = function()
    local ias_sim = globalProperty("sim/cockpit2/gauges/indicators/airspeed_kts_pilot")
    local ias_mph = kts_to_mph(get(ias_sim))
    if ias_mph < 0 then
        ias_mph = 0
    end

    -- get integer and decimal of ias for calculations
    local ias, ias_d = math.modf(ias_mph)
    local ias_length = string.len(ias)

    -- current digit
    local c = string.sub(ias, -1)

    -- next two digits
    local n = c+1
    local n2 = c+2
    if (n == 10) then 
        n = 0 
        n2 = 1
    end

    -- previous two digits
    local p = c-1
    local p2 = c-2
    if (p == -1) then 
        p = 9 
        p2 = 8
    end

    -- calculate y pos
    local step = 70
    local ypos = 638-(step*ias_d)

    -- xpos
    local xpos = xdiv-40

    -- set the clip area
    sasl.gl.setClipArea(xdiv-82, 566, 49, 192)

    -- draw the next two numbers
    sasl.gl.drawText(font_regular, xpos, ypos+(step*2), n2, 80, false, false, TEXT_ALIGN_RIGHT)
    sasl.gl.drawText(font_regular, xpos, ypos+step, n, 80, false, false, TEXT_ALIGN_RIGHT)

    -- draw the current number
    sasl.gl.drawText(font_regular, xpos, ypos, c, 80, false, false, TEXT_ALIGN_RIGHT)

    -- draw the previous two numbers
    if (ias_mph > 10) then
        sasl.gl.drawText(font_regular, xpos, ypos-step, p, 80, false, false, TEXT_ALIGN_RIGHT)
        sasl.gl.drawText(font_regular, xpos, ypos-(step*2), p2, 80, false, false, TEXT_ALIGN_RIGHT)
    end

    -- reset the clip area
    sasl.gl.resetClipArea()
    
end

speed_ruler = function(pos)
    local ias_sim = globalProperty("sim/cockpit2/gauges/indicators/airspeed_kts_pilot")
    local ias_mph = kts_to_mph(get(ias_sim))
    local ias_i = math.floor(ias_mph)
    
    -- tick mark heights
    local tick = (pos.yt-140-60)/8
    local tick_5 = tick/2

    -- calculation vars
    local ias_t = math.floor(ias_i/10)*10

    -- build ias table
    local ias_min = ias_t-50
    local ias_max = ias_t+50
    local ias_table = {}
    for i = ias_min, ias_max, 10 do
        table.insert(ias_table, i)
    end

    -- get the ias diff ratio
    local ias_d = ((ias_mph-ias_t)/10)*tick

    -- set clip area
    sasl.gl.setClipArea(pos.xl, 0, 260, pos.yt-140)

    -- draw tick marks
    for k, v in pairs(ias_table) do
        sasl.gl.drawWideLine(pos.xl+260, ((tick*k)-218-ias_d), pos.xl+220, ((tick*k-ias_d)-218), 2, white)
        sasl.gl.drawText(font_regular, pos.xl+200, ((tick*k-ias_d)-238), v, 60, false, false, TEXT_ALIGN_RIGHT, white)

        for i = tick_5, tick, tick_5 do
            sasl.gl.drawWideLine(pos.xl+235, ((tick*k)-218-ias_d)+i, pos.xl+260, ((tick*k)-218-ias_d)+i, 2, white)        
        end
    end

    -- reset the clip area
    sasl.gl.resetClipArea()

end
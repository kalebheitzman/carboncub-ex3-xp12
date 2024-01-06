include("gps_pos.lua")

draw = function()
    -- get current altitude
    local alt = get(globalProperty("sim/cockpit2/gauges/indicators/altitude_ft_pilot"))

    -- draw dividers
    sasl.gl.drawWideLine(pos.xr-130, pos.yb, pos.xr-130, pos.yt-140, 260, black_t)
    sasl.gl.drawWideLine(pos.xr-260, pos.yb, pos.xr-260, pos.yt-140, 2, white)
    sasl.gl.drawWideLine(pos.xr-260, pos.yt-140, pos.xr, pos.yt-140, 2, white)
    sasl.gl.drawWideLine(pos.xr, pos.yb, pos.xr, pos.yt-140, 2, white)

    -- altitude ruler
    altitude_ruler(pos, alt)

    -- draw altitude indicator box
    local image = sasl.gl.loadImage("garmin_aera_796/images/alt-box.png")
    sasl.gl.drawTexture(image, pos.xr-250, (pos.yt/2)-(167/2)-20, 242, 167)

    -- alt to integer
    local alt_i = math.floor(alt)

    -- calc ft and fl
    local alt_l = string.len(alt_i)
    local s_fl = alt_l-2
    local alt_fl = 0
    local alt_ft = tonumber(string.sub(alt_i, -2))
    if alt_l > 2 then
        alt_fl = string.sub(alt_i, 1, s_fl)
    end

    -- build alt 20 strings
    local alt_20_table = {
        "00", -- 1
        "20", -- 2
        "40", -- 3
        "60", -- 4
        "80"  -- 5
    }

    -- get the alt_idx to reference alt_20_table
    local alt_idx = 1
    if alt_ft > 80 then
        alt_idx = 5
    elseif alt_ft > 60 then
        alt_idx = 4
    elseif alt_ft > 40 then
        alt_idx = 3
    elseif alt_ft > 20 then
        alt_idx = 2
    end

    -- calculate alt_d
    local alt_d = (alt_ft-(math.floor(alt_ft/20)*20))/20
    
    -- flight level
    sasl.gl.drawText(font_regular, pos.xr-85, (pos.yt/2)-(167/2)+40, alt_fl, 80, false, false, TEXT_ALIGN_RIGHT)

    -- calculate y pos for twentys
    local step = 55
    local ypos = ((pos.yt/2)-(167/2)+45)-(step*alt_d)

    -- x position
    local xpos = pos.xr-83

    -- alt indexes
    local n1_idx = alt_idx+1
    if n1_idx > 5 then
        n1_idx = 1
    end
    local n2_idx = n1_idx+1
    if n2_idx > 5 then
        n2_idx = 1
    end
    local p1_idx = alt_idx-1
    if (p1_idx < 1) then
        p1_idx = 5
    end
    local p2_idx = p1_idx-1
    if p2_idx < 1 then
        p2_idx = 5
    end

    -- set the clip area
    sasl.gl.setClipArea(pos.xr-87, (pos.yt/2)-102, 76, 164)

    -- the next two twentys
    sasl.gl.drawText(font_regular, xpos, ypos+(step*2), alt_20_table[n2_idx], 65, false, false, TEXT_ALIGN_LEFT)
    sasl.gl.drawText(font_regular, xpos, ypos+step, alt_20_table[n1_idx], 65, false, false, TEXT_ALIGN_LEFT)

    -- the current twenty
    sasl.gl.drawText(font_regular, xpos, ypos, alt_20_table[alt_idx], 65, false, false, TEXT_ALIGN_LEFT)

    -- the previous two twentys
    sasl.gl.drawText(font_regular, xpos, ypos-step, alt_20_table[p1_idx], 65, false, false, TEXT_ALIGN_LEFT)
    sasl.gl.drawText(font_regular, xpos, ypos-(step*2), alt_20_table[p2_idx], 65, false, false, TEXT_ALIGN_LEFT)

    -- reset the clip area
    sasl.gl.resetClipArea()

end

altitude_ruler = function(pos, alt)

    -- set clip area
    sasl.gl.setClipArea(pos.xr-260, 0, 260, pos.yt-140)

    -- tick mark heights
    local tick_100 = (pos.yt-140-60)/6
    local tick_20 = tick_100/5

    -- alt to integer
    local alt_i = math.floor(alt)
    local alt_t = math.floor(alt/100)*100

    -- build alt thousand table
    local alt_min = alt_t-300
    local alt_max = alt_t+300
    local alt_1000_table = {}
    for i = alt_min, alt_max, 100 do
        table.insert(alt_1000_table, i)
    end

    -- get the alt diff ratio
    local alt_d = ((alt_i-alt_t)/100)*tick_100

    -- draw tick marks
    for k, v in pairs(alt_1000_table) do
        sasl.gl.drawWideLine(pos.xr-260, ((tick_100*k)-115-alt_d), pos.xr-220, ((tick_100*k-alt_d)-115), 2, white)
        sasl.gl.drawText(font_regular, pos.xr-210, ((tick_100*k-alt_d)-135), v, 60, false, false, TEXT_ALIGN_LEFT, white)

        for i = tick_20, tick_100, tick_20 do
            sasl.gl.drawWideLine(pos.xr-260, ((tick_100*k)-115-alt_d)+i, pos.xr-240, ((tick_100*k)-115-alt_d)+i, 2, white)        
        end
    end

    -- reset the clip area
    sasl.gl.resetClipArea()

end

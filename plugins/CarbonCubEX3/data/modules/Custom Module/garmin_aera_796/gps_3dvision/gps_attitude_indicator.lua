include("gps_pos.lua")

-- attitude indicator
draw = function()

    -- get pitch and roll
    local drf = {
        pitch = globalProperty("sim/cockpit2/gauges/indicators/pitch_AHARS_deg_pilot"),
        roll = globalProperty("sim/cockpit2/gauges/indicators/roll_AHARS_deg_pilot")
    }

    -- constants
    local cx = 540 -- radius
    local cy = (pos.yt - 140) / 2

    -- get pitch and roll
    local pitch = get(drf.pitch)
    local roll = get(drf.roll)

    -- calculations
    local pd = math.tan(math.rad(pitch)) * (cx * 2)

    -- pitch degrees
    local pos_pitch_min = 0
    local pos_pitch_max = 50
    local pos_pitch_table = {}
    for i = pos_pitch_min, pos_pitch_max, 5 do
        table.insert(pos_pitch_table, i)
    end

    -- get the pitch diff ratio
    local radius = get(globalProperty("sim/physics/earth_radius_m"))
    -- y axis middle
    local cy = (pos.yt / 2) - pd

    -- set graphics area
    -- sasl.gl.setClipArea((pos.xr/2)-230, pos.yb+180, 460, 1000, red)

    -- draw pos tick marks
    for k, v in pairs(pos_pitch_table) do
        local p_diff = math.tan(math.rad(v)) * (cx * 2)
        local r_diff = math.tan(math.rad(roll)) * (cx * 2)
        local x_pos = (pos.xr / 2)
        local y_pos = p_diff + (cy - 70)
        -- logInfo("y", y_pos)

        -- 5 deg tick
        if pos_pitch_table[k + 1] and v ~= 0 then
            local n_diff = math.tan(math.rad(pos_pitch_table[k + 1])) * (cx * 2)
            local y_pos_h = y_pos - ((n_diff - p_diff) / 2)

            -- sasl.gl.drawText(font_regular, x_pos-70, y_pos-12, v, 40, false, false, TEXT_ALIGN_RIGHT, white)
            -- sasl.gl.drawText(font_regular, x_pos+70, y_pos-12, v, 40, false, false, TEXT_ALIGN_LEFT, white)
            -- drawRotatedWideLine(x_pos-30, y_pos_h, x_pos+30, y_pos_h, cx, cy, 2, white, v)
            -- drawTick(x_pos, y_pos_h, cx, cy, v)
            -- -2.5 deg tick
        else
            local twofive_diff = math.tan(math.rad(-2.5)) * (cx * 2)
            local twofive_y_pos = twofive_diff + cy
            -- drawRotatedWideLine(x_pos-30, twofive_y_pos, x_pos+30, twofive_y_pos, cx, cy, 2, white)
        end

        -- drawRotatedWideLine(x_pos-60, y_pos, x_pos+60, y_pos, cx, cy, 2, white)
        drawTick(cx, cy, y_pos, v)
    end

    -- reset graphics area
    -- sasl.gl.resetClipArea()
end

-- drawRotatedWideLine = function(x1, y1, x2, y2, cx, cy, width, color, deg)
--     local angle = get(globalProperty("sim/cockpit2/gauges/indicators/roll_AHARS_deg_pilot"))
--     local theta = math.rad(angle)

--     local x1_r = (x1*math.cos(theta))-(y1*math.sin(theta))
--     local x2_r = (x2*math.cos(theta))-(y2*math.sin(theta))
--     local y1_r = (x1*math.sin(theta))+(y1*math.cos(theta))
--     local y2_r = (x2*math.sin(theta))+(y2*math.cos(theta))

--     -- sasl.gl.drawWideLine(x1_r, y1_r, x2_r, y2_r, width, color)
--     sasl.gl.drawWideLine(x1, y1, x2, y2, width, color)
-- end

drawTick = function(cx, cy, y, deg)
    local radius = y - cy
    local angle = get(globalProperty("sim/cockpit2/gauges/indicators/roll_AHARS_deg_pilot"))
    local theta = math.rad(angle)

    -- local x1_r = (x1*math.cos(theta))-(y1*math.sin(theta))
    -- local x2_r = (x2*math.cos(theta))-(y2*math.sin(theta))
    -- local y1_r = (x1*math.sin(theta))+(y1*math.cos(theta))
    -- local y2_r = (x2*math.sin(theta))+(y2*math.cos(theta))

    -- calculate new x and y
    local tx = radius * math.cos(theta)
    local ty = radius * math.sin(theta)
    logInfo(cx, tx, y, cy)

    -- calculate line start
    ls_x = tx - 60
    ls_y = ty

    -- calculate line end
    le_x = tx + 60
    le_y = ty

    -- -- calculate line start
    -- ls_x = ((x-60)*math.cos(theta))-(y*math.sin(theta))
    -- ls_y = ((x-60)*math.sin(theta))+(y*math.cos(theta))

    -- -- calculate line end
    -- le_x = ((x+60)*math.cos(theta))-(y*math.sin(theta))
    -- le_y = ((x+60)*math.sin(theta))+(y*math.cos(theta))

    -- calculate left deg
    dl_x = cx - 70
    dl_y = y - 12

    -- calculate right deg
    dr_x = cx + 70
    dr_y = y - 12

    -- draw tickmark
    sasl.gl.drawWideLine(ls_x, ls_y, le_x, le_y, 2, white)
    sasl.gl.drawText(font_regular, dl_x, dl_y, deg, 40, false, false, TEXT_ALIGN_RIGHT, white)
    sasl.gl.drawText(font_regular, dr_x, dr_y, deg, 40, false, false, TEXT_ALIGN_LEFT, white)
end

-- update = function()
--     -- constants
--     local cx = 540 -- radius
--     -- transform component
--     sasl.gl.setRotateTransform(50)
--     -- sasl.gl.setTranslateTransform(0, 0)
--     local max_h = math.tan(math.rad(50))*(cx*2)
--     local min_h = math.tan(math.rad(-50))*(cx*2)
--     logInfo(max_h, min_h)

-- end

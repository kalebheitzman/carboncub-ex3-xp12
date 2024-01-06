include("gps_pos.lua")

-- horizon indicator
draw = function()
    local sky = { 0.00, 0.18, 0.96, 1.00 }
    local ground = { 0.27, 0.32, 0.10, 1.00 } 
    
    --get pitch and roll
    local drf = {
        pitch = globalProperty("sim/cockpit2/gauges/indicators/pitch_AHARS_deg_pilot"),
        roll = globalProperty("sim/cockpit2/gauges/indicators/roll_AHARS_deg_pilot"),
    }

    -- constants
    local xs = 0
    local xe = 1080
    local cx = xe/2 -- radius
    local ys = 0
    local cy = (pos.yt-140)/2

    -- get pitch and roll
    local pitch = get(drf.pitch)
    local roll = get(drf.roll)
        
    -- calculations
    local rd = math.tan(math.rad(roll))*cx
    local pd = math.tan(math.rad(pitch))*(cx*2)
    local y1 = (cy+rd)-pd
    local y2 = (cy-rd)-pd

    -- sky texture
    sasl.gl.drawRectangle(pos.xl, pos.yb, pos.xr, pos.yt, sky)

    -- horizon texture
    sasl.gl.drawConvexPolygon({xs, ys, xe, ys, xe, y1, xs, y2}, true, 5, ground)
    -- sasl.gl.drawWideLine(xs, y2, xe, y1, 6, white)

    -- fd drop shadow
    sasl.gl.drawWideLine(xs+296, cy-6, xs+402, cy-6,  22, black)
    sasl.gl.drawWideLine(xe-296, cy-6, xe-402, cy-6,  22, black)
    sasl.gl.drawWideLine(xs+400, cy-6, xs+400, cy-48, 22, black)
    sasl.gl.drawWideLine(xe-400, cy-6, xe-400, cy-48, 22, black)

    -- fd yello
    sasl.gl.drawWideLine(xs+300, cy, xs+405, cy,    12, yellow)
    sasl.gl.drawWideLine(xe-300, cy, xe-405, cy,    12, yellow)
    sasl.gl.drawWideLine(xs+405, cy, xs+405, cy-40, 12, yellow)
    sasl.gl.drawWideLine(xe-405, cy, xe-405, cy-40, 12, yellow)

    -- center marker
    sasl.gl.drawWideLine((xe/2)-26, cy-6, (xe/2)+26, cy-6, 22, black)
    sasl.gl.drawWideLine((xe/2)-20, cy, (xe/2)+20, cy, 12, yellow)
end

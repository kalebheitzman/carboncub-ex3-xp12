include("gps_pos.lua")

draw = function()

    local m = pos.xr/2

    sasl.gl.drawWideLine(m-230, 70, m+230, 70, 80, black_t)
    sasl.gl.drawWideLine(m-25, 40, m-25, 100, 2, white)
    sasl.gl.drawWideLine(m+60, 40, m+60, 100, 2, white)
    sasl.gl.drawCircle((m+17.5), 70, 35, true, white)
end
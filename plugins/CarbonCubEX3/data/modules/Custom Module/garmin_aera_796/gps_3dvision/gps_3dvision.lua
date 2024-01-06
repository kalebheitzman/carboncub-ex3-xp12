include("../../common.lua")
include("gps_pos.lua")

gps_components = {
    gps_horizon {},
    gps_attitude_indicator {},
    gps_heading_tape {},
    gps_speed_tape {},
    gps_altitude_tape {},
    gps_slip_indicator {},
}

draw = function()
    sasl.gl.setClipArea(pos.xl, pos.yb, pos.xr, pos.yt)
    drawAll(gps_components)
    sasl.gl.resetClipArea()
end
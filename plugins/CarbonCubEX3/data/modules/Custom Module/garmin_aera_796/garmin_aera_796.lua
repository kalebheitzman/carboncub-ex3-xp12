include("../styles.lua")
include("datarefs.lua")
include("commands.lua")

-- components = { -- gps_menu {},
-- gps_3dvision {
--     position = {180, 130, 1080, 1375}
-- }, gps_moving_map {
--     -- fbo = true,
--     -- fpsLimit = 30,
--     position = {1260, 130, 1080, 1375}
-- }, gps_primary_buttons {
--     position = {2345, 130, 300, 1375}
-- }}

draw = function()
    local cc_avionics = globalPropertyi("sim/cockpit2/switches/avionics_power_on")
    local cc_avionics_on = get(cc_avionics)
    local main_battery = get(sim_main_battery)
    local tablet_power = get(cc_gps_tablet_power)
    local avitab_enabled = get(globalProperty("avitab/panel_enabled"))

    if (cc_avionics_on == 1 and main_battery == 1 and tablet_power == 1 and avitab_enabled == 0) then
        -- drawAll(components)
        set(avi_panel_enabled, 1)
    else
        set(avi_panel_enabled, 0)
    end
end

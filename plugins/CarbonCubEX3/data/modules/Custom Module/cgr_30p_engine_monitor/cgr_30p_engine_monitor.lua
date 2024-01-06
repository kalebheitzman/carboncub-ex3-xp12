-- colors and fonts
include("../styles.lua")

-- project 
include("datarefs.lua")
include("commands.lua")

-- local
include("helpers.lua")
include("screens_primary.lua")
include("screens_left.lua")
include("screens_right.lua")
include("screens_bottom.lua")
include("screens.lua")

----------------------
-- Main Monitor Layout
----------------------
function monitor_layout()

    -- primary displays
    primary_mp()
    primary_rpm()

    -- display logic
    local current_screen = get(cc_engine_screen)
    if (current_screen == 1) then
        main_screen()
    elseif (current_screen == 2) then
        secondary_screen()
    end
    
    -- bottom screens
    bottom_egt_screen()
    bottom_cht_screen()
end

function draw()
    cc_avionics = globalPropertyi("sim/cockpit2/switches/avionics_power_on")
    cc_avionics_on = get(cc_avionics)
    main_battery = get(sim_main_battery)

    if cc_avionics_on == 1 and main_battery == 1 then
        monitor_layout()
    end
end

include("../styles.lua")
include("../common.lua")
include("datarefs.lua")
include("commands.lua")
include("screens.lua")

----------------------------
-- HACK FIX FOR CLICKSPOT --
-- This really should be  --
-- done in Blender        --
----------------------------
onMouseDown = function(component, x, y, button, parentX, parentY)
    logInfo("smart monitor click: ", x, y, parentX, parentY)
    -- sasl.commandOnce(smart_battery_mode)
end

----------
-- DRAW --
----------
function draw()
    local main_battery = get(sim_main_battery)
    local current_mode = get(cc_battery_mode)

    if main_battery ~= 1 then
        return false
    end

    if current_mode == 0 then
        screen_mainv()
    elseif current_mode == 1 then
        screen_backv()
    elseif current_mode == 2 then
        screen_l_ign()
    elseif current_mode == 3 then
        screen_r_ign()
    elseif current_mode == 4 then
        screen_backup()        
    end
end

-- timer
cc_hatches_timer = sasl.createTimer()

-- toggle door
function toggle_door_handler(phase)
    -- open the door
    if phase == SASL_COMMAND_BEGIN and get(cc_door) == 0 then
        set(cc_door, 1)
    -- close the door
    elseif phase == SASL_COMMAND_BEGIN and get(cc_door) == 1 then
        set(cc_door, 0)
    end
    return 1
end

-- toggle cargo hatch
function toggle_cargo_hatch_handler(phase)
    -- open the door
    if phase == SASL_COMMAND_BEGIN and get(cc_hatch) == 0 then
        set(cc_hatch, 1)
    -- close the door
    elseif phase == SASL_COMMAND_BEGIN and get(cc_hatch) == 1 then
        set(cc_hatch, 0)
    end
    return 1
end

-- command handlers
toggle_door         = sasl.createCommand("cc_ex3/doors/toggle_door", "Toggle door open and close")
toggle_cargo_hatch  = sasl.createCommand("cc_ex3/doors/toggle_cargo_hatch", "Toggle cargo hatch open and close")

-- register command handlers
sasl.registerCommandHandler(toggle_door, 0, toggle_door_handler)
sasl.registerCommandHandler(toggle_cargo_hatch, 0, toggle_cargo_hatch_handler)

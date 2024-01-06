-- trim priority right
function trim_priority_right_handler(phase)
    mode = get(cc_sw_trim_priority)
    if phase == SASL_COMMAND_BEGIN and mode == 0 then
        set(cc_sw_trim_priority, 1)
    elseif phase == SASL_COMMAND_BEGIN and mode == 2 then
        set(cc_sw_trim_priority, 0)
    end
    return 1
end

-- trim priority left
function trim_priority_left_handler(phase)
    mode = get(cc_sw_trim_priority)
    if phase == SASL_COMMAND_BEGIN and mode == 1 then
        set(cc_sw_trim_priority, 0)
    elseif phase == SASL_COMMAND_BEGIN and mode == 0 then
        set(cc_sw_trim_priority, 2)
    end
    return 1
end

-- command handlers
trim_priority_right = sasl.createCommand("cc_ex3/electrical/trim_priority_toggle_right", "Trim priority right")
trim_priority_left = sasl.createCommand("cc_ex3/electrical/trim_priority_toggle_left", "Trim priority left")

-- register command handlers
sasl.registerCommandHandler(trim_priority_right, 0, trim_priority_right_handler)
sasl.registerCommandHandler(trim_priority_left, 0, trim_priority_left_handler)
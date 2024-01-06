--------------
-- COMMANDS --
--------------

-- toggle s button
function engine_monitor_s_handler(phase)
    if phase == SASL_COMMAND_BEGIN then
        if get(cc_engine_screen) == 1 then
            set(cc_engine_screen, 2)
        else
            set(cc_engine_screen, 1)
        end
    end
    return 1
end

-- toggle s button
function engine_monitor_e_handler(phase)
    if phase == SASL_COMMAND_BEGIN then
        logInfo("e button")
    end
    return 1
end

-- toggle s button
function engine_monitor_push_button_handler(phase)
    if phase == SASL_COMMAND_BEGIN then
        logInfo("push button handler")
    end
    return 1
end

-- toggle s button
function engine_monitor_scroll_left_handler(phase)
    local cyl = get(cc_engine_sel_cyl)
    if phase == SASL_COMMAND_BEGIN then
        if (cyl > 1) then
            set(cc_engine_sel_cyl, cyl-1)
        else
            set(cc_engine_sel_cyl, 4)
        end
    end
    return 1
end

-- toggle s button
function engine_monitor_scroll_right_handler(phase)
    local cyl = get(cc_engine_sel_cyl)
    if phase == SASL_COMMAND_BEGIN then
        if (cyl < 4) then
            set(cc_engine_sel_cyl, cyl+1)
        else
            set(cc_engine_sel_cyl, 1)
        end
    end
    return 1
end

-- command handlers
engine_monitor_s = sasl.createCommand("cc_ex3/engine/button_s", "Toggle engine monitor s button")
engine_monitor_e = sasl.createCommand("cc_ex3/engine/button_e", "Toggle engine monitor e button")
engine_monitor_push_button = sasl.createCommand("cc_ex3/engine/button_select", "CGR push button")
engine_monitor_scroll_left = sasl.createCommand("cc_ex3/engine/knob_scroll_left", "CGR scroll left")
engine_monitor_scroll_right = sasl.createCommand("cc_ex3/engine/knob_scroll_right", "CGR scroll right")

-- register command handlers
sasl.registerCommandHandler(engine_monitor_s, 0, engine_monitor_s_handler)
sasl.registerCommandHandler(engine_monitor_e, 0, engine_monitor_e_handler)
sasl.registerCommandHandler(engine_monitor_push_button, 0, engine_monitor_push_button_handler)
sasl.registerCommandHandler(engine_monitor_scroll_left, 0, engine_monitor_scroll_left_handler)
sasl.registerCommandHandler(engine_monitor_scroll_right, 0, engine_monitor_scroll_right_handler)

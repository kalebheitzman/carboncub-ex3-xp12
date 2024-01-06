--------------
-- COMMANDS --
--------------

-- smart battery mode
function smart_battery_mode_handler(phase)
    current_mode = get(cc_battery_mode)
    if phase == SASL_COMMAND_BEGIN then
        if (current_mode < 4) then
            set(cc_battery_mode, current_mode+1)
        else
            set(cc_battery_mode, 0)
        end
    end
    return 1
end

-- main battery toggle
function main_battery_toggle_handler(phase)
    if phase == SASL_COMMAND_BEGIN then
        local toggle_main_battery = sasl.findCommand("sim/electrical/battery_1_toggle")
        local toggle_main_generator = sasl.findCommand("sim/electrical/generator_1_toggle")
        sasl.commandOnce(toggle_main_battery)
        sasl.commandOnce(toggle_main_generator)
    end
end

-- backup battery toggle
function backup_battery_toggle_handler(phase)
    if phase == SASL_COMMAND_BEGIN then
        local toggle_backup_battery = sasl.findCommand("sim/electrical/battery_2_toggle")
        local toggle_backup_generator = sasl.findCommand("sim/electrical/generator_2_toggle")
        sasl.commandOnce(toggle_backup_battery)
        sasl.commandOnce(toggle_backup_generator)
    end
end

-- command handlers
smart_battery_mode = sasl.createCommand("cc_ex3/electrical/smart_battery_mode", "Toggle battery mode")
main_battery_toggle = sasl.createCommand("cc_ex3/electrical/main_battery_toggle", "Toggle main battery")
backup_battery_toggle = sasl.createCommand("cc_ex3/electrical/backup_battery_toggle", "Toggle backup battery")

-- register command handlers
sasl.registerCommandHandler(smart_battery_mode, 0, smart_battery_mode_handler)
sasl.registerCommandHandler(main_battery_toggle, 0, main_battery_toggle_handler)
sasl.registerCommandHandler(backup_battery_toggle, 0, backup_battery_toggle_handler)

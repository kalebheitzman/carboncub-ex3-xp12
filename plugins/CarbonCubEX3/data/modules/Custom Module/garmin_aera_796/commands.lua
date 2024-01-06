-- tablet power
function toggle_tablet_power_handler(phase)
    local tablet_power = get(cc_gps_tablet_power)
    if phase == SASL_COMMAND_BEGIN then
        if tablet_power == 1 then
            set(cc_gps_tablet_power, 0)
        else
            set(cc_gps_tablet_power, 1)
        end
    end
    return 1
end

-- tablet visibility
function toggle_tablet_visibility_handler(phase)
    local tablet_visibility = get(cc_gps_tablet_visibility)
    if phase == SASL_COMMAND_BEGIN then
        if tablet_visibility == 1 then
            set(cc_gps_tablet_visibility, 0)
            set(cc_gps_tablet_power, 0)
        else
            set(cc_gps_tablet_visibility, 1)
        end
    end
    return 1
end

-- command handlers
toggle_tablet_power      = sasl.createCommand("cc_ex3/gps/toggle_tablet_power", "Toggle tablet power")
toggle_tablet_visibility = sasl.createCommand("cc_ex3/gps/toggle_tablet_visibility", "Toggle tablet visibility")

-- register command handlers
sasl.registerCommandHandler(toggle_tablet_power, 0, toggle_tablet_power_handler)
sasl.registerCommandHandler(toggle_tablet_visibility, 0, toggle_tablet_visibility_handler)


-- fuel selector off
function fuel_selector_off_handler(phase)
    if phase == SASL_COMMAND_BEGIN then
        set(sim_fuel_tank_selector, 0)
    end
    return 1
end

-- fuel selector left
function fuel_selector_left_handler(phase)
    if phase == SASL_COMMAND_BEGIN then
        set(sim_fuel_tank_selector, 1)
    end
    return 1
end

-- fuel selector both
function fuel_selector_both_handler(phase)
    if phase == SASL_COMMAND_BEGIN then
        set(sim_fuel_tank_selector, 4)
    end
    return 1
end

-- fuel selector right
function fuel_selector_right_handler(phase)
    if phase == SASL_COMMAND_BEGIN then
        set(sim_fuel_tank_selector, 3)
    end
    return 1
end

-- command handlers
fuel_selector_off   = sasl.createCommand("cc_ex3/fuel_selector/off", "Fuel selector off")
fuel_selector_left  = sasl.createCommand("cc_ex3/fuel_selector/left", "Fuel selector left")
fuel_selector_both  = sasl.createCommand("cc_ex3/fuel_selector/both", "Fuel selector both")
fuel_selector_right = sasl.createCommand("cc_ex3/fuel_selector/right", "Fuel selector right")

-- register command handlers
sasl.registerCommandHandler(fuel_selector_off, 0, fuel_selector_off_handler)
sasl.registerCommandHandler(fuel_selector_left, 0, fuel_selector_left_handler)
sasl.registerCommandHandler(fuel_selector_both, 0, fuel_selector_both_handler)
sasl.registerCommandHandler(fuel_selector_right, 0, fuel_selector_right_handler)

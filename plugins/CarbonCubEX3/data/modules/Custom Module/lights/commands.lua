-- commands
sim_landing_light_l_on = sasl.findCommand("sim/lights/landing_01_light_on")
sim_landing_light_r_on = sasl.findCommand("sim/lights/landing_02_light_on")
sim_landing_light_l_off = sasl.findCommand("sim/lights/landing_01_light_off")
sim_landing_light_r_off = sasl.findCommand("sim/lights/landing_02_light_off")

-- timer
pulse_timer = sasl.createTimer()

-- tick landing light switch up
function landing_light_up_handler(phase)
    mode = get(cc_sw_landing_light)
    -- set landing lights to pulse mode
    if phase == SASL_COMMAND_BEGIN and mode == 0 then
        set(cc_sw_landing_light, 1)
        sasl.startTimer(pulse_timer)
    -- turn on landing lights
    elseif phase == SASL_COMMAND_BEGIN and mode == 1 then
        sasl.stopTimer(pulse_timer)
        set(cc_sw_landing_light, 2)
        sasl.commandOnce(sim_landing_light_l_on)
        sasl.commandOnce(sim_landing_light_r_on)
    end
    return 1
end

-- tick landing light switch down
function landing_light_down_handler(phase)
    mode = get(cc_sw_landing_light)
    -- set landing lights to pulse mode
    if phase == SASL_COMMAND_BEGIN and mode == 2 then
        sasl.startTimer(pulse_timer)
        set(cc_sw_landing_light, 1)
    -- turn off landing lights
    elseif phase == SASL_COMMAND_BEGIN and mode == 1 then
        sasl.stopTimer(pulse_timer)
        set(cc_sw_landing_light, 0)
        sasl.commandOnce(sim_landing_light_r_off)
        sasl.commandOnce(sim_landing_light_l_off)
    end
    return 1
end 

-- tick landing light switch up
function map_light_up_handler(phase)
    mode = get(cc_sw_map_light)
    -- set landing lights to pulse mode
    if phase == SASL_COMMAND_BEGIN and mode == 0 then
        set(cc_sw_map_light, 1)
        set(cc_light_map_red, 1)
    -- turn on landing lights
    elseif phase == SASL_COMMAND_BEGIN and mode == 1 then
        set(cc_sw_map_light, 2)
        set(cc_light_map_red, 0)
        set(cc_light_map_white, 1)
    end
    return 1
end

-- tick landing light switch down
function map_light_down_handler(phase)
    mode = get(cc_sw_map_light)
    -- set landing lights to pulse mode
    if phase == SASL_COMMAND_BEGIN and mode == 2 then
        set(cc_sw_map_light, 1)
        set(cc_light_map_white, 0)
        set(cc_light_map_red, 1)
    -- turn off landing lights
    elseif phase == SASL_COMMAND_BEGIN and mode == 1 then
        set(cc_sw_map_light, 0)
        set(cc_light_map_red, 0)
    end
    return 1
end

-- command handlers
landing_light_up = sasl.createCommand("cc_ex3/lights/landing_light_up", "Toggle landing light switch up")
landing_light_down = sasl.createCommand("cc_ex3/lights/landing_light_down", "Toggle landing light switch down")
map_light_up = sasl.createCommand("cc_ex3/lights/map_light_toggle_up", "Toggle map light switch up")
map_light_down = sasl.createCommand("cc_ex3/lights/map_light_toggle_down", "Toggle map light switch down")

-- register command handlers
sasl.registerCommandHandler(landing_light_up, 0, landing_light_up_handler)
sasl.registerCommandHandler(landing_light_down, 0, landing_light_down_handler)
sasl.registerCommandHandler(map_light_up, 0, map_light_up_handler)
sasl.registerCommandHandler(map_light_down, 0, map_light_down_handler)

function update()
    -- get landing light mode
    mode = get(cc_sw_landing_light)

    -- pulse lights logic
    if mode == 1 then
        seconds = sasl.getElapsedSeconds(pulse_timer)
        if math.mod(math.floor(seconds), 2) == 0 then
            sasl.commandOnce(sim_landing_light_l_on)
            sasl.commandOnce(sim_landing_light_r_off)
        else
            sasl.commandOnce(sim_landing_light_l_off)
            sasl.commandOnce(sim_landing_light_r_on)
        end
    end

    updateAll(components)
end
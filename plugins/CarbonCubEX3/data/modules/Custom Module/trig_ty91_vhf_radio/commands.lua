-- sim commands
sim_coarse_up_833 = sasl.findCommand("sim/radios/stby_com1_coarse_up_833")
sim_coarse_up = sasl.findCommand("sim/radios/stby_com1_coarse_up")
sim_coarse_down_833 = sasl.findCommand("sim/radios/stby_com1_coarse_down_833")
sim_coarse_down = sasl.findCommand("sim/radios/stby_com1_coarse_down")
sim_fine_up_833 = sasl.findCommand("sim/radios/stby_com1_fine_up_833")
sim_fine_up = sasl.findCommand("sim/radios/stby_com1_fine_up")
sim_fine_down_833 = sasl.findCommand("sim/radios/stby_com1_fine_down_833")
sim_fine_down = sasl.findCommand("sim/radios/stby_com1_fine_down")

--------------
-- COMMANDS --
--------------

-- com volume down
function com_scroll_left_handler(phase)
    local com1_vol = get(sim_com1_vol)
    local com1_power = get(cc_com1_power)
    if phase == SASL_COMMAND_BEGIN then
        if (com1_vol <= 0) then
            set(cc_com1_power, 0)
            set(sim_com1_vol, 0)
        else
            set(sim_com1_vol, com1_vol-0.075)
        end
    end
    return 1
end

-- com volume up
function com_scroll_right_handler(phase)
    local com1_vol = get(sim_com1_vol)
    local com1_power = get(cc_com1_power)
    if phase == SASL_COMMAND_BEGIN then
        if (com1_power == 0) then 
            set(cc_com1_power, 1)
        end
        if (com1_vol ~= 1 and com1_vol < 1) then
            set(sim_com1_vol, com1_vol+0.075)
        elseif (com1_vol > 1) then
            set(sim_com1_vol, 1)
        end
    end
    return 1
end

-- coarse up
function com_coarse_up_handler(phase)
    local com1_pushstep = get(cc_com1_pushstep)
    if phase == SASL_COMMAND_BEGIN then
        if (com1_pushstep == 0) then
            sasl.commandOnce(sim_coarse_up_833)
        else
            sasl.commandOnce(sim_coarse_up)            
        end
    end
end

-- coarse up
function com_coarse_down_handler(phase)
    local com1_pushstep = get(cc_com1_pushstep)
    if phase == SASL_COMMAND_BEGIN then
        if (com1_pushstep == 0) then
            sasl.commandOnce(sim_coarse_down_833)
        else
            sasl.commandOnce(sim_coarse_down)            
        end
    end

end

-- fine down
function com_fine_up_handler(phase)
    local com1_pushstep = get(cc_com1_pushstep)
    if phase == SASL_COMMAND_BEGIN then
        if (com1_pushstep == 0) then
            sasl.commandOnce(sim_fine_up_833)
        else
            sasl.commandOnce(sim_fine_up)            
        end
    end
end

-- fine down
function com_fine_down_handler(phase)
    local com1_pushstep = get(cc_com1_pushstep)
    if phase == SASL_COMMAND_BEGIN then
        if (com1_pushstep == 0) then
            sasl.commandOnce(sim_fine_down_833)
        else
            sasl.commandOnce(sim_fine_down)            
        end
    end
end

-- pushstep
function com_pushstep_handler(phase)
    local com1_pushstep = get(cc_com1_pushstep)
    if phase == SASL_COMMAND_BEGIN then
        if (com1_pushstep == 0) then
            set(cc_com1_pushstep, 1)
        else
            set(cc_com1_pushstep, 0)
        end
    end
end

-- monitor
function com_monitor_handler(phase)
    local com2_frequency_Mhz = globalPropertyi("sim/cockpit2/radios/actuators/com2_frequency_Mhz")
    local com2_frequency_khz = globalPropertyi("sim/cockpit2/radios/actuators/com2_frequency_khz")
    local com1_standby_frequency_Mhz = get(globalPropertyi("sim/cockpit2/radios/actuators/com1_standby_frequency_Mhz"))
    local com1_standby_frequency_khz = get(globalPropertyi("sim/cockpit2/radios/actuators/com1_standby_frequency_khz"))
    local monitor_com = sasl.findCommand("sim/audio_panel/monitor_audio_com2")

    if phase == SASL_COMMAND_BEGIN then
        set(com2_frequency_Mhz, com1_standby_frequency_Mhz)
        set(com2_frequency_khz, com1_standby_frequency_khz)
        sasl.commandOnce(monitor_com)
    end
end

-- command handlers
com_scroll_left = sasl.createCommand("cc_ex3/radios/com1_vol_down", "COM1 Audio Down")
com_scroll_right = sasl.createCommand("cc_ex3/radios/com1_vol_up", "COM1 Audio Up")
com_pushstep = sasl.createCommand("cc_ex3/radios/com1_pushstep", "COM1 Push Step")
com_coarse_up = sasl.createCommand("cc_ex3/radios/com1_coarse_up", "COM1 Coarse Up")
com_coarse_down = sasl.createCommand("cc_ex3/radios/com1_coarse_down", "COM1 Coarse Down")
com_fine_up = sasl.createCommand("cc_ex3/radios/com1_fine_up", "COM1 Fine Up")
com_fine_down = sasl.createCommand("cc_ex3/radios/com1_fine_down", "COM1 Fine Down")
com_monitor = sasl.createCommand("cc_ex3/radios/com_monitor", "COM monitor")

-- register command handlers
sasl.registerCommandHandler(com_scroll_left, 0, com_scroll_left_handler)
sasl.registerCommandHandler(com_scroll_right, 0, com_scroll_right_handler)
sasl.registerCommandHandler(com_pushstep, 0, com_pushstep_handler)
sasl.registerCommandHandler(com_coarse_up, 0, com_coarse_up_handler)
sasl.registerCommandHandler(com_coarse_down, 0, com_coarse_down_handler)
sasl.registerCommandHandler(com_fine_up, 0, com_fine_up_handler)
sasl.registerCommandHandler(com_fine_down, 0, com_fine_down_handler)
sasl.registerCommandHandler(com_monitor, 0, com_monitor_handler)
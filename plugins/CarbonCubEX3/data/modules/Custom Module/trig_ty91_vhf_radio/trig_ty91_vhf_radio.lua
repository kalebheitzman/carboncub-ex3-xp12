include("../styles.lua")
include("datarefs.lua")
include("commands.lua")

function draw()
    local cc_avionics = globalPropertyi("sim/cockpit2/switches/avionics_power_on")
    local cc_avionics_on = get(cc_avionics)
    local main_battery = get(sim_main_battery)

    local com1_power = get(cc_com1_power)
    local com1_pushstep = get(cc_com1_pushstep)
    local com1_frequency_Mhz = globalPropertyi("sim/cockpit2/radios/actuators/com1_frequency_Mhz")
    local com1_frequency_khz = globalPropertyi("sim/cockpit2/radios/actuators/com1_frequency_khz")
    local com1_standby_frequency_Mhz = globalPropertyi("sim/cockpit2/radios/actuators/com1_standby_frequency_Mhz")
    local com1_standby_frequency_khz = globalPropertyi("sim/cockpit2/radios/actuators/com1_standby_frequency_khz")

    local audio_selection_com2 = get(globalPropertyi("sim/cockpit2/radios/actuators/audio_selection_com2"))

    local band = {}
    band[0] = "8.33k"
    band[1] = "25k"

    if cc_avionics_on == 1 and com1_power == 1 and main_battery == 1 then
        sasl.gl.drawRectangle(0, 0, 453, 244, blue)
        sasl.gl.drawText(font_digital, 430, 150, get(com1_frequency_Mhz) .. "." .. get(com1_frequency_khz), 80, true, false, TEXT_ALIGN_RIGHT, black)
        sasl.gl.drawText(font_digital, 430, 62, get(com1_standby_frequency_Mhz) .. "." .. get(com1_standby_frequency_khz), 80, true, false, TEXT_ALIGN_RIGHT, black)
        sasl.gl.drawText(font_digital, 430, 10, band[com1_pushstep], 45, true, false, TEXT_ALIGN_RIGHT, black)

        if (audio_selection_com2 == 1) then
            sasl.gl.drawRectangle(10, 73, 70, 50, black)
            sasl.gl.drawText(font_digital, 18, 86, "+2", 34, true, false, TEXT_ALIGN_LEFT, blue)
        end
    end
end

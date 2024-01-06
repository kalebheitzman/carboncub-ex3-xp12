--------------
-- COMMANDS --
--------------

local modes = {}
modes[0] = 0
modes[1] = 1
modes[2] = 4
modes[3] = 2
modes[4] = 5

-- xpdr vfr handler
function xpdr_vfr_handler(phase)
    local current_code = get(transponder_code)
    if phase == SASL_COMMAND_BEGIN then
        if (current_code ~= 1200) then
            set(transponder_code, 1200)
            set(cc_xpdr_digits, { 1, 2, 0, 0 })
        elseif(current_code == 1200) then
            set(transponder_code, 7000)
            set(cc_xpdr_digits, { 7, 0, 0, 0 })
        end
    end
    return 1
end

-- xpdr mode left
function xpdr_mode_left_handler(phase)
    transponder_mode = globalPropertyi("sim/cockpit2/radios/actuators/transponder_mode")
    xpdr_mode = get(cc_xpdr_mode)

    if phase == SASL_COMMAND_BEGIN and xpdr_mode > 0 then
        set(transponder_mode, modes[xpdr_mode-1])
        set(cc_xpdr_mode, xpdr_mode-1)
    end
end

-- xpdr mode right
function xpdr_mode_right_handler(phase)
    transponder_mode = globalPropertyi("sim/cockpit2/radios/actuators/transponder_mode")
    xpdr_mode = get(cc_xpdr_mode)

    if phase == SASL_COMMAND_BEGIN and xpdr_mode < 4 then
        set(transponder_mode, modes[xpdr_mode+1])
        set(cc_xpdr_mode, xpdr_mode+1)
    end
end

-- xpdr ident
function xpdr_ident_handler(phase)
    local xpdr_ident = sasl.findCommand("sim/transponder/transponder_ident")
    if phase == SASL_COMMAND_BEGIN then
        sasl.commandOnce(xpdr_ident)
    end
end

-- xpdr enter
function xpdr_enter_handler(phase)
    local code_digit = get(cc_code_digit)
    if phase == SASL_COMMAND_BEGIN then
        if code_digit < 4 then
            set(cc_code_digit, code_digit+1)
        elseif code_digit == 4 then
            set(cc_code_digit, 0)
            local xpdr_code = get(cc_xpdr_digits)
            local new_code = xpdr_code[1]..xpdr_code[2]..xpdr_code[3]..xpdr_code[4]
            set(transponder_code, new_code)
        end
    end
end

-- xpdr code up
function xpdr_code_up_handler(phase)
    local code_digit = get(cc_code_digit)
    local xpdr_codes = get(cc_xpdr_digits)

    if phase == SASL_COMMAND_BEGIN and code_digit ~= 0 then
        if (xpdr_codes[code_digit] < 7) then
            xpdr_codes[code_digit] = xpdr_codes[code_digit]+1
            set(cc_xpdr_digits, xpdr_codes)
        else
            xpdr_codes[code_digit] = 0
            set(cc_xpdr_digits, xpdr_codes)
        end
    end
end

-- xpdr code down
function xpdr_code_down_handler(phase)
    local code_digit = get(cc_code_digit)
    local xpdr_codes = get(cc_xpdr_digits)

    if phase == SASL_COMMAND_BEGIN and code_digit ~= 0 then
        if (xpdr_codes[code_digit] > 0) then
            xpdr_codes[code_digit] = xpdr_codes[code_digit]-1
            set(cc_xpdr_digits, xpdr_codes)
        else
            xpdr_codes[code_digit] = 7
            set(cc_xpdr_digits, xpdr_codes)
        end
    end
end

-- command handlers
xpdr_vfr        = sasl.createCommand("cc_ex3/transponder/vhr_code", "Set default vfr xpdr code")
xpdr_mode_left  = sasl.createCommand("cc_ex3/transponder/mode_left", "Turn mode right")
xpdr_mode_right = sasl.createCommand("cc_ex3/transponder/mode_right", "Turn mode left")
xpdr_ident      = sasl.createCommand("cc_ex3/transponder/ident", "XPDR Ident")
xpdr_enter      = sasl.createCommand("cc_ex3/transponder/enter", "XPDR Enter button")
xpdr_code_up    = sasl.createCommand("cc_ex3/transponder/code_up", "XPDR code up")
xpdr_code_down  = sasl.createCommand("cc_ex3/transponder/code_down", "XPDR code down")

-- register command handlers
sasl.registerCommandHandler(xpdr_vfr, 0, xpdr_vfr_handler)
sasl.registerCommandHandler(xpdr_mode_left, 0, xpdr_mode_left_handler)
sasl.registerCommandHandler(xpdr_mode_right, 0, xpdr_mode_right_handler)
sasl.registerCommandHandler(xpdr_ident, 0, xpdr_ident_handler)
sasl.registerCommandHandler(xpdr_enter, 0, xpdr_enter_handler)
sasl.registerCommandHandler(xpdr_code_up, 0, xpdr_code_up_handler)
sasl.registerCommandHandler(xpdr_code_down, 0, xpdr_code_down_handler)

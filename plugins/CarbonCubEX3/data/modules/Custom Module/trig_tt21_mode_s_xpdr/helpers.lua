-------------
-- HELPERS --
-------------

function xpdr_table()
    local code = get(sim_transponder_code)
    local code_s = tostring(code)
    xpdr_t = {}
    for num in code_s:gmatch('%d') do
        xpdr_t[#xpdr_t+1]=tonumber(num)
    end
    return xpdr_t
end

-- get flight level
function flight_level(altitude) 
    local fl = math.floor(altitude/100)
    if string.len(fl) == 1 then
        return "FL00" .. fl
    elseif string.len(fl) == 2 then
        return "FL0" .. fl
    else
        return "FL" .. fl
    end
end

-- code numbers
function code_number(pos)
    local code_digit = get(cc_code_digit)
    local xpdr_codes = get(cc_xpdr_digits)
    
    dpos = {}
    dpos[1] = 160
    dpos[2] = 240
    dpos[3] = 320
    dpos[4] = 400

    xpos = dpos[pos]
    
    local digit_color = black

    if (code_digit == pos) then
        sasl.gl.drawRectangle(xpos-40, 120, 78, 110, black)
        digit_color = blue
    end

    sasl.gl.drawText(font_digital, xpos, 135, xpdr_codes[pos], 110, true, false, TEXT_ALIGN_CENTER, digit_color)

end
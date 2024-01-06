-------------------
-- HELPER FUNCTIONS
-------------------

-- format time string
function format_time(hours, minutes, seconds)
    -- hours
    h = get(hours)
    if (string.len(h) == 1) then
        h = 0 .. h
    end

    -- minutes
    m = get(minutes)
    if (string.len(m) == 1) then
        m = 0 .. m
    end

    -- seconds
    s = get(seconds)
    if (string.len(s) == 1) then
        s = 0 .. s
    end

    return h .. ":" .. m .. ":" .. s
end

-- celcius to farenheit
function c_to_f(num)
    return math.floor((num*1.8)+32)
end

-- kilogram to lb
function kgs_to_lbs(num)

end

-- round2 number
function round2(num, numDecimalPlaces)
    return string.format("%." .. (numDecimalPlaces) .. "f", num)
end

-- fuel flow
function fuel_flow(kg_per_sec)
    local kgh = kg_per_sec*60*60
    local gph = kgh/2.2046

    return round2(gph, 1)
end

-- x,y triangle point
-- i1, i2 length of indicator bar
-- minv minimum value of indicator
-- maxv maximum value of indicator
-- val current value of indicator
function indicator_triangle(y, i1, i2, minv, maxv, val)
    local length = i2-i1
    local ratio = val/maxv
    local x = math.floor((ratio*length)+i1)
    sasl.gl.drawTriangle(x+21, y+23, x, y-3, x-19, y+23, black)
    sasl.gl.drawTriangle(x+15, y+20, x, y, x-15, y+20, blue)
end
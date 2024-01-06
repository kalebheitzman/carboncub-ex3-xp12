-- round a number to specified decimal places
function round2(num, numDecimalPlaces)
    return string.format("%." .. (numDecimalPlaces) .. "f", num)
end

-- convert knots to mph
function kts_to_mph(num)
    return num*1.151
end

-- get lua table length
function tablelength(t)
    local count = 0
    for _ in pairs(t) do count = count + 1 end
    return count
end

-- dump table
function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
end

function split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end
function math.round(number)
    if number >= 0 then
        return math.floor(number + 0.5)
    end

    return math.ceil(number - 0.5)
end

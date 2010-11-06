function ColoredString( ... )
    local args = { ... }
    for i=1, #args do
        if type( args[ i ] ) == "number" then -- Color!
            -- TODO: Check to make sure number is within limits
            args[ i ] = string.format( "§%x", args[ i ] )
        end
    end
    return table.concat( args, "" )
end

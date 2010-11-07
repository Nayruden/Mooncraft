--[[
    Function: ParseArgs

    This is similar to splitting a string except that it will not split up words within quotation
    marks.

    Parameters:

        args - The input *string* to split from.

    Returns:

        1 - A *table* containing the individual arguments.
        2 - A *boolean* stating whether or not mismatched quotes were found.

    Example:

        :ParseArgs( 'This is a "Cool sentence to" make "split up"' )

        returns...

        :{ "This", "is", "a", "Cool sentence to", "make", "split up" }

    Notes:

        * Mismatched quotes will result in having the last quote grouping the remaining input into
            one argument.
        * Arguments outside of quotes are trimmed, while what's inside quotes is not trimmed at
            all.

    Revisions:

        v1.00 - Initial.
]]
function ParseArgs( args )
    local argv = List()
    local curpos = 1 -- Our current position within the string
    local in_quote = false -- Is the text we're currently processing in a quote?
    local args_len = args:len()

    while curpos <= args_len or in_quote do
        local quotepos = args:find( '"', curpos, true )

        -- The string up to the quote, the whole string if no quote was found
        local prefix = args:sub( curpos, (quotepos or 0) - 1 )
        if not in_quote then
            local trimmed = prefix:strip()
            if trimmed ~= "" then -- Something to be had from this...
                local t = trimmed:split()
                argv:extend( t, true )
            end
        else
            table.insert( argv, prefix )
        end

        -- If a quote was found, reduce our position and note our state
        if quotepos ~= nil then
            curpos = quotepos + 1
            in_quote = not in_quote
        else -- Otherwise we've processed the whole string now
            break
        end
    end

    return argv, in_quote
end

function StripFirstWord( str )
    return (str:gsub( "^%S-%s+", "" )) -- Strip first word and spacing
end

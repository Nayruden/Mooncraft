MOD = RegisterMod( "Base", "Nayruden", "0.1-Alpha" )

local function FetchMod( player, args )
    local mods = MOD:GetMods()
    local modname = StripFirstWord( args ):lower()
    if not mods[ modname ] then
        player:SendMessage( "Unknown mod: " .. modname )
        return
    end

    return mods[ modname ]
end

MOD:AddServerCommand( "stopmod", function( player, args, argv )
    local mod = FetchMod( player, args )
    if not mod then return end

    if mod.modname == "Base" then
        player:SendMessage( "the base mod cannot be stopped" )
        return
    end

    mod:Stop()
end )

MOD:AddServerCommand( "startmod", function( player, args, argv )
    local mod = FetchMod( player, args )
    if not mod then return end

    mod:Start()
end )


MOD:AddServerCommand( "reloadmod", function( player, args, argv )
    local mod = FetchMod( player, args )
    if not mod then return end

    mod:Reload()
end )

MOD:AddServerCommand( "listmods", function( player, args, argv )
    local mods = MOD:GetMods()
    local template = "%-16s %-12s %s"
    player:SendMessage( template:format( "Name", "Version", "Status" ) )
    for key, moddata in pairs( mods ) do
        player:SendMessage( template:format( moddata.modname, moddata.version, moddata.stopped and "Stopped" or "Running" ) )
    end
end )

MOD:AddServerCommand( "luarun", function( player, args, argv )
    local code = StripFirstWord( args )
    local collecting_results = false
    if code:sub( 1, 1 ) == "=" then
        code = "return " .. code:sub( 2 )
        collecting_results = true
    end

    local chunk, err = loadstring( code )
    if not chunk then
        player:SendMessage( err )
    else
        local results = { pcall( chunk ) }
        if not results[ 1 ] then
            player:SendMessage( results[ 2 ] )
        elseif collecting_results then
            for i=1, #results do
                if type( results[ i ] ) == "userdata" then
                    results[ i ] = results[ i ]:toString()
                else
                    results[ i ] = tostring( results[ i ] )
                end
            end
            player:SendMessage( table.concat( results, "\t", 2 ) )
        end
    end
end )

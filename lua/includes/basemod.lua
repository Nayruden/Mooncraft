MOD = RegisterMod( "Base", "Nayruden", "0.1-Alpha" )

local function FetchMod( player, args )
    local mods = MOD:GetMods()
    local modname = args:gsub( "^.-%s+", "" ) -- Strip first word and spacing
    if not mods[ modname ] then
        player:SendMessage( "Unknown mod: " .. modname )
        return
    end

    return mods[ modname ]
end

MOD:AddServerCommand( "stopmod", function( player, args, argv )
    local mod = FetchMod( player, args )
    if not mod then return end

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

MOD:AddServerCommand( "luarun", function( player, args, argc )
    args = args:gsub( "^luarun%s", "" )
    loadstring( args )()
end )

MOD = RegisterMod( "Base", "Nayruden", ".1 alpha" )

MOD:AddServerCommand( "reloadmod", function( player, args, argv )
    if #argv < 2 then
        print( "Usage: reload <mod>" )
        return
    end

    local mods = MOD:GetMods()
    local modname = args:gsub( "^.-%s+", "" ) -- Strip first word and spacing
    if not mods[ modname ] then
        print( "Unknown mod" )
        return
    end

    print( "Reloading..." )
    mods[ modname ]:Reload()
end )

MOD:AddServerCommand( "listmods", function( player, args, argv )
    local mods = MOD:GetMods()
    local template = "%-16s %-8s %s"
    print( template:format( "Name", "Version", "Status" ) )
    for key, moddata in pairs( mods ) do
        print( template:format( moddata.modname, moddata.version, moddata.stopped and "Stopped" or "Running" ) )
    end
end )

MOD:AddServerCommand( "luarun", function( player, args, argc )
    args = args:gsub( "^luarun%s", "" )
    loadstring( args )()
end )

MOD = RegisterMod( "Base", "Nayruden", ".00000001 alpha" )

MOD:AddServerCommand( "reloadmod", function( player, args )
    local space = args:find( " " )
    if not space then
        print( "Usage: reload <mod>" )
        return
    end

    local mods = MOD:GetMods()
    local modname = args:sub( space+1 ):strip():lower()
    if not mods[ modname ] then
        print( "Unknown mod" )
        return
    end

    print( "Reloading..." )
    mods[ modname ]:Reload()
end )

MOD:AddServerCommand( "listmods", function( player, args )
    local mods = MOD:GetMods()
    print( "boo" )
    for key, moddata in pairs( mods ) do
        print( moddata.modname )
    end
end )

MOD:AddServerCommand( "luarun", function( player, args )
    args = args:gsub( "^luarun%s", "" )
    loadstring( args )()
end )
-- TODO: Clear up command false positive unknown crap

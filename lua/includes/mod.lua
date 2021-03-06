local function SortHooks( a, b )
    return a.priority < b.priority
end

local function AddHook( mod, hook, priority, fn )
    local current_hooks = hooks.GetHooks()[ hook ]
    if type( priority ) == "function" then
        fn = priority
        priority = nil
    end

    table.insert( current_hooks, { mod=mod, priority=priority or hooks.Normal, fn=fn } )
    table.sort( current_hooks, SortHooks )
end

-- Called when trying to access keys that don't exist in mod (we need to inject hooks)
local function index( mod, key )
    if key:startswith( "On" ) then
        if hooks.HookExists( key ) then -- Hook
            local current_hooks = hooks.GetHooks()[ key ]
            return function( self, priority, fn )
                AddHook( self, key, priority, fn )
            end
        else
            print( "WARNING: MOD." .. key .. " was used. Did you mean to use a hook?" )
        end
    end
end
local mods = {}
local server_commands = {}
local client_commands = {}
local Mod = class()
Mod.__name = "Mod" -- Since we're localizing, we need to specify name explicitly (Would use class.Mod() above otherwise)
Mod.catch( index )

function Mod:_init( modname, author, version, filepath )
    mods[ modname:lower() ] = self
    self.modname = modname
    self.author = author
    self.version = version
    self.filepath = filepath

    if not filepath then
        local info = debug.getinfo( 5, "S" )
        if not info or not info.source then
            print( "WARNING: Unable to determine file to run for reloads for mod " .. modname )
        else
            self.filepath = info.source:sub( 2 )
        end
    end
end

function Mod:Stop()
    if self.stopped then return end
    self.stopped = true

    for name, list in pairs( hooks.GetHooks() ) do
        local i = 1
        while i <= #list do
            if list[ i ].mod == self then
                table.remove( list, i )
            else
                i = i + 1
            end
        end
    end

    for name, data in pairs( server_commands ) do
        if data.mod == self then
            server_commands[ name ] = nil
        end
    end

    for name, data in pairs( client_commands ) do
        if data.mod == self then
            client_commands[ name ] = nil
        end
    end
end

function Mod:Start()
    if not self.stopped then return end
    self.stopped = nil

    dofile( self.filepath )
end

function Mod:Reload()
    self:Stop()
    self:Start()
end

local function OnServerCommand( player, args )
    local argv = ParseArgs( args )
    if server_commands[ argv[ 1 ] ] then
        server_commands[ argv[ 1 ] ].fn( player, args, argv ) -- TODO: pcall
        return true -- Block other hooks
    end
end
AddHook( nil, "OnServerCommand", OnServerCommand )

local function OnClientCommand( player, args )
    local argv = ParseArgs( args )
    if client_commands[ argv[ 1 ] ] then
        client_commands[ argv[ 1 ] ].fn( player, args, argv )
        return true -- Block other hooks
    end
end
AddHook( nil, "OnClientCommand", OnClientCommand )

function Mod:AddServerCommand( command, fn )
    server_commands[ command ] = { fn=fn, mod=self }
end

function Mod:AddClientCommand( command, fn )
    client_commands[ command ] = { fn=fn, mod=self }
end

function Mod.GetMods()
    return mods
end

function RegisterMod( modname, ... )
    return mods[ modname:lower() ] or Mod( modname, ... ) -- See if mod already exists first
end

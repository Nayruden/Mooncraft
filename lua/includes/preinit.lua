package.path = package.path .. ";./lua/includes/?.lua;./lua/includes/?/init.lua"

Server = luajava.bindClass( "Server" )
PlayerManager = luajava.bindClass( "PlayerManager" )

require("pl")
stringx.import()


local table = table
local print = print
local pcall = pcall

module( "hooks" )

local hook_names = {}
local hooks = {}

PreHook = 1
High = 2
Normal = 3
Low = 4
PostHook = 5

function Call( hook, ... )
    print( "Hook called:", hook, ... )
    local list = hooks[ hook ]
    local ret
    for i=1, #list do
        data = list[ i ]
        if ret == nil or data.priority == PostHook then -- Ignore everything but post hooks if ret is set
            local success, new_ret = pcall( list[ i ].fn, ... )
            if not success then
                print( "Error in hook " .. hook .. ": " .. new_ret ) -- TODO: Standardize? Print trace?
            elseif new_ret ~= nil then
                -- Ignore if it's coming from pre or post hook
                if data.priority ~= PreHook and data.priority ~= PostHook then
                    ret = new_ret
                end
            end
        end
    end

    return ret
end

function RegisterHookName( hook )
    print( "hook registered", hook )
    hook_names[ hook ] = true
    hooks[ hook ] = {}
end

function HookExists( hook )
    if hook_names[ hook ] then return true end
    return false
end

function GetHooks()
    return hooks
end

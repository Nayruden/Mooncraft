package.path = package.path .. ";./lua/includes/?.lua;./lua/?"
local class = require( "pl.class" ).class

local function SortHooks( a, b )
	return a.priority < b.priority
end

-- Called when trying to access keys that don't exist in mod (inject hooks)
local function index( mod, key )
	if hooks.HookExists( key ) then -- Hook
		local current_hooks = hooks.GetHooks()[ key ]
		return function( self, priority, fn )
			if type( priority ) == "function" then
				fn = priority
				priority = nil
			end

			table.insert( current_hooks, { modname=self.modname, priority=priority or hooks.Normal, fn=fn } )
			table.sort( current_hooks, SortHooks )
		end
	end
end
local mods = {}
class.Mod()
Mod.catch( index )

function Mod:_init( modname, author, version )
	mods[ modname ] = { modname=name, author=author, version=version }
end

local table = table
local print = print

module( "hooks" )

local hook_names = {}
local hooks = {}

PreHook = 1
High = 2
Normal = 3
Low = 4
PostHook = 5

function Call( hook, ... )
	local list = hooks[ hook ]
	local ret
	for i=1, #list do
		data = list[ i ]
		if ret == nil or data.priority == Priority.PostHook then -- Ignore everything but post hooks if ret is set
			local new_ret = list[ i ].fn( ... )
			if new_ret ~= nil then
				-- Ignore if it's coming from pre or post hook
				if data.priority ~= Priority.PreHook and data.priority ~= Priority.PostHook then
					ret = new_ret
				end
			end
		end
	end

	return ret
end

function RegisterHookName( hook )
	print( hook, " hook registered" )
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

local awesome_mod = RegisterMod( "Awesome Sauce", "Nayruden", ".00000001 alpha" )

awesome_mod:OnPlayerConnect( function( player )
    local playername = player:GetName()
    player:SendMessage( ColoredString( "Hello, ", Color.Cyan, playername, Color.White, " welcome to our ", Color.Orange, "server!" ) )
end )

awesome_mod:OnPlayerChat( function( player, msg )
	if msg == "kick me" then
	    player:Kick( "You asked for it!" )
	    -- TODO: Logging on kick
	end
end)

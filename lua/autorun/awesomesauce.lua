local awesome_mod = RegisterMod( "Awesome Sauce", "Nayruden", ".2 beta" )

awesome_mod:OnPlayerConnect( function( player )
    local playername = player:GetName()
    player:SendMessage( ColoredString( "Hello, ", Color.Cyan, playername, Color.White, " welcome to our ", Color.Orange, "server!" ) )
end )

awesome_mod:AddClientCommand( "boo", function( player, args, argv )
    local playername = player:GetName()
    Server:BroadcastMessage( ColoredString( "Eek! ", Color.Cyan, playername, Color.White, " is so scary!" ) )
end )

awesome_mod:OnPlayerChat( function( player, msg )
	if msg == "kick me" then
	    player:Kick( "You asked for it!" )
	end
end)

-- TODO: Some sort of battery of tests to ensure API consistency across versions?

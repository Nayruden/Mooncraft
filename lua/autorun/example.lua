MOD = RegisterMod( "Example", "Nayruden", "0.1-Alpha" )

MOD:OnInit( function()
    Server:LogInfo( "Example mod has started" )
    Server:LogWarning( "Example mod may be too awesome for your server" )
end)

MOD:OnPlayerConnect( function( player )
    local playername = player:GetName()
    player:SendMessage( ColoredString( "Hello, ", Color.Cyan, playername, Color.White, " welcome to our ", Color.Orange, "server!" ) )
end )

MOD:AddClientCommand( "boo", function( player, args, argv )
    local playername = player:GetName()
    Server:BroadcastMessage( ColoredString( "Eek! ", Color.Cyan, playername, Color.White, " is so scary!" ) )
end )

MOD:OnPlayerChat( function( player, msg )
	if msg == "kick me" then
	    player:Kick( "You asked for it!" )
	end
end)

-- TODO: Some sort of battery of tests to ensure API consistency across versions?

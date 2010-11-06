local awesome_mod = Mod( "Awesome Sauce", "Nayruden", ".00000001 alpha" )

awesome_mod:OnPlayerConnect( function( player )
	print( "player has awesomely joined: ", player:GetName() )
	player:SendMessage( "HOWDY PARTNER" )
end )

awesome_mod:OnPlayerChat( function( player, msg )
	print( "Player", player:GetName(), "said", msg )
end)
local pairs = pairs

module( "slot" )

local list = {}
list[ 100 ] = "Boots"
list[ 101 ] = "Leggings"
list[ 102 ] = "Breatplate"
list[ 103 ] = "Helmet"

list[ 80 ] = "Top Left"
list[ 81 ] = "Top Right"
list[ 82 ] = "Bottom Left"
list[ 83 ] = "Bottom Right"

local reverse_list = {}
for k, v in pairs( list ) do
    reverse_list[ v ] = k
end

function FromName( name )
    return reverse_list[ name ]
end

function ToName( id )
    return list[ id ]
end

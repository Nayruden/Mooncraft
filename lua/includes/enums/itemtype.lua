module( "ItemType" )

-- An order-sensitive list of blocktypes first
local list = {
    "Iron Spade",               -- 0
    "Iron Pickaxe",
    "Iron Axe",
    "Flint and Steel",
    "Apple",
    "Bow",
    "Arrow",
    "Coal",
    "Diamond",
    "Iron Ingot",
    "Gold Ingot",               -- 10
    "Iron Sword",
    "Wooden Sword",
    "Wooden Spade",
    "Wooden Pickaxe",
    "Wooden Axe",
    "Stone Sword",
    "Stone Spade",
    "Stone Pickaxe",
    "Stone Axe",
    "Diamond Sword",            -- 20
    "Diamond Spade",
    "Diamond Pickaxe",
    "Diamond Axe",
    "Stick",
    "Bowl",
    "Mushroom Soup",
    "Gold Sword",
    "Gold Spade",
    "Gold Pickaxe",
    "Gold Axe",                 -- 30
    "String",
    "Feather",
    "Gunpowder",
    "Wooden Hoe",
    "Stone Hoe",
    "Iron Hoe",
    "Diamond Hoe",
    "Gold Hoe",
    "Seeds",
    "Wheat",                    -- 40
    "Bread",
    "Leather Helmet",
    "Leather Chestplate",
    "Leather Leggings",
    "Leather Boots",
    "Chainmail Helmet",
    "Chainmail Chestplate",
    "Chainmail Leggings",
    "Chainmail Boots",
    "Iron Helmet",              -- 50
    "Iron Chestplate",
    "Iron Leggings",
    "Iron Boots",
    "Diamond Helmet",
    "Diamond Chestplate",
    "Diamond Leggings",
    "Diamond Boots",
    "Gold Helmet",
    "Gold Chestplate",
    "Gold Leggings",            -- 60
    "Gold Boots",
    "Flint",
    "Pork",
    "Grilled Pork",
    "Paintings",
    "Golden Apple",
    "Sign",
    "Wooden Door",
    "Bucket",
    "Water Bucket",             -- 70
    "Lava Bucket",
    "Minecart",
    "Saddle",
    "Iron Door",
    "Redstone",
    "Snowball",
    "Boat",
    "Leather",
    "Milk Bucket",
    "Clay Brick",               -- 80
    "Clay Balls",
    "Reed",
    "Paper",
    "Book",
    "Slime Ball",
    "Storage Minecart",
    "Powered Minecart",
    "Egg",
    "Compass",
    "Fishing Rod",              -- 90
    "Watch",
    "Lightstone Dust",
    "Raw Fish",
    "Cooked Fish",
}

-- The oddballs
list[2000] = "Gold Record"
list[2001] = "Green Record"

local reverse_list = {}
for i=1, #list do
    if list[ i ] then
        reverse_list[ list[ i ] ] = i
    end
end
reverse_list[ list[ 2000 ] ] = 2000
reverse_list[ list[ 2001 ] ] = 2001

function FromName( name )
    return reverse_list[ name ] + 256
end

function ToName( id )
    return list[ id - 256 ]
end

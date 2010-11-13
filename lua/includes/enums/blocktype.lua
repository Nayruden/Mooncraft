module( "BlockType" )

-- An order-sensitive list of blocktypes first
local list = {
    "Air",                  -- 0
    "Stone",
    "Grass",
    "Dirt",
    "Cobblestone",
    "Wood",
    "Sapling",
    "Bedrock",
    "Water",
    "Stationary Water",
    "Lava",                 -- 10
    "Stationary Lava",
    "Sand",
    "Gravel",
    "Gold Ore",
    "Iron Ore",
    "Coal Ore",
    "Log",
    "Leaves",
    "Sponge",
    "Glass",                -- 20
    "Wool",
    nil,                    -- Unused
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,                    -- 30
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    "Yellow Flower",
    "Red Flower",
    "Brown Mushroom",
    "Red Mushroom",         -- 40
    "Gold Block",
    "Iron Block",
    "Double Step",
    "Step",
    "Brick",
    "TNT",
    "Bookcase",
    "Mossy Cobblestone",
    "Obsidian",
    "Torch",                -- 50
    "Fire",
    "Mob Spawner",
    "Wooden Stairs",
    "Chest",
    "Redstone Wire",
    "Diamond Ore",
    "Diamon Block",
    "Workbench",
    "Crops",
    "Soil",                 -- 60
    "Furnace",
    "Burning Furnace",
    "Sign",
    "Wooden Door",
    "Ladder",
    "Minecart Tracks",
    "Cobblestone Stairs",
    "Wall Sign",
    "Lever",
    "Stone Pressure Plate", -- 70
    "Iron Door",
    "Wooden Pressure Plate",
    "Redstone Ore",
    "Glowing Redstone Ore",
    "Unlit Redstone Torch",
    "Lit Redstone Torch",
    "Stone Button",
    "Snow",
    "Ice",
    "Snow Block",           -- 80
    "Cactus",
    "Clay",
    "Reed",
    "Jukebox",
    "Fence",
    "Pumpkin",
    "Blood Stone",
    "Slow Sand",
    "Lightstone",
    "Portal",               -- 90
    "Jack-O-Lantern",
}

local reverse_list = {}
for i=1, #list do
    if list[ i ] then
        reverse_list[ list[ i ] ] = i
    end
end

function FromName( name )
    return reverse_list[ name ]
end

function ToName( id )
    return list[ id ]
end

function IsBreakable( id )
    return not (
        id == 0 or (id >= 7 and id <= 11) or id == 46 or id == 51 or id == 90
    )
end

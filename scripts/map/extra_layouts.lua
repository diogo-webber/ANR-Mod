local StaticLayout = require("map/static_layout")

local PLACE_MASK = _G.PLACE_MASK
local LAYOUT_POSITION = _G.LAYOUT_POSITION
local LAYOUT = _G.LAYOUT
local GROUND = _G.GROUND
local PickSomeWithDups = _G.PickSomeWithDups

--[[
        Leo:
                The original layouts file is "map/layouts", that is
                required by "map/object_layout".

                Object_layout is required by some files:
                    - map/forest_map.lua
                    - map/graphnode.lua
                    - map/network.lua
                    - map/room_functions.lua

                I think we need to add these "Extra_Layouts" to map/layouts,
                but idk, you probably will know what to do. :P
]]

local Extra_Layouts =
{
    --------------------------------------------------------------------------------
    -- DST
    --------------------------------------------------------------------------------

    ["MooseNest"] = StaticLayout.Get("map/static_layouts/moose_nest",
    {
        areas =
        {
            randomtree = function(area) return PickSomeWithDups(1, {"evergreen", "deciduoustree"}) end,
        },
    }),

    ["DragonflyArena"] = StaticLayout.Get("map/static_layouts/dragonfly_arena",
    {
            start_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
            fill_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
            layout_position = LAYOUT_POSITION.CENTER,
    }),

    --["BlueMushyStart"] = StaticLayout.Get("map.static_layouts/blue_mushy_entrance"),
--[[
    ["AntlionSpawningGround"] =
    {
        type = LAYOUT.STATIC,
        layout =
        {
            antlion_spawner = {{x=0, y=0}},
        },
        ground_types = {GROUND.DESERT_DIRT, GROUND.DIRT},
        ground =
            {
                {1, 2, 1, 2},
                {1, 1, 1, 2},
                {1, 1, 1, 1},
                {2, 1, 2, 1},
            },
        start_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
        fill_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
        layout_position = LAYOUT_POSITION.CENTER,
    },

    --["Terrarium_Forest_Spiders"] = StaticLayout.Get("map/static_layouts/terrarium_forest_spiders"),
    --["Terrarium_Forest_Pigs"] = StaticLayout.Get("map/static_layouts/terrarium_forest_pigs"),
    --["Terrarium_Forest_Fire"] = StaticLayout.Get("map/static_layouts/terrarium_forest_fire"),

    --------------------------------------------------------------------------------
    -- ANR - A New Reign
    --------------------------------------------------------------------------------

    ["MoonbaseOne"] = StaticLayout.Get("map/static_layouts/moonbaseone",
    {
            start_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
            fill_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
            layout_position = LAYOUT_POSITION.CENTER,
            disable_transform = true
    }),

    ["StagehandGarden"] = StaticLayout.Get("map/static_layouts/stagehandgarden"),

    ["Sculptures_1"] = StaticLayout.Get("map/static_layouts/sculptures_1"),

    ["Sculptures_2"] = StaticLayout.Get("map/static_layouts/sculptures_2",
    {
        areas =
        {
            sculpture_random = function(area) return PickSomeWithDups(1, {"statue_marble_muse", "statue_marble_pawn", "sculpture_knight", "sculpture_bishop"}) end,
        },
    }),

    ["Sculptures_3"] = StaticLayout.Get("map/static_layouts/sculptures_3"),
    ["Sculptures_4"] = StaticLayout.Get("map/static_layouts/sculptures_4"),

    ["Sculptures_5"] = StaticLayout.Get("map/static_layouts/sculptures_5",
    {
        areas =
        {
            sculpture_random = function(area) return (math.random(2) == 1) and PickSomeWithDups(1, {"statue_marble", "marblepillar", "sculpture_knight", "sculpture_bishop"}) or {nil} end,
        },
    }),

    ["Oasis"] = StaticLayout.Get("map/static_layouts/oasis",
    {
        start_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
        fill_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
        layout_position = LAYOUT_POSITION.CENTER,
        disable_transform = true
    }),]]
}
return Extra_Layouts
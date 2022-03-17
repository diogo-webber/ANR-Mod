local function RGB(r, g, b)
    return { r / 255, g / 255, b / 255, 1 }
end

_G.DEGREES = PI/180

_G.DEFAULT_PLAYER_COLOUR = RGB(153, 153, 153) -- GREY

_G.RATE_SCALE =
{
    NEUTRAL = 0,
    INCREASE_HIGH = 1,
    INCREASE_MED = 2,
    INCREASE_LOW = 3,
    DECREASE_HIGH = 4,
    DECREASE_MED = 5,
    DECREASE_LOW = 6,
}

_G.MATERIALS =
{
    WOOD = "wood",
    STONE = "stone",
    HAY = "hay",
    THULECITE = "thulecite",
    GEM = "gem",
    GEARS = "gears",
    MOONROCK = "moonrock",
    ICE = "ice",
    SCULPTURE = "sculpture",
    FOSSIL = "fossil",
    MOON_ALTAR = "moon_altar",
}

_G.FOODTYPE =
{
    GENERIC = "GENERIC",
    MEAT = "MEAT",
    VEGGIE = "VEGGIE",
    ELEMENTAL = "ELEMENTAL",
    GEARS = "GEARS",
    HORRIBLE = "HORRIBLE",
    INSECT = "INSECT",
    SEEDS = "SEEDS",
    BERRY = "BERRY", --hack for smallbird; berries are actually part of veggie
    RAW = "RAW", -- things which some animals can eat off the ground, but players need to cook
    BURNT = "BURNT", --For lavae.
    ROUGHAGE = "ROUGHAGE",
	WOOD = "WOOD",
    GOODIES = "GOODIES",
    MONSTER = "MONSTER", -- Added in for woby, uses the secondary foodype originally added for the berries
}

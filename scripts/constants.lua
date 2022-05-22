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

_G.FUELTYPE =
{
    BURNABLE = "BURNABLE",
    USAGE = "USAGE",
    MAGIC = "MAGIC", --V2C: use this one if u don't want there to be any associated fuel
    CAVE = "CAVE",
    NIGHTMARE = "NIGHTMARE",
    ONEMANBAND = "ONEMANBAND",
    PIGTORCH = "PIGTORCH",
    CHEMICAL = "CHEMICAL",
    WORMLIGHT = "WORMLIGHT",
}

_G.SPECIAL_EVENTS =
{
    NONE = "none",
    HALLOWED_NIGHTS = "hallowed_nights",
    WINTERS_FEAST = "winters_feast",
	CARNIVAL = "crow_carnival",
    YOTG = "year_of_the_gobbler",
    YOTV = "year_of_the_varg",
    YOTP = "year_of_the_pig",
    YOTC = "year_of_the_carrat",
    YOTB = "year_of_the_beefalo",
}
_G.WORLD_SPECIAL_EVENT = _G.SPECIAL_EVENTS.WINTERS_FEAST

_G.MAX_WRITEABLE_LENGTH = 200

_G.CHARACTER_INGREDIENT =
{
    --NOTE: Value is used as key for NAME string and inventory image
    HEALTH = "decrease_health",
    MAX_HEALTH = "half_health",
    SANITY = "decrease_sanity",
    MAX_SANITY = "half_sanity",
    OLDAGE = "decrease_oldage",
}

--Character ingredient amounts must be multiples of 5
_G.CHARACTER_INGREDIENT_SEG = 5

_G.TECH_INGREDIENT =
{
    --NOTE: Value is used as key for NAME string and inventory image
    --NOTE: Must be name of the tech + "_material"
    SCULPTING = "sculpting_material",
}

local seg_time = 30
local total_day_time = seg_time*16

local day_segs = 10
local dusk_segs = 4
local night_segs = 2

--default day composition. changes in winter, etc
local day_time = seg_time * day_segs
local dusk_time = seg_time * dusk_segs
local night_time = seg_time * night_segs

local wilson_attack = 34
local wilson_health = 150
local calories_per_day = 75

local wilson_attack_period = .5
-----------------------

local perish_warp = 1

-----------------------------------------------------------------------

TUNING.HAUNT_COOLDOWN_TINY = 1
TUNING.HAUNT_COOLDOWN_SMALL = 3
TUNING.HAUNT_COOLDOWN_MEDIUM = 5
TUNING.HAUNT_COOLDOWN_LARGE = 7
TUNING.HAUNT_COOLDOWN_HUGE = 10

TUNING.HAUNT_CHANCE_ALWAYS = 1
TUNING.HAUNT_CHANCE_OFTEN = .75
TUNING.HAUNT_CHANCE_HALF = .5
TUNING.HAUNT_CHANCE_OCCASIONAL = .25
TUNING.HAUNT_CHANCE_RARE = .1
TUNING.HAUNT_CHANCE_VERYRARE = .005
TUNING.HAUNT_CHANCE_SUPERRARE = .001

TUNING.HAUNT_TINY = 1
TUNING.HAUNT_SMALL = 3
TUNING.HAUNT_MEDIUM = 5
TUNING.HAUNT_MEDLARGE = 7
TUNING.HAUNT_LARGE = 10
TUNING.HAUNT_HUGE = 15
TUNING.HAUNT_INSTANT_REZ = 9999

TUNING.LAUNCH_SPEED_SMALL = 3
TUNING.LAUNCH_SPEED_MEDIUM = 5
TUNING.LAUNCH_SPEED_LARGE = 7

TUNING.HAUNT_PANIC_TIME_SMALL = 3
TUNING.HAUNT_PANIC_TIME_MEDIUM = 5
TUNING.HAUNT_PANIC_TIME_LARGE = 7

TUNING.PETRIFIED_TREE_SMALL = 2
TUNING.PETRIFIED_TREE_NORMAL = 3
TUNING.PETRIFIED_TREE_TALL = 4
TUNING.PETRIFIED_TREE_OLD = 1

TUNING.TWIGGYTREE_REGROWTH_TIME_MULT = 1
TUNING.TWIGGY_TREE_GROW_TIME =
{
    {base=1.5*day_time, random=0.5*day_time},   --short
    {base=3*day_time, random=1*day_time},   --normal
    {base=3*day_time, random=1*day_time},   --tall
    {base=5*day_time, random=0.5*day_time}   --old
}
TUNING.TWIGGY_TREE_REGROWTH = {
    OFFSPRING_TIME = total_day_time * 8,
    DESOLATION_RESPAWN_TIME = total_day_time * 50,
    DEAD_DECAY_TIME = total_day_time * 30,
}
TUNING.EVERGREEN_REGROWTH = {
    OFFSPRING_TIME = total_day_time * 5,
    DESOLATION_RESPAWN_TIME = total_day_time * 50,
    DEAD_DECAY_TIME = total_day_time * 30,
}

TUNING.REPAIR_MOONROCK_NUGGET_HEALTH = 80/2
TUNING.REPAIR_MOONROCK_NUGGET_WORK = 2

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


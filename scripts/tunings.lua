-----------------------------------------------------------------------
--                       C O N S T A N T S                           --
-----------------------------------------------------------------------

local seg_time = 30
local total_day_time = seg_time*16

local day_segs = 10
local dusk_segs = 4
local night_segs = 2

local day_time = seg_time * day_segs
local dusk_time = seg_time * dusk_segs
local night_time = seg_time * night_segs

local wilson_attack = 34
local wilson_attack_period = .5
local wilson_health = 150
local calories_per_day = 75

local perish_warp = 1

-----------------------------------------------------------------------

local EXTRA_TUNING = {

    PORTAL_HEALTH_PENALTY = 0.25,
    HEART_HEALTH_PENALTY = 0.125,

    MAXIMUM_HEALTH_PENALTY = 0.75,
    MAXIMUM_SANITY_PENALTY = 0.9,

    HAUNT_COOLDOWN_TINY = 1,
    HAUNT_COOLDOWN_SMALL = 3,
    HAUNT_COOLDOWN_MEDIUM = 5,
    HAUNT_COOLDOWN_LARGE = 7,
    HAUNT_COOLDOWN_HUGE = 10,

    HAUNT_CHANCE_ALWAYS = 1,
    HAUNT_CHANCE_OFTEN = .75,
    HAUNT_CHANCE_HALF = .5,
    HAUNT_CHANCE_OCCASIONAL = .25,
    HAUNT_CHANCE_RARE = .1,
    HAUNT_CHANCE_VERYRARE = .005,
    HAUNT_CHANCE_SUPERRARE = .001,

    HAUNT_TINY = 1,
    HAUNT_SMALL = 3,
    HAUNT_MEDIUM = 5,
    HAUNT_MEDLARGE = 7,
    HAUNT_LARGE = 10,
    HAUNT_HUGE = 15,
    HAUNT_INSTANT_REZ = 9999,

    LAUNCH_SPEED_SMALL = 3,
    LAUNCH_SPEED_MEDIUM = 5,
    LAUNCH_SPEED_LARGE = 7,

    HAUNT_PANIC_TIME_SMALL = 3,
    HAUNT_PANIC_TIME_MEDIUM = 5,
    HAUNT_PANIC_TIME_LARGE = 7,

    GHOST_LIGHT_OVERRIDE = .5,

    MAX_HEALING_NORMAL = -0.25,

    PETRIFIED_TREE_SMALL = 2,
    PETRIFIED_TREE_NORMAL = 3,
    PETRIFIED_TREE_TALL = 4,
    PETRIFIED_TREE_OLD = 1,

    TWIGGY_TREE_GROW_TIME =
    {
        {base=1.5*day_time, random=0.5*day_time},   -- short
        {base=3*day_time, random=1*day_time},   -- normal
        {base=3*day_time, random=1*day_time},   -- tall
        {base=5*day_time, random=0.5*day_time}   -- old
    },

    REPAIR_MOONROCK_NUGGET_HEALTH = 80/2,
    REPAIR_MOONROCK_NUGGET_WORK = 2,

    GRASSGEKKO_LIFE = 150,
    GRASSGEKKO_WALK_SPEED = 1,
    GRASSGEKKO_RUN_SPEED = 10,
    GRASSGEKKO_REGROW_TIME = total_day_time*2,
    GRASSGEKKO_REGROW_INCREASE = total_day_time*.5,
    GRASSGEKKO_REGROW_VARIANCE = total_day_time,
    GRASSGEKKO_CYCLES = 3,
    GRASSGEKKO_MORPH_DELAY = total_day_time * 25,
    GRASSGEKKO_MORPH_DELAY_VARIANCE = total_day_time * 5,
    GRASSGEKKO_MORPH_CHANCE = 1 / 100,
    GRASSGEKKO_MORPH_ENABLED = true,
    GRASSGEKKO_DENSITY_RANGE = 20,
    GRASSGEKKO_MAX_DENSITY = 6,

    BERRY_JUICY_REGROW_TIME =  total_day_time * 9,
    BERRY_JUICY_REGROW_INCREASE = total_day_time*.5,
    BERRY_JUICY_REGROW_VARIANCE = total_day_time*2,
    BERRYBUSH_JUICY_CYCLES = 3,

    MOONBASE_CHARGE_DELAY = 10,
    MOONBASE_CHARGE_DURATION = seg_time * 2 - 10.1,
    MOONBASE_CHARGE_DURATION1 = 18.7,
    MOONBASE_COMPLETE_WORK = 6,
    MOONBASE_DAMAGED_WORK = 4,

    PETRIFICATION_CYCLE = {
        MIN_YEARS = .6,
        MAX_YEARS = .9,
    },

    DAYLIGHT_SEARCH_RANGE = 30,
    ROSE_DAMAGE = 1,

    BATCAVE_REGEN_PERIOD = seg_time * 4,
    BATCAVE_SPAWN_PERIOD = 20,
    BATCAVE_MAX_CHILDREN = 4,
    BATCAVE_ENABLED = true,

    METEOR_DAMAGE = 50,
    METEOR_RADIUS = 3.5,
    METEOR_SMASH_INVITEM_CHANCE = .75,

    METEOR_MEDIUM_CHANCE = .4,
    METEOR_LARGE_CHANCE = .2,

    METEOR_CHANCE_INVITEM_ALWAYS = 1,
    METEOR_CHANCE_INVITEM_OFTEN = .6,
    METEOR_CHANCE_INVITEM_SOMETIMES = .4,
    METEOR_CHANCE_INVITEM_OCCASIONAL = .3,
    METEOR_CHANCE_INVITEM_RARE = .2,
    METEOR_CHANCE_INVITEM_VERYRARE = .12,
    METEOR_CHANCE_INVITEM_SUPERRARE = .05,

    METEOR_CHANCE_BOULDERROCK = 1,
    METEOR_CHANCE_BOULDERFLINTLESS = .3,
    METEOR_CHANCE_BOULDERMOON = .15,

    METEOR_SHOWER_SPAWN_RADIUS = 60,
    METEOR_SHOWER_CLEANUP_BUFFER = 10,

    METEOR_SHOWER_OFFSCREEN_MOD = .5,

    METEOR_SHOWER_LVL1_BASETIME = total_day_time*6,
    METEOR_SHOWER_LVL1_VARTIME = total_day_time*4,
    METEOR_SHOWER_LVL2_BASETIME = total_day_time*9,
    METEOR_SHOWER_LVL2_VARTIME = total_day_time*6,
    METEOR_SHOWER_LVL3_BASETIME = total_day_time*12,
    METEOR_SHOWER_LVL3_VARTIME = total_day_time*8,

    METEOR_SHOWER_LVL1_DURATION_BASE = 5,
    METEOR_SHOWER_LVL1_DURATIONVAR_MIN = 5,
    METEOR_SHOWER_LVL1_DURATIONVAR_MAX = 10,
    METEOR_SHOWER_LVL1_METEORSPERSEC_MIN = 2,
    METEOR_SHOWER_LVL1_METEORSPERSEC_MAX = 4,
    METEOR_SHOWER_LVL1_MEDMETEORS_MIN = 1,
    METEOR_SHOWER_LVL1_MEDMETEORS_MAX = 3,
    METEOR_SHOWER_LVL1_LRGMETEORS_MIN = 1,
    METEOR_SHOWER_LVL1_LRGMETEORS_MAX = 4,

    METEOR_SHOWER_LVL2_DURATION_BASE = 5,
    METEOR_SHOWER_LVL2_DURATIONVAR_MIN = 10,
    METEOR_SHOWER_LVL2_DURATIONVAR_MAX = 20,
    METEOR_SHOWER_LVL2_METEORSPERSEC_MIN = 3,
    METEOR_SHOWER_LVL2_METEORSPERSEC_MAX = 7,
    METEOR_SHOWER_LVL2_MEDMETEORS_MIN = 2,
    METEOR_SHOWER_LVL2_MEDMETEORS_MAX = 4,
    METEOR_SHOWER_LVL2_LRGMETEORS_MIN = 2,
    METEOR_SHOWER_LVL2_LRGMETEORS_MAX = 7,

    METEOR_SHOWER_LVL3_DURATION_BASE = 5,
    METEOR_SHOWER_LVL3_DURATIONVAR_MIN = 15,
    METEOR_SHOWER_LVL3_DURATIONVAR_MAX = 30,
    METEOR_SHOWER_LVL3_METEORSPERSEC_MIN = 4,
    METEOR_SHOWER_LVL3_METEORSPERSEC_MAX = 10,
    METEOR_SHOWER_LVL3_MEDMETEORS_MIN = 3,
    METEOR_SHOWER_LVL3_MEDMETEORS_MAX = 6,
    METEOR_SHOWER_LVL3_LRGMETEORS_MIN = 3,
    METEOR_SHOWER_LVL3_LRGMETEORS_MAX = 10,

    MOONROCKSHELL_CHANCE = 0.34,

    EVERGREEN_REGROWTH_TIME_MULT = 1,
    TWIGGYTREE_REGROWTH_TIME_MULT = 1,
    DECIDIOUS_REGROWTH_TIME_MULT = 1,
    MUSHTREE_REGROWTH_TIME_MULT = 1,
    MOONTREE_REGROWTH_TIME_MULT = 1,
    MOONMUSHTREE_REGROWTH_TIME_MULT = 1,

    CARROT_REGROWTH_TIME = day_time * 20,
    CARROT_REGROWTH_TIME_MULT = 1,
    FLOWER_REGROWTH_TIME = 30,
    FLOWER_REGROWTH_TIME_MULT = 1,
    FLOWER_WITHER_IN_CAVE_LIGHT = 0.05,
    RABBITHOLE_REGROWTH_TIME = total_day_time * 5,
    FLOWER_CAVE_REGROWTH_TIME = total_day_time * 5,
    FLOWER_CAVE_REGROWTH_TIME_MULT = 1,

    EVERGREEN_REGROWTH = {
        OFFSPRING_TIME = total_day_time * 5,
        DESOLATION_RESPAWN_TIME = total_day_time * 50,
        DEAD_DECAY_TIME = total_day_time * 30,
    },

    EVERGREEN_SPARSE_REGROWTH = {
        OFFSPRING_TIME = total_day_time * 8,
        DESOLATION_RESPAWN_TIME = total_day_time * 50,
        DEAD_DECAY_TIME = total_day_time * 30,
    },

    TWIGGY_TREE_REGROWTH = {
        OFFSPRING_TIME = total_day_time * 8,
        DESOLATION_RESPAWN_TIME = total_day_time * 50,
        DEAD_DECAY_TIME = total_day_time * 30,
    },

    DECIDUOUS_REGROWTH = {
        OFFSPRING_TIME = total_day_time * 3,
        DESOLATION_RESPAWN_TIME = total_day_time * 50,
        DEAD_DECAY_TIME = total_day_time * 30,
    },

    MUSHTREE_REGROWTH = {
        OFFSPRING_TIME = total_day_time * 3,
        DESOLATION_RESPAWN_TIME = total_day_time * 50,
        DEAD_DECAY_TIME = total_day_time * 30,
    },

    REGROWTH_TIME_MULTIPLIER = 1,

    HUTCH_RADIUS = 1.5,
    HUTCH_DMG_PERIOD = 1.2,
    HUTCH_PRICKLY_DAMAGE = 30,
    HUTCH_HEALTH = wilson_health * 3,
    HUTCH_RESPAWN_TIME = total_day_time * 1,
    HUTCH_HEALTH_REGEN_AMOUNT = (wilson_health*3) * 3/60,
    HUTCH_HEALTH_REGEN_PERIOD = 3,


}

for key, value in pairs(EXTRA_TUNING) do
    TUNING[key] = value
end

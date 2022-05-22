-------------------------------------------------------------------------------
--                           MODDED STRINGS                                  --
-------------------------------------------------------------------------------

STRINGS.ANR_CUTSCENE = {
    MAXWELL = {
        PUPPET1 = {
            "Can you shut up atleast for one minute?\nDo your work!",
            "Yes! I did it! \nLet's get out of here!",
            "No! Not again!",
        },
        PUPPET2 = {
            "We almost did this, Wilson!",
            "Yeah... yeah... You did this.",
            "Throw the switch, Wilson.",
            "Leave me alone!",
        },           
    },
    WILSON = {
        PUPPET1 = {
            "Maxwell, please... Stop talking.\nDo your work!",
            "Oh, let's get out from this cruel world!",
            "Leave me alone!",
        },
        PUPPET2 = {
            "We almost did this, Willow.",
            "Finally, freedom!",
            "Willow! Throw the switch!",
            "Charlie, no! It's me!",
        },
    },
    GENERIC = {
        PUPPET1 = {
            "Can you shut up atleast for one minute?\nDo your work!",
            "Yes! We did it! \nLet's get out of here!",
            "No! Not again!",
        },
        PUPPET2 = {
            "We almost did this, Higgsbury.",
            "I did it!",
            "Higgsbury! Throw the switch!",
            "Charlie, no! It's me!",
        },     
    }
}

-------------------------------------------------------------------------------
--                             DESC STRINGS                                  --
-------------------------------------------------------------------------------
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HOMESIGN.UNWRITTEN = "The sign is currently blank."

-------------------------------------------------------------------------------
--                           ACTIONS STRINGS                                 --
-------------------------------------------------------------------------------
STRINGS.ACTIONS.HAUNT = "Haunt"
STRINGS.ACTIONS.ATTUNE = "Attune"
STRINGS.ACTIONS.REMOTERESURRECT = "Resurrect"
STRINGS.ACTIONS.ACTIVATE.MIGRATE = "Travel via"
STRINGS.ACTIONS.WRITE = "Write On"
-------------------------------------------------------------------------------
--                              UI STRINGS                                   --
-------------------------------------------------------------------------------

STRINGS.UI.HUD.ACTIVATE_RESURRECTION = "Activate Meat Effigy"

STRINGS.UI.WORLDRESETDIALOG =
{
    TITLE = "Day %d: You are dead",
    TITLE_LATEJOIN = "Day %d: Everyone else is dead. Save them!",
    RESET_MSG = "World will reset in: %d",
    SURVIVED_MSG = "Survived %d Days",
    SURVIVED_MSG_1_DAY = "Survived %d Day",
    RESET_BUTTON = "Reset Now",
    BUTTONPROMPT1 = "Hold ",
    BUTTONPROMPT2 = "to Reset Now"
}

-------------------------------------------------------------------------------
--                            OTHERS STRINGS                                  --
-------------------------------------------------------------------------------

STRINGS.PIG_TALK_PANICHAUNT = { "SPOOKY!", "AAAAH!!", "A GHOST! A GHOST!" }
STRINGS.RABBIT_PANICHAUNT = { "SCARED!", "AAAH!!", "OHH!", "GHOST!" }

-------------------------------------------------------------------------------
--                            NAMES STRINGS                                  --
-------------------------------------------------------------------------------

local STRINGS_NAMES = {

    ROCK_MOON = "Boulder",
    ROCK_MOON_SHELL = "Suspicious Boulder",
    MOONROCKNUGGET = "Moon Rock",

    ROCK_PETRIFIED_TREE = "Petrified Tree",

    TWIGGYTREES_REGROWTH = "Twiggy Trees",
    TWIGGYTREE = "Twiggy Tree",
    TWIGGY_NUT = "Twiggy Tree Cone",
    TWIGGY_NUT_SAPLING = "Twiggy Sapling",

    GRASSGEKKO = "Grass Gekko",
    GRASSGEKKOS = "Grass Gekko Morphing",

    DUG_BERRYBUSH_JUICY = "Juicy Berry Bush",
    BERRYBUSH_JUICY = "Juicy Berry Bush",

    CAVE_EXIT = "Stairs",

    
}

STRINGS.SIGNS =
{
    MENU =
    {
        PROMPT = "Write on the sign",
        CANCEL = "Cancel",
        ACCEPT = "Write it!",
        RANDOM = "Random",
        FILTERING = "Validating Message...",
    },

    ADJ_NOUN_FMT = "{adjective} {noun}",
    ADJ_NOUN_ADD_FMT = "{adjective} {noun} {addition}",
    QUANT_ADJ_NOUN_FMT = "{quantifier} {adjective} {noun}",
    QUANT_ADJ_NOUN_ADD_FMT = "{quantifier} {adjective} {noun} {addition}",

    QUANTIFIERS =
    {
        "Really",
        "Very",
        "Quite",
        "Very Very",
        "Extremely",
        "Moderately",
        "Minimally",
        "Sort of",
        "Totally",
    },

    ADJECTIVES =
    {
        "Sunny",
        "Danker",
        "Dark",
        "Morose",
        "Morbid",
        "Awful",
        "Horrible",
        "Perfectly Normal",
        "Ordinary",
        "Perilous",
        "Dangerous",
        "Hazardous",
        "Creepy",
        "Empty",
        "Lonely",
        "Wet",
        "Dry",
        "Huge",
        "Small",
        "Little",
        "Picturesque",
        "Hideous",
        "Dreary",
        "Repulsive",
        "Boring",
        "Good",
        "Striking",
        "Uninteresting",
        "Fascinating",
        "Magnificent",
        "Soulless",
        "Echoing",
        "Sleepy",
        "Smelly",
        "Mediocre",
        "Awesome",
        "Brilliant",
        "Excellent",
    },

    -- Indices match ground types in constants.lua
    NOUNS =
    {
        [2] = { "Road", "Path" },
        [3] = { "Crag", "Area", "Region", "Rocky Place" },
        [4] = { "Patch", "Turf", "Area", "Tract" },
        [5] = { "Savannah", "Grassland", "Prairie" },
        [6] = { "Field", "Pasture", "Meadow", "Garden" },
        [7] = { "Forest", "Woods", "Thicket", "Grove" },
        [8] = { "Marsh", "Swamp", "Bog", "Fen" },
        [9] = { "Web", "Cobweb" },
        [10] = { "Place", "Corner", "Spot", "Base", "Hidey-Hole" },
        [11] = { "Place", "Corner", "Spot", "Base", "Hidey-Hole", "Carpet", "Rug" },
        [12] = { "Place", "Corner", "Spot", "Base", "Checkerboard", "Zone" },

        [13] = { "Cave" },
        [14] = { "Cave" },
        [15] = { "Cave" },
        [16] = { "Cave" },
        [17] = { "Cave" },
        [18] = { "Cave" },
        [19] = { "Cave" },
        [20] = { "Cave" },
        [21] = { "Cave" },
        [22] = { "Cave" },
        [23] = { "Cave" },
        [24] = { "Cave" },
        [25] = { "Cave" },

        [30] = { "Forest", "Woods", "Thicket", "Grove" },

        [31] = { "Desert", "Badlands", "Flats" },

        [32] = { "Place", "Corner", "Spot", "Base", "Hidey-Hole", "Zone", "Scale" },
    },

    DEFAULT_NOUNS =
    {
        "Spot",
        "Area",
        "Region",
        "Point",
        "Locality",
        "Site"
    },

    ADDITIONS =
    {
        "of Perilousness",
        "of Horribleness",
        "of Loneliness",
        "of Sorrow",
        "of Danger",
        "of Hunger",
        "of Shadows",
        "infested with Monsters",
        "crawling with Horrors",
        "of Happiness",
        "of Dreariness",
        "of Death",
        "full of Bees",
    },
}

STRINGS.BEEFALONAMING =
{
    BEEFNAMES =
    {
        "Annabeef",
        "Beefy",
        "Beefssie",
        "Betsbeef",
        "Beefa",
        "Daisbeef",
        "Dixbeef",
        "Gertbeef",
        "Beefgus",
        "Beefinand",
        "Wellington",
        "Bradbeef",
        "Beefany",
        "Harry",
        "Hoofrey",
        "Beeftholomew",
        "Guineveal",
        "Patty O'Beef",
        "Beeferella",
    },

    MENU =
    {
        CANCEL = "Cancel",
        RANDOM = "Random",
        ACCEPT = "Done",
    },
}
-------------------------------------------------------------------------------

for key, value in pairs(STRINGS_NAMES) do
    STRINGS.NAMES[key] = value
end

-------------------------------------------------------------------------------
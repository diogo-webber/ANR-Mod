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
--                           ACTIONS STRINGS                                 --
-------------------------------------------------------------------------------

STRINGS.ACTIONS.HAUNT = "Haunt"
STRINGS.ACTIONS.ATTUNE = "Attune"
STRINGS.ACTIONS.REMOTERESURRECT = "Resurrect"
STRINGS.ACTIONS.ACTIVATE.MIGRATE = "Travel via"

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

-------------------------------------------------------------------------------

for key, value in pairs(STRINGS_NAMES) do
    STRINGS.NAMES[key] = value
end

-------------------------------------------------------------------------------
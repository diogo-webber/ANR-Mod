modimport("scripts/util.lua")
modimport("scripts/strings.lua")
modimport("scripts/tunings.lua")
modimport("scripts/patches.lua")
modimport("scripts/recipes.lua")

modimport("scripts/consolecommands.lua") --for better testing

local ToLoad = require("to_load")
PrefabFiles = ToLoad.Prefabs
Assets = ToLoad.Assets

AddMinimapAtlas("minimap/minimap_data_anr.xml")
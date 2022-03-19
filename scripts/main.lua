_G.UpvalueHacker = require("tools/upvaluehacker")

modimport("scripts/constants.lua")
modimport("scripts/strings.lua")
modimport("scripts/tunings.lua")
modimport("scripts/physics.lua")
modimport("scripts/util.lua")
modimport("scripts/actions.lua")
modimport("scripts/recipes.lua")
modimport("scripts/patches.lua")

modimport("scripts/firespreading.lua")

modimport("scripts/consolecommands.lua") --for better testing

local ToLoad = require("to_load")
PrefabFiles = ToLoad.Prefabs
Assets = ToLoad.Assets

AddMinimapAtlas("minimap/minimap_data_anr.xml")
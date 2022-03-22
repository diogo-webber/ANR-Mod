local GenericPlayerFn = require("patches/prefabs/player")
local AnyFn = require("patches/prefabs/any")
local AnyHauntFn = require("patches/prefabs/any_haunt")

local PATCHES = 
{
	BRAINS = {
		any = {
			"beefalobrain",
			"babybeefalobrain",
			"beardbunnymanbrain",
			"beebrain",
			"butterflybrain",
			"catcoonbrain",
			"chesterbrain",
			"frogbrain",
			"houndbrain",
			"killerbeebrain",
			"mandrakebrain",
			"monkeybrain",
			"mosquitobrain",
			"nightmaremonkeybrain",
			"penguinbrain",
			"rabbitbrain",
			"slurperbrain",
			"slurtlebrain",
			"slurtlesnailbrain",
			"smallbirdbrain",
			"spatbrain",
			"spiderbrain",
			"spiderqueenbrain",
			"tallbirdbrain",
			"werepigbrain",
			"wormbrain",
			"batbrain",
			"birchnutdrakebrain",
			"bishopbrain",
			"knightbrain",
			"koalefantbrain",
			"krampusbrain",
			"mermbrain",
			"minotaurbrain",
			"molebrain",
			"perdbrain",
			"pigguardbrain",
			"rockybrain",
			"rookbrain",
			"walrusbrain",
			"werepigbrain",
		},
		pigman = "pigbrain",
		bunnyman = "bunnymanbrain",
	},
	
	COMPONENTS = {
		"freezable",
		"eater",
		"hatchable",
		"moisture",
		"health",
		"playeractionpicker",
		"playercontroller",
		"inventoryitem",
		"combat",
		"pickable",
		"inventory",
		"playercontroller", --Leo: for firespreading.lua
		"burnable", --Leo: for firespreading.lua
	},
	
	PREFABS = {
		maxwellintro = "maxwellintro",
		catcoonden = "catcoonden",
		rabbithole = "rabbithole",
		carrot_planted = "carrot_planted",
		flower_cave = {"flower_cave", "flower_cave_double", "flower_cave_triple"},
		burntfood = {"charcoal", "ash"},
		evergreens = {
			"evergreen",
			"evergreen_normal",
			"evergreen_tall",
			"evergreen_short",
			"evergreen_sparse",
			"evergreen_sparse_normal",
			"evergreen_sparse_tall",
			"evergreen_sparse_short",
			"evergreen_burnt",
			"evergreen_stump",				
		},
		deciduoustree = {
			"deciduoustree",
			"deciduoustree_normal",
			"deciduoustree_tall",
			"deciduoustree_short",
			"deciduoustree_burnt",
			"deciduoustree_stump",				
		},
		mushtree = {
			"mushtree_tall",
			"mushtree_medium",
			"mushtree_small",
		},
		world = "world",
		grass = "grass",
		flower = "flower",
		resurrectionstone = "resurrectionstone",
		resurrectionstatue = "resurrectionstatue",
		cave_entrance = "cave_entrance",
		cavelight = "cavelight",
		cave_exit = "cave_exit",
	},
	
	PLAYERS = {
		--"wilson",
		--"willow",
		--"wendy",
		--"wolfgang",
		--"wickerbottom",
		--"woodie",
		--"wes",
		--"waxwell",
		--"wagstaff"
		--"wathgrithr",
		--"webber",
		--"winona",
		--"wortox",
		--"wurt",
		--"walter",
		--"warly",
		--"wormwood",
		--"wilba",
		--"walani",
		--"wilbur",
		--"woodlegs",
		--"wheeler",
		--"wortox",
		--"wanda",
	},

	STATEGRAPHS = {
		"wilson",
	},

	SCREENS = {
		--"exmaple",
	},

	WIDGETS = {
		"statusdisplays",
		"healthbadge",
		"controls",
		"uiclock",
	},

	GLOBALCLASS = {
		entityscript = "EntityScript",
		saveindex = "SaveIndex",
	}
}

for i, prefab in ipairs(PATCHES.PLAYERS) do
	PATCHES.PREFABS[prefab] = prefab
end

local function patch(prefab, fn)
	AddPrefabPostInit(prefab, fn)
end

local function patchbrain(prefab, fn)
	AddBrainPostInit(prefab, fn)
end
				
for path, data in pairs(PATCHES.BRAINS) do
	local fn = require("patches/brains/"..path)
	
	if type(data) == "string" then
		patchbrain(data, function(inst) fn(inst, data) end)
	else
		for _, pref in ipairs(data) do
			patchbrain(pref, function(inst) fn(inst, pref) end)
		end
	end
end

for path, data in pairs(PATCHES.PREFABS) do
	local fn = require("patches/prefabs/"..path)
	
	if type(data) == "string" then
		patch(data, function(inst) fn(inst, data) end)
	else
		for _, pref in ipairs(data) do
			patch(pref, function(inst) fn(inst, pref) end)
		end
	end
end

AddPlayerPostInit(GenericPlayerFn)

AddPrefabPostInitAny(AnyFn)
AddPrefabPostInitAny(AnyHauntFn)

for _, file in ipairs(PATCHES.COMPONENTS) do
	local fn = require("patches/components/"..file)
	AddComponentPostInit(file, fn)
end

for _, name in ipairs(PATCHES.STATEGRAPHS) do
	AddStategraphPostInit(name, require("patches/stategraphs/"..name))
end

local states = require("stategraphs")
for i, state in ipairs(states) do
	AddStategraphState("wilson", state)
end

for _, name in ipairs(PATCHES.SCREENS) do
	AddClassPostConstruct("screens/"..name, require("patches/screens/"..name))
end

for _, name in ipairs(PATCHES.WIDGETS) do
	AddClassPostConstruct("widgets/"..name, require("patches/widgets/"..name))
end

for file, name in pairs(PATCHES.GLOBALCLASS) do
	AddGlobalClassPostConstruct(file, name, require("patches/"..file))
end

require("basehasslers").DRAGONFLY = nil --Has own setpiece
require("basehasslers").GOOSEMOOSE = nil --Has own setpiece
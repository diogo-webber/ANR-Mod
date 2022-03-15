local GenericPlayerFn = require("patches/prefabs/player")

local PATCHES = 
{
	COMPONENTS = {
		"freezable",
		"moisture",
		"health",
		"playeractionpicker",
	},
	
	PREFABS = {
		--table_example = {"example1", "example2"},
		maxwellintro = "maxwellintro",
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
	},
}

for i, prefab in ipairs(PATCHES.PLAYERS) do
	PATCHES.PREFABS[prefab] = prefab
end

local function patch(prefab, fn)
	AddPrefabPostInit(prefab, fn)
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


local GenericPlayerFn = require("patches/prefabs/player")

local PATCHES = 
{
	COMPONENTS = {
		--"example",
	},
	
	PREFABS = {
		--table_example = {"example1", "example2"},
		--example = "example",
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
		--"wilson",
	}
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

--AddPlayerPostInit(GenericPlayerFn)

for _, name in ipairs(PATCHES.STATEGRAPHS) do
	AddStategraphPostInit(name, require("patches/stategraphs/"..name))
end

env._G = GLOBAL
env.require = _G.require

env.TUNING = _G.TUNING
env.STRINGS = _G.STRINGS
env.GROUND = _G.GROUND
env.WorldSim = _G.WorldSim
local UpvalueHacker = require("tools/upvaluehacker")

local prefabDensities = {}

AddGlobalClassPostConstruct("map/graphnode", "Node", function(self, id, data, ...)
    local _PopulateVoronoi = self.PopulateVoronoi
	function self:PopulateVoronoi(...)
		local val = _PopulateVoronoi(self, ...)
        prefabDensities[self.id] = {}
        local points_x, points_y, points_type = WorldSim:GetPointsForSite(self.id)
        if #points_x == 0 then
            print(self.id.." Cant process points")
            return
        end
	
        if not self.data.terrain_contents or (self.data.terrain_contents.countprefabs == nil and self.data.terrain_contents.distributeprefabs == nil) then
            return
        end

        if self.data.terrain_contents.distributepercent then
            for prefab, v in pairs(self.data.terrain_contents.distributeprefabs) do
                -- convererts from actual numbers to a percentage of the distribute percent
                if type(v) == "table" then
                    for _, _prefab in pairs(v.prefabs) do
                        prefabDensities[self.id][_prefab] = v.weight/#points_x
                    end
                else
                    prefabDensities[self.id][prefab] = v/#points_x
                end
            end
        end
        prefabDensities = prefabDensities
        return val
	end
end)

local forest_map = require("map/forest_map")
local _Generate = forest_map.Generate
forest_map.Generate = function(...)
    local val = _Generate(...)
    if val then
        val.map.generated = {}
        val.map.generated.densities = prefabDensities
    end
    return val
end

local Layouts = require("map/layouts").Layouts
local Extra_Layouts = require("map/extra_layouts")
for key, value in pairs(Extra_Layouts) do
    Layouts[key] = value
end

AddLevelPreInit("SURVIVAL_DEFAULT", function(level)
	level.set_pieces["DragonflyArena"] = { count = 1, tasks = {"Frogs and bugs"} } --TEMP!!!!
end)
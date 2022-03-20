require "map/terrain"

local UPDATE_PERIOD = 11 -- less likely to update on the same frame as others
local SEARCH_RADIUS = 50
local BASE_RADIUS = 20
local EXCLUDE_RADIUS = 3
local MIN_PLAYER_DISTANCE = 64 * 1.2 -- this is our "outer" sleep radius

local TEST_ONEOF_TAGS = { "structure", "wall" }
local function TestForRegrow(x, y, z, prefab, searchtags)
    local ents = TheSim:FindEntities(x,y,z, EXCLUDE_RADIUS)
    if #ents > 0 then
        -- Too dense
        return false
    end

    local ents = TheSim:FindEntities(x,y,z, BASE_RADIUS, nil, nil, TEST_ONEOF_TAGS)
    if #ents > 0 then
        -- Don't spawn inside bases
        return false
    end

    local ents = TheSim:FindEntities(x,y,z, SEARCH_RADIUS, searchtags)
    if #ents > 0 then
        -- This ent is already "seeded", no need to desolation-spawn one.
        return false
    end

    if not (GetWorld().Map:CanPlantAtPoint(x, y, z) and
            GetWorld().Map:CanPlacePrefabFilteredAtPoint(x, y, z, prefab))
        or (RoadManager ~= nil and RoadManager:IsOnRoad(x, 0, z)) then
        -- Not ground we can grow on
        return false
    end
    return true
end

local function DoRegrowth(area, prefab, product, searchtags)
    --local points_x, points_y = GetWorld().topology.nodes[area].x, GetWorld().topology.nodes[area].y
    --if #points_x < 1 or #points_y < 1 then
    --    return
    --end 
    --local x = points_x[1]
    --local z = points_y[1]
    local x = GetWorld().topology.nodes[area].x
    local z = GetWorld().topology.nodes[area].y

    --if not IsAnyPlayerInRange(x,0,z, MIN_PLAYER_DISTANCE, nil) then
        if TestForRegrow(x,0,z, product, searchtags) then
            local instance = SpawnPrefab(product)
            --print("Making a",product," from ",prefab," for ",area)
            if instance ~= nil then
                instance.Transform:SetPosition(x,0,z)
            end
            --print(string.format("Making %s for site %d\nSite: %f,%f\nPoint: %f,%f", prefab, area,
                    --GetWorld().topology.nodes[area].x, GetWorld().topology.nodes[area].y,
                    --x, z))
            --c_teleport(x,0,z)
            --TheCamera:Snap()
            return true
        else
            --print(string.format("FAILED Making %s for site %d\nSite: %f,%f\nPoint: %f,%f", prefab, area,
                    --GetWorld().topology.nodes[area].x, GetWorld().topology.nodes[area].y,
                    --x, z))
            return false
        end
    --else
        --return false
    --end
end

local function PopulateAreaData(self, prefab)
    if GetWorld().generated == nil then
        -- Still starting up, not ready yet.
        return
    end

    for area, densities in pairs(GetWorld().generated.densities) do
        if densities[prefab] ~= nil then
            for i, v in ipairs(GetWorld().topology.ids) do
                if v == area then
                    if self._areadata[i] == nil then
                        self._areadata[i] = {}
                    end
                    if self._areadata[i][prefab] == nil then
                        self._areadata[i][prefab] =
                        {
                            denstiy = densities[prefab],
                            regrowtime = self._internaltimes[prefab] + math.random() * self._replacementdata[prefab].regrowtime, -- initial offset is randomized
                        }
                    -- else this was already populated by Load
                    end
                    break
                end
            end
        end
    end
end

local function PopulateAreaDataFromReplacements(self)
    -- This has to be run after 1 frame from startup
    for prefab, _ in pairs(self._replacementdata) do
        PopulateAreaData(self, prefab)
    end
end

local DesolationSpawner = Class(function(self, inst)
    self.inst = inst

    self._internaltimes = {}

    self._replacementdata = {} -- this components is "externally configured" e.g. from mods
    self._areadata = {}

    self.inst:DoPeriodicTask(UPDATE_PERIOD, function() self:LongUpdate(UPDATE_PERIOD) end)

    self:SetSpawningForType("evergreen", "pinecone_sapling", TUNING.EVERGREEN_REGROWTH.DESOLATION_RESPAWN_TIME, {"evergreen"}, function()
        return (GetSeasonManager():IsSummer() and TUNING.EVERGREEN_REGROWTH_TIME_MULT * 2) or (GetSeasonManager():IsWinter() and 0) or TUNING.EVERGREEN_REGROWTH_TIME_MULT
    end)
    self:SetSpawningForType("evergreen_sparse", "lumpy_sapling", TUNING.EVERGREEN_SPARSE_REGROWTH.DESOLATION_RESPAWN_TIME, {"evergreen_sparse"}, function()
        return TUNING.EVERGREEN_REGROWTH_TIME_MULT
    end)
    self:SetSpawningForType("twiggytree", "twiggy_nut_sapling", TUNING.TWIGGY_TREE_REGROWTH.DESOLATION_RESPAWN_TIME, {"twiggytree"}, function()
        return TUNING.TWIGGYTREE_REGROWTH_TIME_MULT
    end)
    self:SetSpawningForType("deciduoustree", "acorn_sapling", TUNING.DECIDUOUS_REGROWTH.DESOLATION_RESPAWN_TIME, {"deciduoustree"}, function()
        return (not GetSeasonManager():IsSpring() and 0) or TUNING.DECIDIOUS_REGROWTH_TIME_MULT
    end)
    self:SetSpawningForType("mushtree_tall", "mushtree_tall", TUNING.MUSHTREE_REGROWTH.DESOLATION_RESPAWN_TIME, {"mushtree"}, function()
        return (not GetSeasonManager():IsWinter() and 0) or TUNING.MUSHTREE_REGROWTH_TIME_MULT
    end)
    self:SetSpawningForType("mushtree_medium", "mushtree_medium", TUNING.MUSHTREE_REGROWTH.DESOLATION_RESPAWN_TIME, {"mushtree"}, function()
        return (not GetSeasonManager():IsSummer() and 0) or TUNING.MUSHTREE_REGROWTH_TIME_MULT
    end)
    self:SetSpawningForType("mushtree_small", "mushtree_small", TUNING.MUSHTREE_REGROWTH.DESOLATION_RESPAWN_TIME, {"mushtree"}, function()
        return (not GetSeasonManager():IsSpring() and 0) or TUNING.MUSHTREE_REGROWTH_TIME_MULT
    end)
    
    local moon_tree_mult =
    {
        new = 0,
        quarter = 0.5,
        half = 1.0,
        threequarter = 1.5,
        full = 2.0,
    }
    self:SetSpawningForType("moon_tree", "moonbutterfly_sapling", TUNING.EVERGREEN_REGROWTH.DESOLATION_RESPAWN_TIME, {"moon_tree"}, function()
        return (TUNING.MOONTREE_REGROWTH_TIME_MULT * moon_tree_mult[GetClock():GetMoonPhase()]) or 0
    end)
    
    self.inst:DoTaskInTime(0, function() PopulateAreaDataFromReplacements(self) end)
end)

function DesolationSpawner:SetSpawningForType(prefab, product, regrowtime, searchtags, timemult)
    self._replacementdata[prefab] = {product=product, regrowtime=regrowtime, searchtags=searchtags, timemult=timemult}
    self._internaltimes[prefab] = 0
    PopulateAreaData(self, prefab)
end

function DesolationSpawner:LongUpdate(dt)
    for k, data in pairs(self._replacementdata) do
        local prefabtimemult = self._replacementdata[k].timemult and self._replacementdata[k].timemult() or 1
        self._internaltimes[k] = self._internaltimes[k] + dt * TUNING.REGROWTH_TIME_MULTIPLIER * prefabtimemult
    end

    for area,data in pairs(self._areadata) do
        for prefab, prefabdata in pairs(data) do
            if prefabdata.regrowtime <= self._internaltimes[prefab] then
                --print("time for",prefab,"in",area)
                prefabdata.regrowtime = self._internaltimes[prefab] + self._replacementdata[prefab].regrowtime
                DoRegrowth(area, prefab, self._replacementdata[prefab].product, self._replacementdata[prefab].searchtags)
                --for performance, only DoRegrowth once per update
                return
            end
        end
    end
end

function DesolationSpawner:OnSave()
    local data = {
        areas = {}
    }
    for area, areadata in pairs(self._areadata) do
        data.areas[area] = { }
        for prefab, prefabdata in pairs(areadata) do
            data.areas[area][prefab] = {
                density = prefabdata.density,
                regrowtime = prefabdata.regrowtime - self._internaltimes[prefab],
            }
        end
    end
    return data
end

function DesolationSpawner:OnLoad(data)
    for area, areadata in pairs(data.areas) do
        for prefab, prefabdata in pairs(areadata) do
            if self._areadata[area] == nil then
                self._areadata[area] = {}
            end
            self._areadata[area][prefab] = {
                density = prefabdata.density,
                regrowtime = prefabdata.regrowtime + self._internaltimes[prefab],
            }
        end
    end
end

function DesolationSpawner:GetDebugString()
    local s = ""
    local nextdata = {}
    for area, data in pairs(self._areadata) do
        for prefab, prefabdata in pairs(data) do
            if nextdata[prefab] == nil or nextdata[prefab] > prefabdata.regrowtime then
                nextdata[prefab] = prefabdata.regrowtime
            end
        end
    end
    for prefab, time in pairs(nextdata) do
        s = s..string.format("%s: %.1f/%.1f ", prefab, self._internaltimes[prefab], time)
    end
    return s
end

return DesolationSpawner

local easing = require("easing")

local MIN_PLAYER_DISTANCE = 240
local RENEW_RADIUS = 60

--each renewable set contains a list of prefab spawns and prefab matches.
--if there aren't any of the prefab matches in an area, it will spawn one
--of the prefabs in the spawns list randomly.
local RENEWABLES =
{
    {
        spawns = { "flint" },
        matches = { "flint" },
    },
    {
        spawns = { "sapling", "sapling", "twiggytree" },
        matches = { "sapling", "twigs", "twiggytree" },
    },
    {
        spawns = { "grass" },
        matches = { "grass", "depleted_grass", "cutgrass", "grassgekko" },
    },
    {
        spawns = { "berrybush", "berrybush", "berrybush_juicy" },
        matches = { "berrybush", "berrybush2", "berrybush_juicy" },
    },
}
--turn the matches tables into key,value pairs
for i, v in ipairs(RENEWABLES) do
    local temp = {}
    for i2, v2 in ipairs(v.matches) do
        temp[v2] = true
    end
    v.matches = temp
end

local function UnregisterSpawnPoint(spawnpt)
    if spawnpt == nil then
        return
    end
    table.removearrayvalue(self._spawnpts, spawnpt)
end

local function OnRegisterSpawnPoint(self, inst, spawnpt)
    if spawnpt == nil or
        table.contains(self._spawnpts, spawnpt) then
        return
    end
    table.insert(self._spawnpts, spawnpt)
    inst:ListenForEvent("onremove", function(inst, source) UnregisterSpawnPoint(self, source) end, spawnpt)
end

local function OnEnableResourceRenewal(self, inst, enable)
    if self._enabled ~= enable then
        self._enabled = enable
        if enable then
            self:Start()
        else
            self:Stop()
        end
    end
end

local function GetRenewablePeriod()
    return TUNING.SEG_TIME + math.random() * TUNING.SEG_TIME
end

local function DoPrefabRenew(self, x, z, ents, renewable_set, max)
    --Check if this set's prefab matches were found already
    for i, v in ipairs(ents) do
        if renewable_set.matches[v.prefab] then
            return
        end
    end

    --Check if this set has a spawnable prefab
    if #renewable_set.spawns > 0 then
        --Spawn random up to max count
        for i = math.random(max), 1, -1 do
            local theta = math.random() * 2 * PI
            local radius = math.random() * RENEW_RADIUS
            local x1 = x + radius * math.cos(theta)
            local z1 = z - radius * math.sin(theta)
            if self.inst.Map:CanPlantAtPoint(x1, 0, z1) and
                not (RoadManager ~= nil and RoadManager:IsOnRoad(x1, 0, z1)) then
                local prefab = renewable_set.spawns[math.random(#renewable_set.spawns)]
                if self.inst.Map:CanPlacePrefabFilteredAtPoint(x1, 0, z1) then
                    SpawnPrefab(prefab).Transform:SetPosition(x1, 0, z1)
                end
            end
        end
    end
end

local RENEW_CANT_TAGS = { "INLIMBO" }
local RENEW_ONEOF_TAGS = { "renewable", "grassgekko" }
local function DoRenew(self)
    local targeti = math.min(math.floor(easing.inQuint(math.random(), 1, #self._spawnpts, 1)), #self._spawnpts)
    local target = self._spawnpts[targeti]
    table.remove(self._spawnpts, targeti)
    table.insert(self._spawnpts, target)

    local x, y, z = target.Transform:GetWorldPosition()
    if not (GetPlayer():GetDistanceSqToPoint(target:GetPosition()) < MIN_PLAYER_DISTANCE * MIN_PLAYER_DISTANCE) then
        local ents = TheSim:FindEntities(x, y, z, RENEW_RADIUS, nil, RENEW_CANT_TAGS, RENEW_ONEOF_TAGS)
        for i, v in ipairs(RENEWABLES) do
            DoPrefabRenew(self, x, z, ents, v, 3)
        end
    end

    self._task = self.inst:DoTaskInTime(GetRenewablePeriod(), function() DoRenew(self) end)
end

local ForestResourceSpawner = Class(function(self, inst)
    self.inst = inst

    self._enabled = false
    self._spawnpts = {}
    self._task = nil


    inst:ListenForEvent("ms_registerspawnpoint", function(inst, spawnpoint) OnRegisterSpawnPoint(self, inst, spawnpoint) end)
    inst:ListenForEvent("ms_enableresourcerenewal", function(inst, val) OnEnableResourceRenewal(self, inst, val) end)
    
    if self._enabled then
        self:Start()
    end
end)

function ForestResourceSpawner:Start()
    if self._task == nil then
        self._task = self.inst:DoTaskInTime(GetRenewablePeriod(), function() DoRenew(self) end)
    end
end

function ForestResourceSpawner:Stop()
    if self._task ~= nil then
        self._task:Cancel()
        self._task = nil
    end
end

return ForestResourceSpawner

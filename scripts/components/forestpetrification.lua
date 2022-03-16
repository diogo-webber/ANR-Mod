local MAX_SPAN_SQ = 36 * 36
local SECTOR_RADIUS = 4
local SECTOR_DIST = SECTOR_RADIUS * 1.41421 --math.sqrt(2) --NOT being bigger is more important than precision
local SECTOR_DIST_SQ = SECTOR_DIST * SECTOR_DIST
local PETRIFICATION_THRESHOLD = .2 --20% of remaining trees at most
local MAX_WORK = 10 --budget for update
local MAX_RETRIES = 5

local function RandomizeYearPart(minyears, maxyears)
    if minyears == nil or maxyears == nil or maxyears <= 0 then
        return -1
    end
    local year =
        GetSeasonManager().autumnlength +
        GetSeasonManager().winterlength +
        GetSeasonManager().springlength +
        GetSeasonManager().summerlength
    return math.random(math.ceil(year * minyears), math.ceil(year * maxyears))
end

local PETRIFIABLE_TAGS = { "petrifiable" }
local function CheckSector(self, row, col)
    --return value of work done, used to limit our update cost

    if self._visited[row] == nil then
        self._visited[row] = { [col] = true }
    elseif self._visited[row][col] then
        return 0
    else
        self._visited[row][col] = true
    end

    local ents = TheSim:FindEntities(self._x0 + row * SECTOR_DIST, 0, self._z0 + col * SECTOR_DIST, SECTOR_RADIUS, PETRIFIABLE_TAGS)
    if #ents <= 0 then
        return 1
    end

    for i, v in ipairs(ents) do
        if not self._found[v] then
            self._found[v] = true
            self._numfound = self._numfound + 1
        end
    end

    if (row * row + col * col) * SECTOR_DIST_SQ < MAX_SPAN_SQ then
        table.insert(self._tovisit, { row + 1, col })
        table.insert(self._tovisit, { row - 1, col })
        table.insert(self._tovisit, { row, col + 1 })
        table.insert(self._tovisit, { row, col - 1 })
    end
    return 2
end

local ForestPetrification = Class(function(self, inst)
    self.inst = inst
    self.inst:StartUpdatingComponent(self)

    self._tracked = {}
    self._cooldowndays = nil
    
    self._tovisit = nil
    self._visited = nil
    self._found = nil
    self._numfound = nil
    self._x0 = nil
    self._z0 = nil
    self._retries = nil
    
    self.inst:ListenForEvent("ms_registerpetrifiable", function(inst, target) self:OnRegisterPetrifiable(inst, target) end)
    self.inst:ListenForEvent("ms_unregisterpetrifiable", function(inst, target) self:OnUnregisterPetrifiable(inst, target) end)
end)

local function OnCycleComplete(inst)
    local self = inst.components.forestpetrification
    if self._cooldowndays > 1 then
        self._cooldowndays = self._cooldowndays - 1
    else
        self:StopCooldown()
        self:StartFindingForest()
    end
end

function ForestPetrification:StopCooldown()
    if self._cooldowndays ~= nil then
        self._cooldowndays = nil
        self.inst:RemoveEventCallback("daycomplete", OnCycleComplete)
    end
end

function ForestPetrification:StartCooldown(days)
    if days < 0 then
        self:StopCooldown()
    else
        if self._cooldowndays == nil then
            self.inst:ListenForEvent("daycomplete", OnCycleComplete)
        end
        self._cooldowndays = days
        if days == 0 then
            OnCycleComplete()
        end
    end
end

function ForestPetrification:StartFindingForest(retries)
    if self._tovisit == nil and #self._tracked > 0 then
        local y
        self._x0, y, self._z0 = self._tracked[math.random(#self._tracked)].Transform:GetWorldPosition()
        self._tovisit = { { 0, 0 } }
        self._visited = {}
        self._found = {}
        self._numfound = 0
        self._retries = retries or MAX_RETRIES
        self.inst:StartUpdatingComponent(self)
    end
end

function ForestPetrification:StopFindingForest()
    if self._tovisit then
        self._tovisit = nil
        self._visited = nil
        self._found = nil
        self._numfound = nil
        self._x0 = nil
        self._z0 = nil
        self._retries = nil
        self.inst:StopUpdatingComponent(self)
    end
end

function ForestPetrification:PetrifyForest()
    local xsum, zsum, count = 0, 0, 0
    for k, v in pairs(self._found) do
        if k._petrification_index ~= nil then
            local x, y, z = k.Transform:GetWorldPosition()
            xsum = xsum + x
            zsum = zsum + z
            count = count + 1
            k.components.petrifiable:Petrify(false)
        end
    end
    if count > 0 then
        SpawnPrefab("petrify_announce").Transform:SetPosition(xsum / count, 0, zsum / count)
    end
end

function ForestPetrification:StopTracking(target)
    if target and target._petrification_index == #self._tracked then
        table.remove(self._tracked)
        target._petrification_index = nil
    elseif target and target._petrification_index ~= nil then
        self._tracked[#self._tracked]._petrification_index = target._petrification_index
        self._tracked[target._petrification_index] = table.remove(self._tracked)
        target._petrification_index = nil
    end
end

function ForestPetrification:OnUnregisterPetrifiable(inst, target)
    inst:RemoveEventCallback("onremove", self.StopTracking, target)
    self:StopTracking(target)
end

function ForestPetrification:OnRegisterPetrifiable(inst, target)
    if target._petrification_index == nil then
        table.insert(self._tracked, target)
        target._petrification_index = #self._tracked
        inst:ListenForEvent("onremove", self.StopTracking, target)
    end
end

function ForestPetrification:OnPostInit()
    if self._cooldowndays == nil and self._tovisit == nil then
        self:StartCooldown(RandomizeYearPart(TUNING.PETRIFICATION_CYCLE.MIN_YEARS, TUNING.PETRIFICATION_CYCLE.MAX_YEARS))
    end
end

function ForestPetrification:OnUpdate()--dt)
    if self._tovisit then
        local workleft = MAX_WORK
        while workleft > 0 do
            workleft = workleft - CheckSector(self, unpack(table.remove(self._tovisit, 1)))

            if #self._tovisit <= 0 then
                if self._numfound > 0 and self._numfound < PETRIFICATION_THRESHOLD * #self._tracked then
                    self:PetrifyForest()
                    self:StopFindingForest()
                    self:StartCooldown(RandomizeYearPart(TUNING.PETRIFICATION_CYCLE.MIN_YEARS * .5, TUNING.PETRIFICATION_CYCLE.MAX_YEARS * .5))
                elseif _retries > 0 then
                    local retries = _retries
                    self:StopFindingForest()
                    self:StartFindingForest(retries - 1)
                else
                    self:StopFindingForest()
                    self:StartCooldown(RandomizeYearPart(TUNING.PETRIFICATION_CYCLE.MIN_YEARS * .5, TUNING.PETRIFICATION_CYCLE.MAX_YEARS * .5))
                end
                return
            end
        end
    else
        self.inst:StopUpdatingComponent(self)
    end
end

function ForestPetrification:LongUpdate(dt)
    while true do
        while self._tovisit do
            self:OnUpdate()
        end

        if dt <= 0 or self._cooldowndays == nil then
            return
        end

        local days = math.floor(dt / TUNING.TOTAL_DAY_TIME)
        if self._cooldowndays > days then
            self._cooldowndays = self._cooldowndays - days
            return
        end

        days = self._cooldowndays
        self:StopCooldown()
        self:StartFindingForest()
        dt = dt - days * TUNING.TOTAL_DAY_TIME
    end
end

function ForestPetrification:FindForest()
    self:StopCooldown()
    self:StartFindingForest()
end

function ForestPetrification:OnSave()
	return 
	{
		cooldown = self._cooldowndays or (self._tovisit and 0 or nil),
	}
end

function ForestPetrification:OnLoad(data)
    if data and data.cooldown and data.cooldown >= 1 then
        self:StopFindingForest()
        self:StartCooldown(math.floor(data.cooldown))
    end
end

function ForestPetrification:LoadPostPass(newents, data)
    if data and data.cooldown == 0 and self._tovisit == nil then
        self:StopCooldown()
        self:StartFindingForest()
    end
end

function ForestPetrification:GetDebugString()
    return (self._tovisit and "Finding forest..."..tostring(self._numfound))
        or (self._cooldowndays and "Cooldown in "..tostring(self._cooldowndays).." day(s)")
        or "Idle"
end

return ForestPetrification

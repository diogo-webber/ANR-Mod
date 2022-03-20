require "map/terrain"

local UPDATE_PERIOD = 29 -- less likely to update on the same frame as others
local BASE_RADIUS = 20
local EXCLUDE_RADIUS = 3
local JITTER_RADIUS = 20
local MIN_PLAYER_DISTANCE = 64 * 1.2 -- this is our "outer" sleep radius
local RETRY_MULT = 0.25 -- if we fail, try again sooner

local REGROW_STATUS = {
    SUCCESS = 0,
    FAILED = 1,
    CACHE = 2,
}

local REGROWBLOCKER_ONEOF_TAGS = { "structure", "wall" }
local function TestForRegrow(x, y, z, orig_tile)
    if GetWorld().Map:GetTileAtPoint(x, y, z) ~= orig_tile or
        not GetWorld().Map:CanPlantAtPoint(x, y, z) or
        (RoadManager ~= nil and RoadManager:IsOnRoad(x, 0, z)) then
        -- keep things in their biome (more or less)
        -- try to avoid roads
        return false
    end

    local ents = TheSim:FindEntities(x,y,z, EXCLUDE_RADIUS)
    if #ents > 0 then
        -- Too dense
        return false
    end

    local ents = TheSim:FindEntities(x,y,z, BASE_RADIUS, nil, nil, REGROWBLOCKER_ONEOF_TAGS)
    if #ents > 0 then
        -- No regrowth around players and their bases
        return false
    end
    return true
end

local function DoRegrowth(key, product, position)
    local x, y, z = position:Get()

    local orig_tile = GetWorld().Map:GetTileAtPoint(x,y,z)

    local theta = math.random() * 2 * PI
    local radius = math.random() * JITTER_RADIUS
    local x = x + radius * math.cos(theta)
    local z = z - radius * math.sin(theta)

    if not (GetPlayer():GetDistanceSqToPoint(position) < MIN_PLAYER_DISTANCE * MIN_PLAYER_DISTANCE) then
        if TestForRegrow(x,y,z, orig_tile) then
            local instance = SpawnPrefab(product)
            if instance ~= nil then
                instance.Transform:SetPosition(x,y,z)
            end
            return REGROW_STATUS.SUCCESS
        else
            return REGROW_STATUS.FAILED
        end
    else
        return REGROW_STATUS.CACHE
    end
end

local RegrowthManager = Class(function(self, inst)
    self.inst = inst

    self._internaltimes = {}

    self._regrowthvalues = {} -- this components is "externally configured" e.g. from mods
    
    self._lists = {}
    self.inst:ListenForEvent("beginregrowth", function(src, targ) self:OnBeginRegrowth(src, targ) end, GetWorld())

    self.inst:DoPeriodicTask(UPDATE_PERIOD, function() self:LongUpdate(UPDATE_PERIOD) end)
    
    self:SetRegrowthForType("carrot_planted", TUNING.CARROT_REGROWTH_TIME, "carrot_planted", function()
            return not (GetClock():IsNight() or GetSeasonManager():IsWinter() or GetSeasonManager():GetSnowPercent() > 0) and TUNING.CARROT_REGROWTH_TIME_MULT or 0
        end)
    self:SetRegrowthForType("flower", TUNING.FLOWER_REGROWTH_TIME, "flower", function()
            -- Flowers grow during the day, during not winter, while the ground is still wet after a rain.
            return ((GetSeasonManager():IsRaining() or GetClock():IsNight() or GetSeasonManager():IsWinter() or GetSeasonManager().atmo_moisture <= 1 or GetSeasonManager():GetSnowPercent() > 0) and 0)
                or (GetSeasonManager():IsSpring() and 2 * TUNING.FLOWER_REGROWTH_TIME_MULT) -- double speed in spring
                or TUNING.FLOWER_REGROWTH_TIME_MULT
        end)
    self:SetRegrowthForType("rabbithole", TUNING.RABBITHOLE_REGROWTH_TIME, "rabbithole", function()
            return GetSeasonManager():IsSummer() and TUNING.RABBITHOLE_REGROWTH_TIME_SUMMER_MULT or TUNING.RABBITHOLE_REGROWTH_TIME_MULT
        end)
    self:SetRegrowthForType("flower_cave", TUNING.FLOWER_CAVE_REGROWTH_TIME, "flower_cave", function()
            return TUNING.FLOWER_CAVE_REGROWTH_TIME_MULT
        end)
    self:SetRegrowthForType("flower_cave_double", TUNING.FLOWER_CAVE_REGROWTH_TIME, "flower_cave_double", function()
            return TUNING.FLOWER_CAVE_REGROWTH_TIME_MULT
        end)
    self:SetRegrowthForType("flower_cave_triple", TUNING.FLOWER_CAVE_REGROWTH_TIME, "flower_cave_triple", function()
            return TUNING.FLOWER_CAVE_REGROWTH_TIME_MULT
        end)
    self:SetRegrowthForType("lightflier_flower", TUNING.LIGHTFLIER_FLOWER_REGROWTH_TIME, "lightflier_flower", function()
            return TUNING.LIGHTFLIER_FLOWER_REGROWTH_TIME_MULT
        end)    
end)

function RegrowthManager:SetRegrowthForType(prefab, regrowtime, product, timemult)
    self._regrowthvalues[prefab] = {regrowtime=regrowtime, product=product, timemult=timemult}
    self._internaltimes[prefab] = 0
end

function RegrowthManager:LongUpdate(dt)
    for k,list in pairs(self._lists) do
        local prefabtimemult = self._regrowthvalues[k].timemult()
        if prefabtimemult > 0 then

            self._internaltimes[k] = self._internaltimes[k] + dt * TUNING.REGROWTH_TIME_MULTIPLIER * prefabtimemult

            local starttimer = list:Head()

            local timer_it = list:Iterator()

            local timer = timer_it:Next()

            while timer ~= nil do

                if timer.regrowtime > self._internaltimes[k] then
                    break
                end

                local success = DoRegrowth(k, timer.product, timer.position)

                if success == REGROW_STATUS.SUCCESS then
                    timer_it:RemoveCurrent()
                elseif success == REGROW_STATUS.CACHE then
                    -- leave this one on the head, we'll try again next update
                else
                    -- reset the timer and put it on the end
                    timer_it:RemoveCurrent()
                    -- Right now the list is implicitly sorted because all regrow times are the same. If we want
                    -- shorter regrow times, we'll have to sort the insertion or something. ~gjans
                    --timer.regrowtime = self._internaltimes[k] + self._regrowthvalues[k].regrowtime * RETRY_MULT
                    timer.regrowtime = self._internaltimes[k] + self._regrowthvalues[k].regrowtime
                    list:Append(timer)
                end

                timer = timer_it:Next()

                -- the list could be full of cached timers, so bail out if we loop
                if timer == starttimer then
                    break
                end
            end
        end
    end
end

function RegrowthManager:AppendTimer(key, timer)
    -- gjans: I did this as a linked list so I wouldn't need to sort and it would stay simple and performant,
    -- but it means that I can't have variable lengths of respawn times. I don't like that. So:
    -- TODO: Update this to use buckets or time groups or something, so it can support variable-length respawn times.
    if self._lists[key] == nil then
        self._lists[key] = LinkedList()
    end
    self._lists[key]:Append(timer)
end

local timer_i = 0

function RegrowthManager:OnBeginRegrowth(src, target)
    if self._regrowthvalues[target.prefab] == nil then
        print("Tried to regrow a "..target.prefab.." but we don't know how!")
        return
    end

    local timer = {
        product = self._regrowthvalues[target.prefab].product,
        regrowtime = self._internaltimes[target.prefab] + self._regrowthvalues[target.prefab].regrowtime,
        position = target:GetPosition(),
        i = timer_i,
    }
    timer_i = timer_i + 1

    self:AppendTimer(target.prefab, timer)
end

function RegrowthManager:OnSave()
    local timers = {}
    for k,list in pairs(self._lists) do
        timers[k] = {}
        local timer_it = list:Iterator()
        local timer = timer_it:Next()
        while timer ~= nil do
            table.insert(timers[k], {
                product = timer.product,
                regrowtime = timer.regrowtime-self._internaltimes[k],
                position = {
                    x = timer.position.x ~= 0 and timer.position.x or nil,
                    y = timer.position.y ~= 0 and timer.position.y or nil,
                    z = timer.position.z ~= 0 and timer.position.z or nil,
                },
            })
            timer = timer_it:Next()
        end
    end
    return {timers=timers}
end

function RegrowthManager:OnLoad(data)
    for k,group in pairs(data.timers) do
        for i,timerdata in ipairs(group) do
            if self._internaltimes[k] ~= nil then
                self:AppendTimer(k, {
                    product = timerdata.product,
                    regrowtime = self._internaltimes[k] + timerdata.regrowtime,
                    position = Point(timerdata.position.x or 0, timerdata.position.y or 0, timerdata.position.z or 0),
                    i = timer_i,
                })
                timer_i = timer_i + 1
            end
        end
    end
end

function RegrowthManager:GetDebugString()
    local s = ""
    for k,v in pairs(self._lists) do
        if v:Head() ~= nil then
            s = s..string.format("\n\t--%s:%d timemult:%.2f next:%.2f %d", k, v:Count(), self._regrowthvalues[k].timemult(), v:Head().regrowtime-self._internaltimes[k], v:Head().i)
        end
    end
    return s
end

return RegrowthManager

local SMOLDER_TICK_TIME = 2

local function SmolderUpdate(inst, self)
    local x, y, z = inst.Transform:GetWorldPosition()
    -- this radius should be larger than the propogation, so that once
    -- there's a lot of blazes in an area, fire starts spreading quickly
    local ents = TheSim:FindEntities(x, y, z, 12)
    local nearbyheat = 0
    for i, v in ipairs(ents) do
        if v.components.propagator ~= nil then
            nearbyheat = nearbyheat + v.components.propagator.currentheat
        end
    end

    if GetSeasonManager():IsRaining() then
        -- smolder more slowly, or even unsmolder, if we're being rained on.
        if nearbyheat > 0 then
            local rainmod = 1.8 * GetSeasonManager().precip
            self.smoldertimeremaining = self.smoldertimeremaining + SMOLDER_TICK_TIME * rainmod
        else
            -- Un-smolder at a fixed rate when there's no more heat, otherwise it takes foreeeever during gentle rain.
            self.smoldertimeremaining = self.smoldertimeremaining + SMOLDER_TICK_TIME * 3.0
        end
    end

    -- smolder about twice as fast if there's lots of heat nearby
    local heatmod = math.clamp(Remap(nearbyheat, 20, 90, 1, 2.2), 1, 2.2)

    self.smoldertimeremaining = self.smoldertimeremaining - SMOLDER_TICK_TIME * heatmod
    if self.smoldertimeremaining <= 0 then
        self:StopSmoldering() --JUST in case ignite fails...
        self:Ignite()
    elseif self.inst.components.propagator
        and self.inst.components.propagator.flashpoint
        and self.smoldertimeremaining > self.inst.components.propagator.flashpoint * 1.1 -- a small buffer to prevent flickering
        then
        -- extinguished by rain
        self:StopSmoldering()
    end
end

return function(self)

    self.task = nil
    self.smolder_task = nil
    
    local _oldStopSmoldering = self.StopSmoldering
    function self:StopSmoldering(heatpct)
        _oldStopSmoldering(self)
        
        if self.inst.components.propagator ~= nil then
            self.inst.components.propagator:StopSpreading(true, heatpct)
        end

        if self.onstopsmoldering ~= nil then
            self.onstopsmoldering(self.inst)
        end
    end

    local _oldSmotherSmolder = self.SmotherSmolder
    function self:SmotherSmolder(...)
        _oldSmotherSmolder(self, ...)
        self:StopSmoldering(-1)
    end

    local _oldExtinguish = self.Extinguish
    function self:Extinguish(...)
        _oldExtinguish(self, ...)
        if self.inst.components.propagator then
            self.inst.components.propagator.acceptsheat = true -- Bug Fix
        end
    end
    
    function self:StartWildfire()

        if not (self.burning or self.smoldering or self.inst:HasTag("fireimmune")) then
            self.smoldering = true
            self.inst:AddTag("smolder")
            if self.onsmoldering then
                self.onsmoldering(self.inst)
            end
            self.smoke = SpawnPrefab("smoke_plant")
            if self.smoke ~= nil then
                if #self.fxdata == 1 and self.fxdata[1].follow then
                    if self.fxdata[1].followaschild then
                        self.inst:AddChild(self.smoke)
                    end
                    local follower = self.smoke.entity:AddFollower()
                    local xoffs, yoffs, zoffs = self.fxdata[1].x, self.fxdata[1].y, self.fxdata[1].z
                    if self.fxoffset ~= nil then
                        xoffs = xoffs + self.fxoffset.x
                        yoffs = yoffs + self.fxoffset.y
                        zoffs = zoffs + self.fxoffset.z
                    end
                    follower:FollowSymbol(self.inst.GUID, self.fxdata[1].follow, xoffs, yoffs, zoffs)
                else
                    self.inst:AddChild(self.smoke)
                end
                self.smoke.Transform:SetPosition(0, 0, 0)
            end

            self.smoldertimeremaining =
                self.inst.components.propagator ~= nil and
                self.inst.components.propagator.flashpoint or
                math.random(TUNING.MIN_SMOLDER_TIME, TUNING.MAX_SMOLDER_TIME)

            if self.smolder_task ~= nil then
                self.smolder_task:Cancel()
            end
            self.smolder_task = self.inst:DoPeriodicTask(SMOLDER_TICK_TIME, SmolderUpdate, math.random() * SMOLDER_TICK_TIME, self)
        end
    end
end
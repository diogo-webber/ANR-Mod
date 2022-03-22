return function(self)
    self.alwayswantheat = false
    local _OnUpdate = self.OnUpdate
    function self:OnUpdate(dt, ...)
        if self.state == "unhatched" then
            return _OnUpdate(self, dt, ...)
        end

        if self.alwayswantheat then 
            if self.delay then
                return
            end

            local fire = FindEntity(self.inst, TUNING.HATCH_CAMPFIRE_RADIUS, function(thing) 
                return thing:HasTag("campfire") and thing.components.burnable and thing.components.burnable:IsBurning()
            end)
            
            local hasfire = (fire ~= nil)
            local oldstate = self.state
        
            self.toohot = false
            self.toocold = false

            if not hasfire then
                self.toocold = true
                self:OnState("uncomfy")
            else
                self:OnState("comfy")
            end

            if self.state == "comfy" then
                self.discomfort = math.max(self.discomfort - dt, 0)
                if self.discomfort <= 0 then
                    self.progress = self.progress + dt
                end
                
                if self.progress >= self.hatchtime then
                    self:StopUpdating()
                    self:OnState("hatch")
                end
            else
                self.discomfort = self.discomfort + dt
                if self.discomfort >= self.hatchfailtime then
                    self:StopUpdating()
                    self:OnState("dead")
                end
            end
            return 
        end
        _OnUpdate(self, dt, ...)
    end

    local _OnSave = self.OnSave
    function self:OnSave(...)
        local val = _OnSave(self, ...)
        val.alwayswantheat = self.alwayswantheat
        return val
    end

    local _OnLoad = self.OnLoad
    function self:OnLoad(data, ...)
        _OnLoad(self, data, ...)
        self.alwayswantheat = data.alwayswantheat
    end
end
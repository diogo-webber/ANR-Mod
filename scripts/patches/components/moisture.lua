return function(self)
    function self:ForceDry(force, source)
        if force then
             --if not self.forceddrymodifiers:Get() then
                self.rate = 0
                self.ratescale = RATE_SCALE.NEUTRAL
                self:SetMoistureLevel(0)
                self.inst:StopUpdatingComponent(self)
            -- end
            -- self.forceddrymodifiers:SetModifier(source or self.inst, true)
       -- elseif self.forceddrymodifiers:Get() then
        --     self.forceddrymodifiers:RemoveModifier(source or self.inst)
       --      self.inst:StartUpdatingComponent(self)
        else
             self.inst:StartUpdatingComponent(self)
        end
    end
end

local ispenaltyreworked = true
return function(self)
    function self:SetCurrentHealth(amount)
        self.currenthealth = amount
    end

    function self:ForceUpdateHUD(overtime)
        self:DoDelta(0, overtime, nil, true)
    end
   
    if ispenaltyreworked then
        function self:RecalculatePenalty()
            --deprecated, keeping the function around so mods don't crash
        end

        function self:GetMaxWithPenalty()
            return self.maxhealth - self.maxhealth * self.penalty
        end
    
        function self:IsHurt()
            return self.currenthealth < self:GetMaxWithPenalty()
        end
    
        function self:GetMaxHealth()
            return self:GetMaxWithPenalty()
        end
    
        function self:GetPenaltyPercent()
            return self.penalty
        end
    
        function self:GetPercentWithPenalty()
            return self.currenthealth / self:GetMaxWithPenalty()
        end
    end

    function self:SetPenalty(penalty)
        if not self.disable_penalty then
            --Penalty should never be less than 0% or ever above 75%.
            self.penalty = math.clamp(penalty, 0, TUNING.MAXIMUM_HEALTH_PENALTY)
        end
    end

    function self:DeltaPenalty(delta)
        self:SetPenalty(self.penalty + delta)
        self:ForceUpdateHUD(false) --handles capping health at max with penalty
    end
end
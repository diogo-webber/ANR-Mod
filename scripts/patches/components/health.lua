return function(self)
    function self:SetCurrentHealth(amount)
        self.currenthealth = amount
    end

    function self:ForceUpdateHUD(overtime)
        self:DoDelta(0, overtime, nil, true, nil, true)
    end
end
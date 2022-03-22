return function(self)
    function self:SetDiet(caneat, preferseating)
        self.foodprefs = caneat
        self.preferseating = preferseating or caneat
    end
end
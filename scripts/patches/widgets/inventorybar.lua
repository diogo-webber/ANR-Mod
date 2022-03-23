local HudCompass = require "widgets/hudcompass"

return function(self)
    self.hudcompass = self.root:AddChild(HudCompass(self.owner, true))
    self.hudcompass:SetScale(1.5, 1.5)
    self.hudcompass:SetMaster()
    self.hudcompass:MoveToBack()
    
    local _OnUpdate = self.OnUpdate
    function self:OnUpdate(dt, ...)
        self.owner:PushEvent("refreshinventory")
        return _OnUpdate(self, dt, ...)
    end

    local _Rebuild = self.Rebuild
    function self:Rebuild(...)
        _Rebuild(self, ...)
        self.hudcompass:SetPosition(self.equip[EQUIPSLOTS.HANDS]:GetPosition().x, self.integrated_backpack and 80 or 40, 0)
    end
end
local WorldResetTimer = require "widgets/worldresettimer"

return function(self)
    self.worldresettimer = self.bottom_root:AddChild(WorldResetTimer(self.owner))
    
    self.clock:Show()
    self.status:SetPosition(0,-110,0)
end
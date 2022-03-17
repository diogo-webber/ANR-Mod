local WorldResetTimer = require "widgets/worldresettimer"

return function(self)
    self.worldresettimer = self.bottom_root:AddChild(WorldResetTimer(self.owner))
end
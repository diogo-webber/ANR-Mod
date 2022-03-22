-------------------------------------------------------------------------------------------
local _Action = Action
Action = Class(function(self, data, priority, instant, rmb, distance, ...) 
    _Action(self, data, priority, instant, rmb, distance, ...)
    if not data then
        data = {}
    end
    self.priority = priority or data.priority or 0
    self.rmb = rmb or data.rmb or nil
    self.canforce = data.canforce or nil

    self.mindistance = data.mindistance or nil
    self.ghost_exclusive = data.ghost_exclusive or false
    self.ghost_valid = self.ghost_exclusive or data.ghost_valid or false -- If it's ghost-exclusive, then it must be ghost-valid
end)
-------------------------------------------------------------------------------------------

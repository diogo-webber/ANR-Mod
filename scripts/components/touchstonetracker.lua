local TouchStoneTracker = Class(function(self, inst)
    self.inst = inst
    self.isused = false
end)

function TouchStoneTracker:GetDebugString()
    local str = "Used: "..tostring(self.isused)
    return str
end

function TouchStoneTracker:Use()
    self.isused = true
end

function TouchStoneTracker:IsUsed(touchstone)
    return self.isused
end

function TouchStoneTracker:OnSave()
    local data = {}
    data.isused = self.isused or false
    return data
end

function TouchStoneTracker:OnLoad(data)
    if data then
        self.isused = data.isused or false
    end
end

return TouchStoneTracker

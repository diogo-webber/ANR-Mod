return function(self)
    local _OnUpdate = self.OnUpdate
    function self:OnUpdate(dt, ...)
        if self.fixedcameraoffset ~= nil then
            local rot = self.fixedcameraoffset - TheCamera:GetHeading() -- rotate against the camera
            self.inst.Transform:SetRotation(rot)
        end
        return _OnUpdate(self, dt,  ...)
    end
end
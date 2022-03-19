
local function notriding(inst)
	return not inst.components.rider or not inst.components.rider:IsRiding()
end

return function(self)
    local _GetActionButtonAction = self.GetActionButtonAction
    function self:GetActionButtonAction(...)
        local val = _GetActionButtonAction(self, ...)
		local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if val then
            if notriding(self.inst) and val.target.components.burnable and val.target.components.burnable:IsSmoldering() then
                return BufferedAction(self.inst, val.target, ACTIONS.SMOTHER, tool)
            end
        end
        return val
    end 

    function self:GetResurrectButtonAction()
        return self.inst:HasTag("playerghost") and self.inst.components.attuner:HasAttunement("remoteresurrector") and
            BufferedAction(self.inst, nil, ACTIONS.REMOTERESURRECT) or
            nil
    end
    
    function self:DoResurrectButton()
        if not self:IsEnabled() then
            return
        end
        local buffaction = self:GetResurrectButtonAction()
        if buffaction == nil then
            return
        else
            self.inst.components.locomotor:PushAction(buffaction, true)
        end
    end
end

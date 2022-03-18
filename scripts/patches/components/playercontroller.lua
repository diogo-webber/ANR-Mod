return function(self)
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
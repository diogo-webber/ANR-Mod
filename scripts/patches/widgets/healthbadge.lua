local UIAnim = require "widgets/uianim"

local function OnEffigyDeactivated(inst)
    if inst.AnimState:IsCurrentAnimation("effigy_deactivate") then
        inst.widget:Hide()
    end
end
    
local function PlayEffigyBreakSound(inst, self)
    inst.task = nil
    if self:IsVisible() and inst.AnimState:IsCurrentAnimation("effigy_deactivate") then
        --Don't use FE sound since it's not a 2D sfx
        GetPlayer().SoundEmitter:PlaySound("dontstarve/creatures/together/lavae/egg_deathcrack")
    end
end

return function(self)
    self.effigyanim = self.underNumber:AddChild(UIAnim())
    self.effigyanim:GetAnimState():SetBank("status_health")
    self.effigyanim:GetAnimState():SetBuild("status_health")
    self.effigyanim:GetAnimState():PlayAnimation("effigy_deactivate")
    self.effigyanim:Hide()
    self.effigyanim:SetClickable(false)
    self.effigyanim.inst:ListenForEvent("animover", OnEffigyDeactivated)
    self.effigy = false

    function self:ShowEffigy()
        if not self.effigy then
            self.effigy = true
            self.effigyanim:GetAnimState():PlayAnimation("effigy_activate")
            self.effigyanim:GetAnimState():PushAnimation("effigy_idle", false)
            self.effigyanim:Show()
        end
    end

    function self:HideEffigy()
        if self.effigy then
            self.effigy = false
            self.effigyanim:GetAnimState():PlayAnimation("effigy_deactivate")
            if self.effigyanim.inst.task ~= nil then
                self.effigyanim.inst.task:Cancel()
            end
            self.effigyanim.inst.task = self.effigyanim.inst:DoTaskInTime(7 * FRAMES, PlayEffigyBreakSound, self)
        end
    end
end
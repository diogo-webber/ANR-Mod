local ResurrectButton  = require "widgets/resurrectbutton"
local UIAnim = require "widgets/uianim"

local function UpdateRezButton(inst, self, enable)
    self.rezbuttontask = nil
    if enable then
        self:EnableResurrect(true)
    else
        local was_button_visible = self.isghostmode and self.resurrectbutton:IsVisible()
        self:EnableResurrect(false)
        if was_button_visible and not self.resurrectbutton:IsVisible() then
            self.resurrectbuttonfx:GetAnimState():PlayAnimation("break")
            self.resurrectbuttonfx:Show()
            if self.resurrectbuttonfx:IsVisible() then
                TheFocalPoint.SoundEmitter:PlaySound(self.heart.effigybreaksound)
            end
        end
    end
end

return function(self)
    self.resurrectbutton = self:AddChild(ResurrectButton(self.owner))
    self.resurrectbutton:SetScale(.75, .75, .75)
    self.resurrectbutton:SetTooltip(STRINGS.UI.HUD.ACTIVATE_RESURRECTION)

    self.resurrectbuttonfx = self:AddChild(UIAnim())
    self.resurrectbuttonfx:SetScale(.75, .75, .75)
    self.resurrectbuttonfx:GetAnimState():SetBank("effigy_break")
    self.resurrectbuttonfx:GetAnimState():SetBuild("effigy_button")
    self.resurrectbuttonfx:Hide()
    self.resurrectbuttonfx.inst:ListenForEvent("animover", function(inst) inst.widget:Hide() end)

    --NOTE: Can't rely on order of getting and losing attunement,
    --      especially in the same frame when switching effigies.

    --Delay button updates so it doesn't draw focus from entity anims/fx
    --Also helps flatten messages from the same frame to its final value
    local rezbuttondelay = 15 * FRAMES

    self.inst:ListenForEvent("gotnewattunement", function(owner, data)
        --can safely assume we are attuned if we just "got" an attunement
        if data.proxy:IsAttunableType("remoteresurrector") then
            if self.rezbuttontask ~= nil then
                self.rezbuttontask:Cancel()
            end
            self.rezbuttontask = not self.heart.effigy and self.inst:DoTaskInTime(rezbuttondelay, UpdateRezButton, self, true) or nil
        end
    end, self.owner)

    self.inst:ListenForEvent("attunementlost", function(owner, data)
        --cannot assume that we are no longer attuned
        --to a type when we lose a single attunement!
        if data.proxy:IsAttunableType("remoteresurrector") and
            not (owner.components.attuner ~= nil and owner.components.attuner:HasAttunement("remoteresurrector")) then
            if self.rezbuttontask ~= nil then
                self.rezbuttontask:Cancel()
            end
            self.rezbuttontask = self.heart.effigy and self.inst:DoTaskInTime(rezbuttondelay, UpdateRezButton, self, false) or nil
        end
    end, self.owner)

    self.rezbuttontask = nil
    self.isghostmode = true --force the initial SetGhostMode call to be dirty
    self.instantboatmeterclose = true

    function self:SetGhostMode(ghostmode)
        if not self.isghostmode == not ghostmode then --force boolean
            return
        elseif ghostmode then
            self.isghostmode = true
    
            self.heart:Hide()
            self.stomach:Hide()
            self.brain:Hide()
            self.moisturemeter:Hide()
            --self.boatmeter:Hide()
    
            self.heart:StopWarning()
            self.stomach:StopWarning()
            self.brain:StopWarning()
    
            if self.wereness ~= nil then
                self.wereness:Hide()
                self.wereness:StopWarning()
            end
    
            if self.pethealthbadge ~= nil then
                self.pethealthbadge:Hide()
            end
    
            if self.inspirationbadge ~= nil then
                self.inspirationbadge:Hide()
            end
    
            if self.mightybadge ~= nil then
                self.mightybadge:Hide()
            end
        else
            self.isghostmode = nil
    
            self.heart:Show()
            self.stomach:Show()
            self.brain:Show()
            self.moisturemeter:Show()
           -- self.boatmeter:Show()
    
            if self.wereness ~= nil then
                self.wereness:Show()
            end
    
            if self.pethealthbadge ~= nil then
                self.pethealthbadge:Show()
            end
    
            if self.inspirationbadge ~= nil then
                self.inspirationbadge:Show()
            end
    
            if self.mightybadge ~= nil then
                self.mightybadge:Show()
            end
        end
    
        if self.rezbuttontask ~= nil then
            self.rezbuttontask:Cancel()
            self.rezbuttontask = nil
        end
        self:EnableResurrect(self.owner.components.attuner ~= nil and self.owner.components.attuner:HasAttunement("remoteresurrector"))
    end

    function self:EnableResurrect(enable)
        if enable then
            --self.heart:ShowEffigy()
            if self.isghostmode then
                self.resurrectbutton:Show()
            else
                self.resurrectbutton:Hide()
            end
        else
            --self.heart:HideEffigy()
            self.resurrectbutton:Hide()
        end
    end

    self:SetGhostMode(false)
end
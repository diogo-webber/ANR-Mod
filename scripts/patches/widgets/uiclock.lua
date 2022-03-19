local Widget = require "widgets/widget"
local UIAnim = require "widgets/uianim"
local easing = require "easing"

local CAVE_DAY_COLOUR = Vector3(174 / 255, 195 / 255, 108 / 255)
local CAVE_DUSK_COLOUR = Vector3(113 / 255, 127 / 255, 108 / 255)

local DAY_COLOUR = Vector3(254/255,212/255,86/255)
local DUSK_COLOUR = Vector3(165/255,91/255,82/255)

local function CalculateLightRange(light, iscaveclockopen)
    return light:GetCalculatedRadius() * math.sqrt(1 - light:GetFalloff()) + (iscaveclockopen and 1 or -1)
end

local CAVE_LIGHT_MUST_TAGS = { "sinkhole", "lightsource" }

return function(self)
    self.owner = GetPlayer()
    self._cave = GetWorld() and GetWorld():IsCave()
    self.DAY_COLOUR = self._cave and CAVE_DAY_COLOUR or DAY_COLOUR
    self.DUSK_COLOUR = self._cave and CAVE_DUSK_COLOUR or DUSK_COLOUR

    self:RecalcSegs()

    if self._cave then
        self._rim = self:AddChild(UIAnim())
        self._rim:GetAnimState():SetBank("clock01")
        self._rim:GetAnimState():SetBuild("cave_clock")
        self._rim:GetAnimState():PlayAnimation("on")

        self._hands = self:AddChild(Widget("clockhands"))
        self._hands._img = self._hands:AddChild(Image("images/hud.xml", "clock_hand.tex"))
        self._hands._img:SetClickable(false)
        self._hands._animtime = nil
        self.rim:Hide()
        self.hands:Hide()
        self.anim:Hide()
    end

	self.text:MoveToFront()
    
    function self:IsCaveClock()
        return self._cave
    end

    function self:UpdateCaveClock()
        if self._lastsinkhole ~= nil and
            self._lastsinkhole:IsValid() and
            self._lastsinkhole.Light:IsEnabled() and
            self._lastsinkhole:IsNear(self.owner, CalculateLightRange(self._lastsinkhole.Light, self._caveopen)) then
            -- Still near last found sinkhole, can skip FineEntity =)
            self:OpenCaveClock()
            return
        end
    
        self._lastsinkhole = FindEntity(self.owner, 20, function(guy) return guy:IsNear(self.owner, CalculateLightRange(guy.Light, self._caveopen)) end, CAVE_LIGHT_MUST_TAGS)

        if self._lastsinkhole ~= nil then
            self:OpenCaveClock()
        else
            self:CloseCaveClock()
        end
    end
    
    function self:OpenCaveClock()
        if not self._cave or self._caveopen == true then
            return
        elseif self._caveopen == nil then
            self._rim:GetAnimState():PlayAnimation("on")
            self._hands._img:SetScale(1, 1, 1)
            self._hands._img:Show()
        else
            self._rim:GetAnimState():PlayAnimation("open")
            self._rim:GetAnimState():PushAnimation("on", false)
            self._hands._animtime = 0
            self:StartUpdating()
        end
        self._caveopen = true
    end
    
    function self:CloseCaveClock()
        if not self._cave or self._caveopen == false then
            return
        elseif self._caveopen == nil then
            self._rim:GetAnimState():PlayAnimation("off")
            self._hands._img:Hide()
        else
            self._rim:GetAnimState():PlayAnimation("close")
            self._rim:GetAnimState():PushAnimation("off", false)
            self._hands._animtime = 0
            self:StartUpdating()
        end
        self._caveopen = false
    end

    function self:OnUpdate(dt)
        local k = self._hands._animtime + dt * TheSim:GetTimeScale()
        self._hands._animtime = k
    
        if self._caveopen then
            local wait_time = 10 * FRAMES
            local grow_time = 5 * FRAMES
            local shrink_time = 3 * FRAMES
            if k >= wait_time then
                k = k - wait_time
                if k < grow_time then
                    local scale = easing.outQuad(k, 0, 1, grow_time)
                    self._hands._img:SetScale(scale, scale * 1.15, 1)
                else
                    k = k - grow_time
                    if k < shrink_time then
                        self._hands._img:SetScale(1, easing.inOutQuad(k, 1.1, -.1, shrink_time), 1)
                    else
                        self._hands._img:SetScale(1, 1, 1)
                        self._hands._animtime = nil
                        self:StopUpdating()
                    end
                end
                self._hands._img:Show()
            end
        else
            local wait_time = 3 * FRAMES
            local shrink_time = 6 * FRAMES
            if k >= wait_time then
                k = k - wait_time
                if k < shrink_time then
                    local scale = easing.inQuad(k, 1, -1, shrink_time)
                    self._hands._img:SetScale(scale, scale, 1)
                else
                    self._hands._img:Hide()
                    self._hands._animtime = nil
                    self:StopUpdating()
                end
            end
        end
    end
        
    local _SetTime = self.SetTime
    function self:SetTime(time, phase, ...)
        _SetTime(self, time, phase, ...)
        if self._hands then
            self._hands:SetRotation(time*360)
        end
    end    
    
    if self:IsCaveClock() then
        self.inst:DoPeriodicTask(.5, function() self:UpdateCaveClock() end)
    end
end
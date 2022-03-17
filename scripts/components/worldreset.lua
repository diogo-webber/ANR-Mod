local DeathScreen = require "screens/deathscreen"
local WorldReset = Class(function(self, inst)
    self.inst = inst
    self.time = 120
end)

function WorldReset:Reset()
    self:Enable(false)
    local playtime = GetTimePlaying()
    playtime = math.floor(playtime*1000)
    SetTimingStat("time", "scenario", playtime)
    SendTrackingStats()
    local days_survived, start_xp, reward_xp, new_xp, capped = CalculatePlayerRewards(GetPlayer())
    
    ProfileStatsSet("xp_gain", reward_xp)
    ProfileStatsSet("xp_total", new_xp)
    SubmitCompletedLevel() --close off the instance
    
    GetPlayer().components.health.invincible = true

    GetPlayer().profile:Save(function()
        SaveGameIndex:EraseCurrent(function() 
            scheduler:ExecuteInTime(3, function() 
                GetPlayer().components.playercontroller:Enable(false)
                TheFrontEnd:PushScreen(DeathScreen(days_survived, start_xp, nil, capped))
            end)
        end)
    end)
end

function WorldReset:OnUpdate(dt)
    self.time = self.time - dt
    if self.time < 0 then
        self:Reset()
    end
    self.inst:PushEvent("worldresettick", {time = self.time})
end

function WorldReset:Enable(val)
    if val then
        self.inst:PushEvent("showworldreset")
        self.inst:StartUpdatingComponent(self)
    else
        self.inst:StopUpdatingComponent(self)
        self.time = 120
        self.inst:PushEvent("hideworldreset")
    end
end

function WorldReset:GetDebugString()
    local str = ""
    return str
end

return WorldReset

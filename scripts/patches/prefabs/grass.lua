local function canmorph(inst)
    return inst.AnimState:IsCurrentAnimation("idle")
end

local TRIGGERMORPH_MUST_TAGS = { "renewable" }
local TRIGGERMORPH_CANT_TAGS = { "INLIMBO" }
local function triggernearbymorph(inst, quick, range)
    range = range or 1

    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, range, TRIGGERMORPH_MUST_TAGS, TRIGGERMORPH_CANT_TAGS)
    local count = 0

    for i, v in ipairs(ents) do
        if v ~= inst and
            v.prefab == "grass" and
            v.components.worldsettingstimer ~= nil and
            not (v.components.worldsettingstimer:ActiveTimerExists("morphdelay") or
                v.components.worldsettingstimer:ActiveTimerExists("morphing") or
                v.components.worldsettingstimer:ActiveTimerExists("morphrelay")) then

            count = count + 1

            if canmorph(v) and math.random() < .75 then
                v.components.worldsettingstimer:StartTimer(
                    "morphing",
                    ((not quick or count > 3) and .75 + math.random() * 1.5) or
                    (.2 + math.random() * .2) * count
                )
            else
                v.components.worldsettingstimer:StartTimer("morphrelay", count * _G.FRAMES)
            end
        end
    end

    if count <= 0 and range < 4 then
        triggernearbymorph(inst, quick, range * 2)
    end
end

local function testMorph(inst, worker)
    if not _G.GetSeasonManager().iswinter
    and worker ~= nil
    and worker:HasTag("player")
    and math.random() < TUNING.GRASSGEKKO_MORPH_CHANCE then
        triggernearbymorph(inst, true)
    end
end

local FINDGRASSGEKKO_MUST_TAGS = { "grassgekko" }
local function onmorphtimer(inst, data)
    local morphing = data.name == "morphing"
    if morphing or data.name == "morphrelay" then
        if morphing and canmorph(inst) then
            local x, y, z = inst.Transform:GetWorldPosition()
            if #TheSim:FindEntities(x, y, z, TUNING.GRASSGEKKO_DENSITY_RANGE, FINDGRASSGEKKO_MUST_TAGS) < TUNING.GRASSGEKKO_MAX_DENSITY then
                local gekko = SpawnPrefab("grassgekko")
                gekko.Transform:SetPosition(x, y, z)
                gekko.sg:GoToState("emerge")

                local partfx = SpawnPrefab("grasspartfx")
                partfx.Transform:SetPosition(x, y, z)
                partfx.Transform:SetRotation(inst.Transform:GetRotation())
                partfx.AnimState:SetMultColour(inst.AnimState:GetMultColour())

                triggernearbymorph(inst, false)
                inst:Remove()
                return
            end
        end
        inst.components.worldsettingstimer:StartTimer("morphdelay", GetRandomWithVariance(TUNING.GRASSGEKKO_MORPH_DELAY, TUNING.GRASSGEKKO_MORPH_DELAY_VARIANCE))
        triggernearbymorph(inst, false)
    end
end

local function makemorphable(inst)
    if inst.components.worldsettingstimer == nil then
        inst:AddComponent("worldsettingstimer")
        inst.components.worldsettingstimer:AddTimer("morphdelay", TUNING.GRASSGEKKO_MORPH_DELAY, TUNING.GRASSGEKKO_MORPH_ENABLED)
        inst.components.worldsettingstimer:AddTimer("morphing", 1, TUNING.GRASSGEKKO_MORPH_ENABLED)
        inst.components.worldsettingstimer:AddTimer("morphrelay", _G.FRAMES, TUNING.GRASSGEKKO_MORPH_ENABLED)
        inst:ListenForEvent("timerdone", onmorphtimer)
    end
end


local function OnPreLoad(inst, data)
    --WorldSettings_Timer_PreLoad(inst, data, "morphdelay", TUNING.GRASSGEKKO_MORPH_DELAY + TUNING.GRASSGEKKO_MORPH_DELAY_VARIANCE)
    --WorldSettings_Timer_PreLoad_Fix(inst, data, "morphdelay", 1)
    --WorldSettings_Timer_PreLoad(inst, data, "morphing")
    --WorldSettings_Timer_PreLoad_Fix(inst, data, "morphing", 1)
    --WorldSettings_Timer_PreLoad(inst, data, "morphrelay")
    --WorldSettings_Timer_PreLoad_Fix(inst, data, "morphrelay", 1)
    if data ~= nil then
        if data.pickable ~= nil and data.pickable.transplanted then
            makemorphable(inst)
        else
            if data.worldsettingstimer ~= nil then
                makemorphable(inst)
            end
        end
    end
end

return function(inst)
    local _old_dig_up = inst.components.workable.onfinish
    inst.components.workable:SetOnFinishCallback(function(inst, worker)
        testMorph(inst, worker)
        _old_dig_up(inst, worker)
    end)
    
    local _old_onpickedfn = inst.components.pickable.onpickedfn
    inst.components.pickable.onpickedfn = function(inst, picker)
        testMorph(inst, picker)
        _old_onpickedfn(inst, picker)
    end

    local _old_ontransplantfn = inst.components.pickable.ontransplantfn
    inst.components.pickable.ontransplantfn = function(inst)
        _old_ontransplantfn(inst)
        makemorphable(inst)
        inst.components.worldsettingstimer:StartTimer("morphdelay", _G.GetRandomWithVariance(TUNING.GRASSGEKKO_MORPH_DELAY, TUNING.GRASSGEKKO_MORPH_DELAY_VARIANCE))
        
    end
end
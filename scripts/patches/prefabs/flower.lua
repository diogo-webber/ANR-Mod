local FINDLIGHT_MUST_TAGS = { "daylight", "lightsource" }
local function DieInDarkness(inst)
    local x,y,z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x,0,z, TUNING.DAYLIGHT_SEARCH_RANGE, FINDLIGHT_MUST_TAGS)
    for i,v in ipairs(ents) do
        local lightrad = v.Light:GetCalculatedRadius() * .7
        if v:GetDistanceSqToPoint(x,y,z) < lightrad * lightrad then
            --found light
            return
        end
    end
    --in darkness
    inst:Remove()
    SpawnPrefab("flower_withered").Transform:SetPosition(x,y,z)
end

local names = {"f1","f2","f3","f4","f5","f6","f7","f8","f9","f10"}
local ROSE_NAME = "rose"
local ROSE_CHANCE = 0.01

local function setflowertype(inst, name)
    if inst.animname == nil or (name ~= nil and inst.animname ~= name) then
        if inst.animname == ROSE_NAME then
            inst:RemoveTag("thorny")
        end
        inst.animname = name or (math.random() < ROSE_CHANCE and ROSE_NAME or names[math.random(#names)])
        inst.AnimState:PlayAnimation(inst.animname)
        if inst.animname == ROSE_NAME then
            inst:AddTag("thorny")
        end
    end
end

return function(inst)
    if not _G.POPULATING then
        setflowertype(inst)
    end

    if _G.GetWorld():IsCave() then
        inst:DoPeriodicTask(30, function()
            if GetClock():IsDay() then
                inst:DoTaskInTime(5.0 + math.random()*5.0, DieInDarkness)
            end
        end)
    end
    
    local _oldOnSave =  inst.OnSave
    inst.OnSave = function(inst, data)
        _oldOnSave(inst, data)
        data.planted = inst.planted
    end

    inst.OnLoad = function(inst, data)
        inst.planted = data ~= nil and data.planted or nil
        setflowertype(inst, data ~= nil and data.anim or nil)
    end

   
end
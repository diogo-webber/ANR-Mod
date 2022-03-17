local assets =
{
    Asset("ANIM", "anim/flowers.zip"),
}

local prefabs =
{
    "petals",
    "flower_evil",
    "flower_withered",
    "planted_flower",
}

local ROSE_NAME = "rose"

local function setflowertype(inst, name)
    if inst.animname == nil or (name ~= nil and inst.animname ~= name) then
        if inst.animname == ROSE_NAME then
            inst:RemoveTag("thorny")
        end
        inst.animname = name
        inst.AnimState:PlayAnimation(inst.animname)
        inst:AddTag("thorny")
    end
end

local function onsave(inst, data)
    data.planted = inst.planted
end

local function onload(inst, data)
    inst.planted = data ~= nil and data.planted or nil
end

local function onpickedfn(inst, picker)
    local pos = inst:GetPosition()

    if picker ~= nil then
        if picker.components.sanity ~= nil and not picker:HasTag("plantkin") then
            picker.components.sanity:DoDelta(TUNING.SANITY_TINY)
        end

        if picker.components.combat ~= nil and
            not (picker.components.inventory ~= nil and picker.components.inventory:EquipHasTag("bramble_resistant")) then
            picker.components.combat:GetAttacked(inst, TUNING.ROSE_DAMAGE)
            picker:PushEvent("thorns")
        end
    end

    inst:Remove()

    if not inst.planted then
        GetWorld():PushEvent("beginregrowth", inst)
    end

    GetWorld():PushEvent("plantkilled", { doer = picker, pos = pos }) --this event is pushed in other places too
end

local FINDLIGHT_MUST_TAGS = { "daylight", "lightsource" }
local function DieInDarkness(inst)
    local x,y,z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x,0,z, TUNING.DAYLIGHT_SEARCH_RANGE, FINDLIGHT_MUST_TAGS)
    for i,v in ipairs(ents) do
        local lightrad = v.Light:GetCalculatedRadius() * .7
        if v:GetDistanceSqToPoint(x,y,z) < lightrad * lightrad then
            return
        end
    end
    --in darkness
    inst:Remove()
    SpawnPrefab("flower_withered").Transform:SetPosition(x,y,z)
end

local function OnBurnt(inst)
	if not inst.planted then
		GetWorld():PushEvent("beginregrowth", inst)
	end
    DefaultBurntFn(inst)
end


local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    inst.AnimState:SetBank("flowers")
    inst.AnimState:SetBuild("flowers")
    inst.AnimState:SetRayTestOnBB(true)

    inst:AddTag("flower")
    inst:AddTag("cattoy")

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = function() return "ROSE" end

    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/pickup_plants"
    inst.components.pickable:SetUp("petals", 10)
    inst.components.pickable.onpickedfn = onpickedfn
    inst.components.pickable.quickpick = true
    inst.components.pickable.wildfirestarter = true

    inst:AddComponent("transformer")
    inst.components.transformer:SetTransformEvent("fullmoon")
    inst.components.transformer:SetRevertEvent("daytime")
    inst.components.transformer:SetOnLoadCheck( function() 
        if not GetWorld():IsCave() then
            return (GetClock():IsNight() and GetClock():GetMoonPhase() == "full")
        end
        return false
    end )
    inst.components.transformer.transformPrefab = "flower_evil"

    MakeSmallBurnable(inst)
    inst.components.burnable:SetOnBurntFn(OnBurnt)

    MakeSmallPropagator(inst)

	--inst:AddComponent("halloweenmoonmutable")
	--inst.components.halloweenmoonmutable:SetPrefabMutated("moonbutterfly_sapling")
    
    inst:ListenForEvent("daytime", function(inst, data) inst.isday = true end, GetWorld())
    inst:ListenForEvent("dusktime", function(inst, data) inst.isday = false end, GetWorld())
    
    if GetWorld():IsCave() then
        inst:DoPeriodicTask(30, function()
            if inst.isday then
                inst:DoTaskInTime(5.0 + math.random()*5.0, DieInDarkness)
            end
        end)
    end

    MakeHauntableChangePrefab(inst, "flower_evil")

    --------SaveLoad
    inst.OnSave = onsave
    inst.OnLoad = onload

    inst:SetPrefabName("flower")
    setflowertype(inst, ROSE_NAME)

    return inst
end


return Prefab("flower_rose", fn, assets, prefabs)
       

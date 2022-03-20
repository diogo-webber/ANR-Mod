local assets =
{
    Asset("ANIM", "anim/marsh_bush.zip"),
}

local erode_assets =
{
    Asset("ANIM", "anim/ash.zip"),
}

local burnt_prefabs =
{
    "ash",
    "burnt_marsh_bush_erode",
}

local function DropAsh(inst, pos)
    if inst.components.lootdropper == nil then
        inst:AddComponent("lootdropper")
    end
    inst.components.lootdropper:SpawnLootPrefab("ash", pos)
end

local function OnActivateBurnt(inst)
    local pos = inst:GetPosition()
    inst:DoTaskInTime(.25 + math.random() * .05, DropAsh, pos)
    inst:AddTag("NOCLICK")
    inst.persists = false
    ErodeAway(inst)
    SpawnPrefab("burnt_marsh_bush_erode").Transform:SetPosition(pos:Get())
end

local function GetVerb()
    return "TOUCH"
end

local function burnt_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    inst.AnimState:SetBuild("marsh_bush")
    inst.AnimState:SetBank("marsh_bush")
    inst.AnimState:PlayAnimation("burnt")

    inst:AddTag("plant")
    inst:AddTag("thorny")
    inst:AddTag("burnt")

    inst.GetActivateVerb = GetVerb

    local color = 0.5 + math.random() * 0.5
    inst.AnimState:SetMultColour(color, color, color, 1)

    inst:AddComponent("inspectable")
    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    inst:AddComponent("activatable")
    inst.components.activatable.quickaction = true
    inst.components.activatable.OnActivate = OnActivateBurnt

    return inst
end

local function PlayErodeAnim()
    local inst = CreateEntity()

    inst:AddTag("FX")
    inst.entity:SetCanSleep(false)
    inst.persists = false

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()

    inst.AnimState:SetBank("ashes")
    inst.AnimState:SetBuild("ash")
    inst.AnimState:PlayAnimation("disappear")
    inst.AnimState:SetMultColour(.4, .4, .4, 1)
    inst.AnimState:SetTime(13 * FRAMES)

    inst.SoundEmitter:PlaySound("dontstarve/forest/treeCrumble", nil, .2)

    inst:ListenForEvent("animover", inst.Remove)
end

local function burnt_erode_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.Transform:SetTwoFaced()
    inst:AddTag("FX")

    inst:DoTaskInTime(0, PlayErodeAnim)
    inst.Transform:SetRotation(math.random(360))

    inst.persists = false
    inst:DoTaskInTime(.5, inst.Remove)

    return inst
end

return 
    Prefab("burnt_marsh_bush", burnt_fn, assets, burnt_prefabs),
    Prefab("burnt_marsh_bush_erode", burnt_erode_fn, erode_assets)

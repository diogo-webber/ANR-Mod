local assets =
{
    Asset("ANIM", "anim/withered_flowers.zip"),
}

local function onsave(inst, data)
    data.anim = inst.animname
end

local function onload(inst, data)
    if data ~= nil and data.anim ~= nil then
        inst.animname = data.anim
        inst.AnimState:PlayAnimation(inst.animname)
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    inst.AnimState:SetBank("withered_flowers")
    inst.AnimState:SetBuild("withered_flowers")
    inst.AnimState:SetRayTestOnBB(true)

    inst.animname = "wf"..tostring(math.random(3))
    inst.AnimState:PlayAnimation(inst.animname)

    inst:AddComponent("inspectable")

    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/pickup_plants"
    inst.components.pickable:SetUp("cutgrass", 10)
    inst.components.pickable.quickpick = true
    inst.components.pickable.onpickedfn = function(...) inst:Remove() end

    MakeSmallBurnable(inst)
    MakeSmallPropagator(inst)

    --------SaveLoad
    inst.OnSave = onsave
    inst.OnLoad = onload

    return inst
end

return Prefab("flower_withered", fn, assets)

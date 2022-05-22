require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/sign_arrow_post.zip"),
    Asset("ANIM", "anim/sign_arrow_panel.zip"),
    Asset("MINIMAP_IMAGE", "sign"),
}

local prefabs =
{
    "collapse_small",
    "arrowsign_panel",
}

local function onhammered(inst, worker)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    --fx:SetMaterial("wood")
    inst:Remove()
end

local function onhit(inst, worker)
    if not inst:HasTag("burnt") then
        inst.AnimState:PlayAnimation("hit")
        inst.AnimState:PushAnimation("idle", false)
    end
end

local function onsave(inst, data)
    if inst:HasTag("burnt") or (inst.components.burnable ~= nil and inst.components.burnable:IsBurning()) then
        data.burnt = true
    end
end

local function onload(inst, data)
    if data ~= nil and data.burnt then
        inst.components.burnable.onburnt(inst)
    end
end

local function onbuilt(inst)
    inst.SoundEmitter:PlaySound("dontstarve/common/sign_craft")
    local rot = -90 - TheCamera:GetHeading()
    inst.Transform:SetRotation(rot)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()

    MakeObstaclePhysics(inst, .2)

    inst.MiniMapEntity:SetIcon("sign.png")

    inst.AnimState:SetBank("sign_arrow_post")
    inst.AnimState:SetBuild("sign_arrow_post")
    inst.AnimState:PlayAnimation("idle")

    inst.Transform:SetEightFaced()

    inst:AddTag("structure")
    inst:AddTag("sign")

    --Sneak these into pristine state for optimization
    inst:AddTag("_writeable")

    inst:AddComponent("inspectable")
    inst:AddComponent("writeable")
    inst:AddComponent("lootdropper")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)

    MakeSnowCovered(inst)

    inst:AddComponent("savedrotation")

    MakeSmallBurnable(inst, nil, nil, true)
    MakeSmallPropagator(inst)
    inst.OnSave = onsave
    inst.OnLoad = onload

    MakeHauntableWork(inst)
    inst:ListenForEvent("onbuilt", onbuilt)

    return inst
end

local function panelfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    inst.AnimState:SetBank("sign_arrow_panel")
    inst.AnimState:SetBuild("sign_arrow_panel")
    inst.AnimState:PlayAnimation("idle")

    inst.Transform:SetEightFaced()

    inst:AddTag("sign")

    inst:AddComponent("inspectable")
    inst:AddComponent("writeable")
    inst:AddComponent("lootdropper")

    inst:AddComponent("savedrotation")

    -- TODO: Make workable, but transfer the work to the sign base instead

    MakeSnowCovered(inst)

    inst.OnSave = onsave
    inst.OnLoad = onload

    return inst
end

local function MakePlacerArrow(name, bank, build, anim, onground, snap, metersnap, scale, fixedcameraoffset, facing, postinit_fn, offset, onfailedplacement)
    local function fn()
        local inst = CreateEntity()

        inst:AddTag("CLASSIFIED")
        inst:AddTag("NOCLICK")
        inst:AddTag("placer")
        --[[Non-networked entity]]
        inst.entity:SetCanSleep(false)
        inst.persists = false

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        if anim ~= nil then
            inst.AnimState:SetBank(bank)
            inst.AnimState:SetBuild(build)
            inst.AnimState:PlayAnimation(anim, true)
            inst.AnimState:SetLightOverride(1)
        end

        if facing == "two" then
            inst.Transform:SetTwoFaced()
        elseif facing == "four" then
            inst.Transform:SetFourFaced()
        elseif facing == "six" then
            inst.Transform:SetSixFaced()
        elseif facing == "eight" then
            inst.Transform:SetEightFaced()
        end

        inst:AddComponent("placer")
        inst.components.placer.snaptogrid = snap
        inst.components.placer.snap_to_meters = metersnap
        inst.components.placer.fixedcameraoffset = fixedcameraoffset
        inst.components.placer.onground = onground
        -- If the user clicks when the placement is invalid this gets called
        inst.components.placer.onfailedplacement = onfailedplacement

        if offset ~= nil then
            inst.components.placer.offset = offset
        end

        if scale ~= nil and scale ~= 1 then
            inst.Transform:SetScale(scale, scale, scale)
        end

        if onground then
            inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
        end

        if postinit_fn ~= nil then
            postinit_fn(inst)
        end

        return inst
    end

    return Prefab(name, fn)
end

return Prefab("arrowsign_post", fn, assets, prefabs),
        MakePlacerArrow("arrowsign_post_placer", "sign_arrow_post", "sign_arrow_post", "idle", nil, nil, nil, nil, -90, "eight"),
        Prefab("arrowsign_panel", panelfn, assets, prefabs),
        MakePlacerArrow("arrowsign_panel_placer", "sign_arrow_panel", "sign_arrow_panel", "idle", nil, nil, nil, nil, -90, "eight")

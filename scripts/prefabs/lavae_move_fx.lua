local assets =
{
    Asset("ANIM", "anim/lavae_move_fx.zip"),
}

local function SetVariation(inst, rand, scale)
    inst._rand = rand
    --scale range from inst._min_scale -> inst._max_scale
    inst._scale = math.clamp(math.floor(math.floor((scale - inst._min_scale) / (inst._max_scale - inst._min_scale) * 7 + .5)), 0, 7)
    if inst._complete or inst._rand <= 0 then
        return
    end
    inst._complete = true
    scale = inst._scale / 7 * (inst._max_scale - inst._min_scale) + inst._min_scale

    inst.Transform:SetScale(scale, scale, scale)
    inst.AnimState:PlayAnimation("trail"..tostring(inst._rand))
    inst.AnimState:SetMultColour(unpack(inst._colour))
end

local function common_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    inst.entity:SetCanSleep(false)

    inst.AnimState:SetBank("lava_trail_fx")
    inst.AnimState:SetBuild("lavae_move_fx")
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(3)

    inst:AddTag("FX")

    inst._rand = nil
    inst._scale = nil

    --Dedicated server does not need to spawn the local fx
    inst._complete = false

    inst.SetVariation = SetVariation

    inst.persists = false
    inst:ListenForEvent("animover", inst.Remove)

    return inst
end

local function lavae_fn()
    local inst = common_fn()
    inst._min_scale = .5
    inst._max_scale = 1.3
    inst._colour = { 1, 1, 1, 1 }
    return inst
end

local function hutch_fn()
    local inst = common_fn()
    inst._min_scale = .3
    inst._max_scale = 1.5
    inst._colour = { .6, 1, 1, 1 }
    return inst
end

return Prefab("lavae_move_fx", lavae_fn, assets),
    Prefab("hutch_move_fx", hutch_fn, assets)

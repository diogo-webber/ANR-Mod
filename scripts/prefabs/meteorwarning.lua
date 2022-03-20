local assets =
{
    Asset("ANIM", "anim/meteor_shadow.zip"),
}

local function AlphaToFade(alpha)
    return math.floor(alpha * 63 + .5)
end

local function CalculatePeriod(time, starttint, endtint)
    return time / math.max(1, AlphaToFade(endtint) - AlphaToFade(starttint))
end

local DEFAULT_START = .33
local DEFAULT_END = 1
local DEFAULT_DURATION = 1
local DEFAULT_PERIOD = CalculatePeriod(DEFAULT_DURATION, DEFAULT_START, DEFAULT_END)

local function PushAlpha(inst)
    --local alpha = inst._fade / 63
    --inst.AnimState:OverrideMultColour(alpha, alpha, alpha, alpha)

    --Leo: OverrideMultColour don't exist in DS
end

local function UpdateFade(inst)
    if inst._fade < inst._fadeend then
        inst._fade = inst._fade + 1
        PushAlpha(inst)
    end
    if inst._fade >= inst._fadeend and inst._task ~= nil then
        inst._task:Cancel()
        inst._task = nil
    end
end

local function OnFadeDirty(inst)
    PushAlpha(inst)
    if inst._task ~= nil then
        inst._task:Cancel()
    end
    inst._task = inst:DoPeriodicTask(inst._period, UpdateFade)
end

local function startshadow(inst, time, starttint, endtint)
    if time ~= DEFAULT_DURATION or starttint ~= DEFAULT_START or endtint ~= DEFAULT_END then
        inst._fade = AlphaToFade(starttint)
        inst._fadeend = AlphaToFade(endtint)
        inst._period = CalculatePeriod(time, starttint, endtint)
        OnFadeDirty(inst)
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()

    inst.AnimState:SetBank("warning_shadow")
    inst.AnimState:SetBuild("meteor_shadow")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetFinalOffset(3)

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")

    inst._fade = AlphaToFade(DEFAULT_START)
    inst._fadeend = AlphaToFade(DEFAULT_END)
    inst._period = DEFAULT_PERIOD
    inst._task = nil
    OnFadeDirty(inst)

    inst:ListenForEvent("fadedirty", OnFadeDirty)

    inst.SoundEmitter:PlaySound("dontstarve/common/meteor_spawn")

    inst.startfn = startshadow
    inst.persists = false

    return inst
end

return Prefab("meteorwarning", fn, assets)

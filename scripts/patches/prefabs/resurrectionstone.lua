local function CanUseTouchStone(inst)
    if inst.components.touchstonetracker then
        return not inst.components.touchstonetracker:IsUsed()
    else
        return false
    end
end


local COOLDOWN = 20 --delay between uses by different players
local TIMEOUT = 10 --in case resurrection starts but never completes

local LIGHT_ANIM_PRE = "idle_pre"
local LIGHT_ANIM_PST = "idle_pst"
local LIGHT_ANIM_LOOP =
{
    "idle_activate",
}

local function OnLightAnimOver(inst)
    if inst._end then
        if not inst.entity:IsVisible() or inst.AnimState:IsCurrentAnimation(LIGHT_ANIM_PST) then
            inst:Remove()
        else
            inst.AnimState:PlayAnimation(LIGHT_ANIM_PST, false)
        end
    elseif inst._parent.AnimState:IsCurrentAnimation("idle_activate") then
        if inst.entity:IsVisible() then
            --randomize
            inst.AnimState:PlayAnimation(LIGHT_ANIM_LOOP[math.random(#LIGHT_ANIM_LOOP)], false)
        else
            inst.AnimState:PlayAnimation(LIGHT_ANIM_PRE, false)
            inst:Show()
        end
    elseif not inst.entity:IsVisible() then
        inst:DoTaskInTime(1, OnLightAnimOver)
    elseif inst.AnimState:IsCurrentAnimation(LIGHT_ANIM_PST) then
        inst:Hide()
    else
        inst.AnimState:PlayAnimation(LIGHT_ANIM_PST, false)
    end
end

local function EndLight(inst)
    inst._end = true
    if not inst.entity:IsVisible() then
        inst:Remove()
    end
end

local function CreateLight(parent)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    inst.AnimState:SetBank("resurrection_stone_fx")
    inst.AnimState:SetBuild("resurrection_stone_fx")
    inst.AnimState:SetFinalOffset(3)
    inst.AnimState:SetLightOverride(1)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")

    inst:Hide()

    inst:AddTag("NOCLICK")
    inst:AddTag("FX")
    --[[Non-networked entity]]
    inst.entity:SetCanSleep(false)
    inst.persists = false

    inst.entity:SetParent(parent.entity)
    inst._parent = parent

    inst._end = false
    inst:ListenForEvent("animover", OnLightAnimOver)
    OnLightAnimOver(inst)

    inst.EndLight = EndLight

    return inst
end

local function TryRandomLightFX(inst)
    inst._lighttask = nil

    if CanUseTouchStone(inst) then
        if inst.AnimState:IsCurrentAnimation("idle_activate") then
            inst._lightfx = CreateLight(inst)
        else
            inst._lighttask = inst:DoTaskInTime(.8 + math.random() * .4, TryRandomLightFX)
        end
    end
end

local function OnSleep(inst)
    if inst._lighttask ~= nil then
        inst._lighttask:Cancel()
        inst._lighttask = nil
    end
    if inst._lightfx ~= nil then
        inst._lightfx:Remove()
        inst._lightfx = nil
    end
end

local function OnWake(inst)
    inst._onghostvision(inst._lightplayer, inst._lightplayer:HasTag("playerghost"))
end

local function OnEnableLights(inst, enablelights)
    if enablelights then
        inst.OnEntitySleep = OnSleep
        inst.OnEntityWake = OnWake
        if not inst:IsAsleep() then
            OnWake(inst)
        end
    else
        inst.OnEntitySleep = nil
        inst.OnEntityWake = nil
        OnSleep(inst)
    end
end

local function SetupLights(inst)
    inst._lightplayer = GetPlayer()
    inst._lighttask = nil
    inst._lightfx = nil

    inst._onghostvision = function(player, ghostvision)
        if ghostvision then
            if inst._lighttask == nil and inst._lightfx == nil then
                --In case we need to wait for _touchstoneid initial sync
                --Also staggers the FX if multiple stones are nearby
                inst._lighttask = inst:DoTaskInTime(math.random() * .5, TryRandomLightFX)
            end
        else
            if inst._lighttask ~= nil then
                inst._lighttask:Cancel()
                inst._lighttask = nil
            end
            if inst._lightfx ~= nil then
                inst._lightfx:EndLight()
                inst._lightfx = nil
            end
        end
    end
    OnEnableLights(inst, true)
end

local function OnTimeout(inst)
    --In case haunt starts, but resurrection never activates
    --Could happen if player disconnects during resurrection
    inst._task = nil
    if inst.AnimState:IsCurrentAnimation("resurrect") or
        inst.AnimState:IsCurrentAnimation("idle_broken") then
        inst.AnimState:PlayAnimation("repair")
        inst.AnimState:PushAnimation("idle_activate", false)
        inst.SoundEmitter:PlaySound("dontstarve/common/resurrectionstone_activate")
        OnEnableLights(inst, true)
    end
end

local function OnHaunt(inst, haunter)
    if inst._task == nil and
        CanUseTouchStone(inst) and
        inst.AnimState:IsCurrentAnimation("idle_activate") then
        inst.components.touchstonetracker:Use()
        inst.AnimState:PlayAnimation("resurrect")
        inst.AnimState:PushAnimation("idle_broken", false)
        inst.SoundEmitter:PlaySound("dontstarve/common/resurrectionstone_break")
        OnEnableLights(inst, false)
        inst._task = inst:DoTaskInTime(TIMEOUT, OnTimeout)
        return true
    end
end

local function OnStartCharging(inst)
    if not inst.AnimState:IsCurrentAnimation("idle_off") then
        inst.AnimState:PlayAnimation("idle_off", false)
        inst.AnimState:SetLayer(LAYER_BACKGROUND)
        inst.AnimState:SetSortOrder(3)

        OnEnableLights(inst, false)

        inst.Physics:SetCollisionGroup(COLLISION.OBSTACLES)
        inst.Physics:ClearCollisionMask()
        inst.Physics:CollidesWith(COLLISION.WORLD)
        inst.Physics:CollidesWith(COLLISION.ITEMS)

        if inst.components.hauntable ~= nil then
            inst:RemoveComponent("hauntable")
        end
    end
end

local function HasPhysics(obj)
    return obj.Physics ~= nil
end

local CHANGED_CANT_TAGS = { "FX", "NOCLICK", "DECOR", "INLIMBO", "playerghost", "ghost", "flying" }
local function OnCharged(inst)
    if inst.AnimState:IsCurrentAnimation("idle_off") then
        local x, y, z = inst.Transform:GetWorldPosition()
        if FindEntity(inst, inst:GetPhysicsRadius(0), HasPhysics, nil, CHANGED_CANT_TAGS) ~= nil then
            --Something is on top of us
            --Reschedule regenration...
            inst.components.cooldown:StartCharging(math.random(5, 8))
            return
        end

        inst.AnimState:PlayAnimation("activate")
        inst.AnimState:PushAnimation("idle_activate", false)
        inst.AnimState:SetLayer(LAYER_WORLD)
        inst.AnimState:SetSortOrder(0)
        inst.Physics:CollidesWith(COLLISION.CHARACTERS)
        inst.SoundEmitter:PlaySound("dontstarve/common/resurrectionstone_activate")
        OnEnableLights(inst, true)
    end
end

local function OnAnimOver(inst)
    if inst.components.hauntable == nil and
        inst.AnimState:IsCurrentAnimation("idle_activate") then
        inst:AddComponent("hauntable")
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_INSTANT_REZ)
        inst.components.hauntable:SetOnHauntFn(OnHaunt)
    end
end

local function OnActivateResurrection(inst, guy)
    if inst._task ~= nil then
        inst._task:Cancel()
        inst._task = nil
    end
    GetSeasonManager():DoLightningStrike(Vector3(inst.Transform:GetWorldPosition()))
    inst.SoundEmitter:PlaySound("dontstarve/common/resurrectionstone_break")
    inst.components.lootdropper:DropLoot()
    inst.components.cooldown:StartCharging()
    --guy:PushEvent("usedtouchstone", inst)
end

-------------------------------------------------------------------------------

return function(inst)
    inst.AnimState:PlayAnimation("idle_activate")
	inst:AddTag("resurrector")

    inst:AddComponent("touchstonetracker")

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_INSTANT_REZ)
    inst.components.hauntable:SetOnHauntFn(OnHaunt)

    inst:RemoveComponent("resurrector")
    inst:RemoveComponent("activatable")

    inst:AddComponent("cooldown")
    inst.components.cooldown.cooldown_duration = COOLDOWN
    inst.components.cooldown.onchargedfn = OnCharged
    inst.components.cooldown.startchargingfn = OnStartCharging
    inst.components.cooldown.charged = true

    inst:DoTaskInTime(0, SetupLights)
    inst:ListenForEvent("animover", OnAnimOver)
    inst:ListenForEvent("activateresurrection", OnActivateResurrection)
end
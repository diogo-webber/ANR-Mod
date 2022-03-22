local assets =
{
    Asset("ANIM", "anim/fan_wheel.zip"),
}

local function AlignToTarget(inst, target)
    inst.Transform:SetRotation(target.Transform:GetRotation())
end

local function ToggleSpin(inst, spin)
    if spin then
        if not inst._toggle then
            inst._toggle = true
            inst.AnimState:PlayAnimation("spin_pre")
            inst.AnimState:PushAnimation("spin_loop", true)
            inst.SoundEmitter:PlaySound("dontstarve/common/fan_twirl_LP", "twirl")
        end
    elseif inst._toggle then
        inst._toggle = false
        inst.AnimState:PlayAnimation("spin_pst")
        inst.AnimState:PushAnimation("idle")
        inst.SoundEmitter:KillSound("twirl")
    end
end

local function SetSpinning(inst, isspinning)
    inst._isspinning = isspinning
    ToggleSpin(inst, inst._isspinning)
end

local function transfertostatemem(inst, sg)
    if sg.statemem.followfx == nil then
        sg.statemem.followfx = { inst }
    else
        table.insert(sg.statemem.followfx, inst)
    end
end

local function delayedremove(inst)
    inst._timeout = inst:DoTaskInTime(0, inst.Remove)
end

local function StartUnequipping(inst, item)
    local parent = inst.entity:GetParent()
    if parent == nil or
        item.components.inventoryitem == nil or
        item.components.inventoryitem.owner ~= parent then
        --not held anymore
        inst:Remove()
        return
    end

    --The trick here is that we want to keep the fx around if
    --the character is going to animate putting the item away

    --Remove immediately if it gets dropped at anytime
    inst:ListenForEvent("ondropped", function() inst:Remove() end, item)

    --Now we try to pass the reference to this fx over to the
    --character's stategraph, which will handle cleanup there

    --If we're in the item_in state, push this fx to statemem
    if parent.sg.currentstate.name ~= "item_in" then
        inst._timeout = inst:DoTaskInTime(0, delayedremove)
        inst:ListenForEvent("newstate", function(parent, data)
            if data.statename ~= "item_in" then
                inst:Remove()
            else
                inst._timeout:Cancel()
                transfertostatemem(inst, parent.sg)
            end
        end, parent)
    else
        transfertostatemem(inst, parent.sg)
    end
end

local function SetOwner(inst, owner)
    inst:DoPeriodicTask(0, AlignToTarget, nil, owner)
    AlignToTarget(inst, owner)
end

local function fn()
    local inst = CreateEntity()

    inst:AddTag("FX")

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()

    inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("fan_wheel")
    inst.AnimState:SetBuild("fan_wheel")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetFinalOffset(1)

    inst._toggle = false

    -----------------------------------------------------
    inst:AddTag("FX")

    inst._isspinning = false
    ToggleSpin(inst, inst._isspinning)

    inst.SetSpinning = SetSpinning
    inst.StartUnequipping = StartUnequipping
    inst.SetOwner = SetOwner

    inst.persists = false

    return inst
end

return Prefab("fan_wheel", fn, assets)

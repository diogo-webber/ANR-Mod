
local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_compass", "swap_compass")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")

    inst.components.fueled:StartConsuming()

    owner:AddTag("compassbearer")
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")

    inst.components.fueled:StopConsuming()

    owner:RemoveTag("compassbearer")
end

local function ondepleted(inst)
    if inst.components.inventoryitem ~= nil
        and inst.components.inventoryitem.owner ~= nil then
        local data = {
            prefab = inst.prefab,
            equipslot = inst.components.equippable.equipslot,
            announce = "ANNOUNCE_COMPASS_OUT",
        }
        inst.components.inventoryitem.owner:PushEvent("itemranout", data)
    end
    inst:Remove()
end

local function onattack(inst, attacker, target)
    if inst.components.fueled ~= nil then
        inst.components.fueled:DoDelta(inst.components.fueled.maxfuel * TUNING.COMPASS_ATTACK_DECAY_PERCENT)
    end
end

return function(inst)
    inst:AddTag("compass")

    --weapon (from weapon component) added to pristine state for optimization
    inst:AddTag("weapon")

    inst.components.inspectable.getstatus = nil

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    inst:AddComponent("fueled")
    inst.components.fueled:InitializeFuelLevel(TUNING.COMPASS_FUEL)
    inst.components.fueled:SetDepletedFn(ondepleted)
    --inst.components.fueled:SetFirstPeriod(TUNING.TURNON_FUELED_CONSUMPTION, TUNING.TURNON_FULL_FUELED_CONSUMPTION)

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(TUNING.UNARMED_DAMAGE)
    inst.components.weapon:SetOnAttack(onattack)

    inst.spookyoffsettarget = 0
    inst.spookyoffsetstart = 0
    inst.spookyoffsetfinish = 0

    MakeHauntableLaunch(inst)
    AddHauntableCustomReaction(inst, function(inst,haunter)
        inst.components.hauntable.hauntvalue = TUNING.HAUNT_HUGE
        inst.spookyoffsettarget = 220
        inst.spookyoffsetstart = GetTime()
        inst.spookyoffsetfinish = GetTime() + 30
        return true
    end, false, true, true)
end
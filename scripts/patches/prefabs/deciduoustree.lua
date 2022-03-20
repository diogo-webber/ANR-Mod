return function(inst)
    inst:AddComponent("plantregrowth")
    inst.components.plantregrowth:SetRegrowthRate(TUNING.DECIDUOUS_REGROWTH.OFFSPRING_TIME)
    inst.components.plantregrowth:SetProduct("acorn_sapling")
    inst.components.plantregrowth:SetSearchTag("deciduoustree")

    if not inst.components.hauntable then inst:AddComponent("hauntable") end
    inst.components.hauntable:SetOnHauntFn(function(inst, haunter)
        local isstump = inst:HasTag("stump")
        if not isstump and
            inst.components.workable ~= nil and
            math.random() <= TUNING.HAUNT_CHANCE_OFTEN then
            inst.components.workable:WorkedBy(haunter, 1)
            inst.components.hauntable.hauntvalue = TUNING.HAUNT_SMALL
            return true
        elseif inst:HasTag("burnt") then
            return false
        --#HAUNTFIX
        --elseif inst.components.burnable ~= nil and
            --not inst.components.burnable:IsBurning() and
            --math.random() <= TUNING.HAUNT_CHANCE_VERYRARE then
            --inst.components.burnable:Ignite()
            --inst.components.hauntable.hauntvalue = TUNING.HAUNT_MEDIUM
            --inst.components.hauntable.cooldown_on_successful_haunt = false
            --return true
        elseif not (isstump or inst.monster) and
            math.random() <= TUNING.HAUNT_CHANCE_SUPERRARE then
            inst:StartMonster(true)
            inst.components.hauntable.hauntvalue = TUNING.HAUNT_HUGE
            return true
        end
        return false
    end)
end
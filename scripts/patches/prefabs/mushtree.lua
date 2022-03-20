local function CustomOnHauntMushTree(inst, haunter)
    if not inst:HasTag("stump") and math.random() < TUNING.HAUNT_CHANCE_HALF then
        inst.components.growable:DoGrowth()
        return true
    end
    return false
end

return function(inst)
    inst:AddComponent("plantregrowth")
    inst.components.plantregrowth:SetRegrowthRate(TUNING.MUSHTREE_REGROWTH.OFFSPRING_TIME)
    inst.components.plantregrowth:SetProduct(inst.prefab)
    inst.components.plantregrowth:SetSearchTag("mushtree")

    MakeHauntableIgnite(inst)
    AddHauntableCustomReaction(inst, CustomOnHauntMushTree)
end
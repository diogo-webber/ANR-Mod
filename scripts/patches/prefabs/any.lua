return function(inst)
    local function prefab(prefab_name)
        return inst.prefab == prefab_name
    end
    
    -----------------------------------------------------------------------

    if prefab "lightbulb" or prefab "wormlight" then
        inst:AddTag("lightbattery")
    elseif prefab "spear" or prefab "spear_wathgrithr" then
        inst:AddTag("pointy")
    elseif prefab "onemanband" then
        inst:AddTag("band")
    end
end
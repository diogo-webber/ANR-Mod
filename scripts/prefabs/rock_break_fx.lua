local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddSoundEmitter()
    inst.SoundEmitter:PlaySound("dontstarve/wilson/rock_break")

    inst:AddTag("FX")

    inst.persists = false
    inst:DoTaskInTime(1, inst.Remove)

    return inst
end

return Prefab("rock_break_fx", fn)

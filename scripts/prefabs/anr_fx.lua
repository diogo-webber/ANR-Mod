local function PlaySound(inst, sound)
    inst.SoundEmitter:PlaySound(sound)
end

local function MakeFx(t)
    local assets =
    {
        Asset("ANIM", "anim/"..t.build..".zip")
    }

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()

        if t.nameoverride == nil and t.description == nil then
            inst:AddTag("FX")
        end
        inst.entity:SetCanSleep(false)
        inst.persists = false

        if t.sound ~= nil then
            inst.entity:AddSoundEmitter()
            inst:DoTaskInTime(t.sounddelay or 0, PlaySound, t.sound)
        end

        if t.sound2 ~= nil then
            if inst.SoundEmitter == nil then
                inst.entity:AddSoundEmitter()
            end
            inst:DoTaskInTime(t.sounddelay2 or 0, PlaySound, t.sound2)
        end

        inst.AnimState:SetBank(t.bank)
        inst.AnimState:SetBuild(t.build)
        inst.AnimState:PlayAnimation(FunctionOrValue(t.anim))
        if t.tint ~= nil then
            inst.AnimState:SetMultColour(t.tint.x, t.tint.y, t.tint.z, t.tintalpha or 1)
        elseif t.tintalpha ~= nil then
            inst.AnimState:SetMultColour(t.tintalpha, t.tintalpha, t.tintalpha, t.tintalpha)
        end
        --print(inst.AnimState:GetMultColour())
        if t.transform ~= nil then
            inst.AnimState:SetScale(t.transform:Get())
        end

        if t.nameoverride ~= nil then
            if inst.components.inspectable == nil then
                inst:AddComponent("inspectable")
            end
            inst.components.inspectable.nameoverride = t.nameoverride
            inst.name = t.nameoverride
        end

        if t.description ~= nil then
            if inst.components.inspectable == nil then
                inst:AddComponent("inspectable")
            end
            inst.components.inspectable.descriptionfn = t.description
        end

        if t.bloom then
            inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
        end

		if t.animqueue then
	        inst:ListenForEvent("animqueueover", inst.Remove)
	    else
	        inst:ListenForEvent("animover", inst.Remove)
	    end

        if t.fn ~= nil then
            if t.fntime ~= nil then
                inst:DoTaskInTime(t.fntime, t.fn)
            else
                t.fn(inst)
            end
        end

        if t.twofaced then
            inst.Transform:SetTwoFaced()
        elseif t.eightfaced then
            inst.Transform:SetEightFaced()
        elseif t.sixfaced then
            inst.Transform:SetSixFaced()
        elseif not t.nofaced then
            inst.Transform:SetFourFaced()
        end

        inst:AddTag("FX")

        return inst
    end

    return Prefab(t.name, fn, assets)
end

local prefs = {}
local fx = require("anr_fx")

for k, v in pairs(fx) do
    table.insert(prefs, MakeFx(v))
end

return unpack(prefs)

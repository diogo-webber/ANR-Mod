local trunkassets =
{
    Asset("ANIM", "anim/petrified_trunk_break.zip"),
}

local treeassets =
{
    Asset("ANIM", "anim/petrified_tree_fx.zip"),
}

local function SerializeDarken(inst, r, g, b)--, a)
    inst._darken = math.clamp(math.floor(14 * (r + g + b) / 3 - 6.5), 0, 7)
end

local function DeserializeDarken(inst)
    local val = inst._darken / 14 + .5
    return val, val, val, 1
end

local function SetDarkened(inst, val)
    inst._darken = math.clamp(math.floor((2 * val - 1) * 7 + .5), 0, 7)
end

local function makefx(assetname, animname, soundname)
    return function()
        local inst = CreateEntity()

        inst:AddTag("FX")
        --[[Non-networked entity]]
        inst.entity:SetCanSleep(false)
        inst.persists = false
    
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()

        inst._darken = 7
   
        inst.AnimState:SetBank(assetname)
        inst.AnimState:SetBuild(assetname)
        inst.AnimState:PlayAnimation(animname)
        inst.AnimState:SetMultColour(DeserializeDarken(inst))
        inst.AnimState:SetFinalOffset(1)
    
        inst.SoundEmitter:PlaySound("dontstarve/common/together/petrified/"..soundname)
    
        inst:ListenForEvent("animover", inst.Remove)

        inst.InheritColour = SerializeDarken

        return inst
    end
end

local ret = { Prefab("petrified_trunk_break_fx", makefx("petrified_trunk_break", "break_apart", "post_stump"), trunkassets) }
for i, v in ipairs({ "_short", "_normal", "_tall", "_old" }) do
    table.insert(ret, Prefab("petrified_tree_fx"..v, makefx("petrified_tree_fx", "rock_scatter"..v, "post"), treeassets))
end
return unpack(ret)

local assets = 
{
	Asset("ANIM", "anim/wilson.zip"),
	Asset("ANIM", "anim/willow.zip"),
	Asset("ANIM", "anim/waxwell.zip"),
	Asset("ANIM", "anim/player_basic.zip"),
	Asset("ANIM", "anim/player_throne.zip"),
	Asset("ANIM", "anim/wilson_fx.zip"),
}

local function SetCharacter(inst, char)
	inst.char = char == "waxwell" and "maxwell" or char
	inst.AnimState:PlayAnimation("idle", true)
	inst.AnimState:SetBuild(char)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddSoundEmitter()
	inst.entity:AddAnimState()
    inst.entity:AddDynamicShadow()

	inst.char = "wilson"

    inst.DynamicShadow:SetSize( 1.3, .6 )

	inst.AnimState:SetBank("wilson")
	inst.AnimState:SetBuild("wilson")

	inst.AnimState:Hide("ARM_carry")
	inst.AnimState:Hide("hat")
	inst.AnimState:Hide("hat_hair")
	inst.AnimState:OverrideSymbol("fx_wipe", "wilson_fx", "fx_wipe")
	inst.AnimState:OverrideSymbol("fx_liquid", "wilson_fx", "fx_liquid")
	inst.AnimState:OverrideSymbol("shadow_hands", "shadow_hands", "shadow_hands")

	inst.Transform:SetFourFaced()

	inst:AddComponent("talker")
	
	inst.SetCharacter = SetCharacter

    inst.persists = false

    return inst
end

return Prefab("puppet_cutscene", fn, assets)

local assets = 
{
	Asset("ANIM", "anim/wilson.zip"),
	Asset("ANIM", "anim/shadow_skinchangefx.zip"),
}

local SymbolsToHide = 
{
    "hand",
    "hand",
    "tail",
    "torso",
    "torso_pelvis",
    "leg",
    "skirt",
	"arm_upper",
	"arm_upper_skin",
	"arm_lower",
	"arm_lower_cuff",
	"face",
	"swap_face",
	"hair",
	"hair_hat",
	"hair_front",
	"hair_front",
	"headbase",
	"headbase_hat",
    "foot",
    "hairpigtails",
    "hairfront",
    "torso_pelvis_wide",
    "torso_wide",
    "cheeks",
    "swap_object",
    "swap_hat",
    "swap_body",
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
	inst.entity:AddAnimState()

	inst.AnimState:SetBank("wilson")
	inst.AnimState:SetBuild("wilson")

	inst.AnimState:OverrideSymbol("shadow_hands", "shadow_skinchangefx", "shadow_hands")
	inst.AnimState:OverrideSymbol("shadow_ball", "shadow_skinchangefx", "shadow_ball")
	inst.AnimState:OverrideSymbol("splode", "shadow_skinchangefx", "splode")
	
	for k,v in ipairs(SymbolsToHide) do
		inst.AnimState:HideSymbol(v)
	end

	inst.AnimState:PlayAnimation("skin_change", false)

	inst.Transform:SetFourFaced()

	inst:ListenForEvent("animover", inst.Remove)
    inst.persists = false

    return inst
end

return Prefab("explode_shadow_skin", fn, assets)

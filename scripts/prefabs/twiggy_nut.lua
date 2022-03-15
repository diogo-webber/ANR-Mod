require "prefabutil"

local notags = {'NOBLOCK', 'player', 'FX'}
local function test_ground(inst, pt)
	local ground_OK = inst:GetIsOnLand(pt.x, pt.y, pt.z)
	local tiletype = GetGroundTypeAtPosition(pt)
	ground_OK = ground_OK and 
						tiletype ~= GROUND.ROCKY and tiletype ~= GROUND.ROAD and tiletype ~= GROUND.IMPASSABLE and tiletype ~= GROUND.INTERIOR and
						tiletype ~= GROUND.UNDERROCK and tiletype ~= GROUND.WOODFLOOR and 
						tiletype ~= GROUND.CARPET and tiletype ~= GROUND.CHECKER and tiletype < GROUND.UNDERGROUND
	
	if ground_OK then
	    local ents = TheSim:FindEntities(pt.x,pt.y,pt.z, 4, nil, notags) -- or we could include a flag to the search?
		local min_spacing = inst.components.deployable.min_spacing or 2

	    for k, v in pairs(ents) do
			if v ~= inst and v:IsValid() and v.entity:IsVisible() and not v.components.placer and v.parent == nil then
				if distsq( Vector3(v.Transform:GetWorldPosition()), pt) < min_spacing*min_spacing then
					return false
				end
			end
		end
		return true
	end
	return false
end

local function plant(inst, growtime)
    local sapling = SpawnPrefab(inst._spawn_prefab or "pinecone_sapling")
    sapling:StartGrowing()
    sapling.Transform:SetPosition(inst.Transform:GetWorldPosition())
    sapling.SoundEmitter:PlaySound("dontstarve/wilson/plant_tree")
    inst:Remove()
end

local function ondeploy(inst, pt, deployer)
    inst = inst.components.stackable:Get()
    inst.Physics:Teleport(pt:Get())
    local timeToGrow = GetRandomWithVariance(TUNING.PINECONE_GROWTIME.base, TUNING.PINECONE_GROWTIME.random)
    plant(inst, timeToGrow)
end

local function OnLoad(inst, data)
    if data ~= nil and data.growtime ~= nil then
        plant(inst, data.growtime)
    end
end

local function addcone(name, spawn_prefab, bank, build, anim)
    local assets =
    {
        Asset("ANIM", "anim/"..build..".zip"),
    }
    if bank ~= build then
        table.insert(assets, Asset("ANIM", "anim/"..bank..".zip"))
    end

    local prefabs =
    {
        spawn_prefab,
    }

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()

        MakeInventoryPhysics(inst)

        inst.AnimState:SetBank(bank)
        inst.AnimState:SetBuild(build)
        inst.AnimState:PlayAnimation("idle")

        inst:AddTag("deployedplant")
        inst:AddTag("cattoy")
        inst:AddTag("treeseed")

        --MakeInventoryFloatable(inst, "small", 0.05, 0.9)

        inst._spawn_prefab = spawn_prefab

        inst:AddComponent("tradable")

        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

        inst:AddComponent("inspectable")

        inst:AddComponent("fuel")
        inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL

        MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
        MakeSmallPropagator(inst)

        inst:AddComponent("inventoryitem")

        MakeHauntableLaunchAndIgnite(inst)

        inst:AddComponent("deployable")
        inst.components.deployable.test = test_ground
        inst.components.deployable.ondeploy = ondeploy

        --inst:AddComponent("forcecompostable") --Leo: Compost
        --inst.components.forcecompostable.brown = true

        -- This is left in for "save file upgrading", June 3 2015. We can remove it after some time.
        inst.OnLoad = OnLoad

        return inst
    end

    return
    Prefab(name, fn, assets, prefabs),
    MakePlacer(name.."_placer", bank, build, anim)
end

return addcone("twiggy_nut", "twiggy_nut_sapling", "twiggy_nut", "twiggy_nut", "idle_planted")


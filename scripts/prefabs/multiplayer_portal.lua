local assets_stone =
{
    Asset("ANIM", "anim/portal_stone.zip"),
    Asset("ANIM", "anim/portal_dst.zip"),
    Asset("MINIMAP_IMAGE", "portal_dst"),
}

local assets_construction =
{
    Asset("ANIM", "anim/portal_stone_construction.zip"),
    Asset("ANIM", "anim/portal_stone.zip"),
    Asset("ANIM", "anim/ui_construction_4x1.zip"),
    Asset("MINIMAP_IMAGE", "portal_dst"),
}

local assets_moonrock =
{
    Asset("ANIM", "anim/portal_moonrock.zip"),
    Asset("ANIM", "anim/portal_stone.zip"),
    Asset("MINIMAP_IMAGE", "portal_dst"),
}

local assets_fx =
{
    Asset("ANIM", "anim/portal_moonrock.zip"),
    Asset("ANIM", "anim/portal_stone.zip"),
}

local prefabs_construction =
{
    "multiplayer_portal_moonrock",
    "construction_container",
}

local prefabs_moonrock =
{
    "multiplayer_portal_moonrock_fx",
}

local function OnRezPlayer(inst)
    if not inst.sg:HasStateTag("construction") then
        inst.sg:GoToState("spawn_pre")
    end
end
local function CutScene(inst)
    inst:DoTaskInTime(0, function()
        local ismaxwell = GetPlayer().prefab == "waxwell"
        local iswilson = GetPlayer().prefab == "wilson"

        local stringtable = iswilson and STRINGS.ANR_CUTSCENE.WILSON or ismaxwell and STRINGS.ANR_CUTSCENE.MAXWELL or STRINGS.ANR_CUTSCENE.GENERIC

		TheCamera:SetTarget(GetPlayer())
		TheCamera:SetDefault()
		TheCamera:Snap()

        GetPlayer().sg:GoToState("idle")
        GetPlayer():Hide()
        GetPlayer().DynamicShadow:Enable(false)
        GetPlayer().components.playercontroller:Enable(false)
        GetPlayer().components.talker:IgnoreAll()

        inst.AnimState:SetBank("portal_dst_preconstruct")
        inst.AnimState:SetBuild("portal_dst")
        local portalfx = SpawnAt("multiplayer_portal_preconstruct_fx", inst)
        inst.AnimState:Hide("portaldoormagic_cycle")
        inst.AnimState:Hide("eye")
        inst.AnimState:Hide("shadow_arm_lower")
        inst.AnimState:Hide("shadow_arm_upper")
        inst.AnimState:Hide("shadow_hand")
        inst.AnimState:Pause()

        local puppet1 = SpawnPrefab("puppet_cutscene")
        puppet1:SetCharacter(iswilson and "willow" or "wilson")

        local puppet2 = SpawnPrefab("puppet_cutscene")
        puppet2:SetCharacter(ismaxwell and "willow" or "waxwell")

        local pt = Vector3( GetPlayer().Transform:GetWorldPosition()) - TheCamera:GetRightVec()*4
        puppet1.Transform:SetPosition(pt.x,pt.y,pt.z)
        puppet1:FacePoint( GetPlayer().Transform:GetWorldPosition())

        puppet1.AnimState:PlayAnimation("build_pre")
        puppet1.AnimState:PushAnimation("build_loop", true)

        GetPlayer():DoTaskInTime(0.1, function()
            local pt = Vector3( GetPlayer().Transform:GetWorldPosition()) + TheCamera:GetRightVec()*4
            puppet2.Transform:SetPosition(pt.x,pt.y,pt.z)
            puppet2:FacePoint( GetPlayer().Transform:GetWorldPosition())

            puppet2.AnimState:PlayAnimation("construct_pre")
            puppet2.AnimState:PushAnimation("construct_loop")
        end)

        GetPlayer():DoTaskInTime(1, function()
            puppet2.components.talker:Say(stringtable.PUPPET2[1])
            puppet2.SoundEmitter:PlaySound("dontstarve/characters/"..puppet2.char.."/talk_LP", "talk")
        end)

        GetPlayer():DoTaskInTime(3.5, function()
            puppet1.components.talker:Say(stringtable.PUPPET1[1])
            puppet1.SoundEmitter:PlaySound("dontstarve/characters/"..puppet1.char.."/talk_LP", "talk")
            puppet2.SoundEmitter:KillSound("talk")
        end)

        GetPlayer():DoTaskInTime(6, function()
            puppet1.SoundEmitter:KillSound("talk")
        end)

        GetPlayer():DoTaskInTime(7, function()
            portalfx:Disappear()
            inst.AnimState:Resume()
            inst.AnimState:Show("eye")
            inst.AnimState:Show("shadow_arm_lower")
            inst.AnimState:Show("shadow_arm_upper")
            inst.AnimState:Show("shadow_hand")

            puppet2.components.talker:Say(stringtable.PUPPET2[2])
            puppet2.SoundEmitter:PlaySound("dontstarve/characters/"..puppet2.char.."/talk_LP", "talk")
            puppet2.AnimState:PlayAnimation("construct_pst")
            puppet2.AnimState:PushAnimation("idle_loop", true)

            puppet1.components.talker:Say(stringtable.PUPPET1[2])
            puppet1.SoundEmitter:PlaySound("dontstarve/characters/"..puppet1.char.."/talk_LP", "talk")
            puppet1.AnimState:PlayAnimation("build_pst")
            puppet1.AnimState:PushAnimation("idle_loop", true)
        end)

        GetPlayer():DoTaskInTime(7.5, function()
            puppet1.SoundEmitter:KillSound("talk")
        end)

        GetPlayer():DoTaskInTime(8, function()
            puppet2.components.talker:Say(stringtable.PUPPET2[3])

            puppet1.AnimState:PlayAnimation("construct_pre")
            puppet1.AnimState:PushAnimation("construct_loop")
            puppet1.AnimState:PushAnimation("construct_pst")
            puppet1.AnimState:PushAnimation("idle_loop", true)
        end)

        GetPlayer():DoTaskInTime(8.5, function()
            inst.sg:GoToState("preconstruct_transform")
            SpawnAt("explode_shadow_skin", inst).Transform:SetScale(2.5,3.25,3)        
        end)

        GetPlayer():DoTaskInTime(9.5, function()
            puppet2.SoundEmitter:KillSound("talk")
        end)

        GetPlayer():DoTaskInTime(10, function()
            puppet2.AnimState:PlayAnimation("teleport")
            puppet2.DynamicShadow:Enable(false)
            puppet2:DoTaskInTime(0, function() inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_pulled") end)
            puppet2:DoTaskInTime(2.8, function() inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_under") end)

            puppet2.components.talker:Say(stringtable.PUPPET2[4])
            puppet2.SoundEmitter:PlaySound("dontstarve/characters/"..puppet2.char.."/talk_LP", "talk")
        end)
    
        GetPlayer():DoTaskInTime(10.5, function()
            puppet1.AnimState:PlayAnimation("teleport")
            puppet1.DynamicShadow:Enable(false)
            puppet1:DoTaskInTime(0, function() inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_pulled") end)
            puppet1:DoTaskInTime(2.8, function() inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_under") end)

            puppet1.components.talker:Say(stringtable.PUPPET1[3])
            puppet1.SoundEmitter:PlaySound("dontstarve/characters/"..puppet1.char.."/talk_LP", "talk")
        end)

        GetPlayer():DoTaskInTime(12, function()
            puppet2.SoundEmitter:KillSound("talk")
            puppet1.SoundEmitter:KillSound("talk")
        end)
           
        GetPlayer():DoTaskInTime(13.5, function()
            puppet2:Remove()
            puppet1:Remove()
        end)
    end)
end

local function MakePortal(name, bank, build, assets, prefabs, common_postinit, master_postinit)
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddMiniMapEntity()

        inst.MiniMapEntity:SetIcon("portal_dst.png")

        inst.AnimState:SetBank(bank)
        inst.AnimState:SetBuild(build)
        inst.AnimState:PlayAnimation("idle_loop", true)

        inst:AddTag("multiplayer_portal")
        inst:AddTag("antlion_sinkhole_blocker")

        --inst:SetDeployExtraSpacing(2)
        GetWorld().spawnportal = inst

        if common_postinit ~= nil then
            common_postinit(inst)
        end

        inst:SetStateGraph("SGmultiplayerportal")

        inst:AddComponent("inspectable")
        inst.components.inspectable:RecordViews()
        
        inst:AddComponent("colourtweener")

        inst:AddComponent("hauntable")
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_INSTANT_REZ)
        inst:AddTag("resurrector")
        
        inst:ListenForEvent("ms_newplayercharacterspawned", function(world)
            GetPlayer().AnimState:SetMultColour(0, 0, 0, 1)
            GetPlayer():Hide()
            GetPlayer().components.playercontroller:Enable(false)
            GetPlayer():DoTaskInTime(12 * FRAMES, function(inst)
                GetPlayer():Show()
                GetPlayer():DoTaskInTime(60 * FRAMES, function(inst)
                    inst.components.colourtweener:StartTween({ 1, 1, 1, 1 }, 14 * FRAMES, function(inst)
                        GetPlayer().components.talker:StopIgnoringAll()
                        GetPlayer().components.playercontroller:Enable(true)
                        GetPlayer().HUD:Show()
                        GetPlayer().DynamicShadow:Enable(true)
                    end, true)
                end)
            end)
            if not inst.sg:HasStateTag("construction") then
                inst.sg:GoToState("spawn_loop", true)
            end
        end, GetWorld())

        inst:ListenForEvent("rez_player", OnRezPlayer)

        if master_postinit ~= nil then
            master_postinit(inst)
        end

        return inst
    end

    return Prefab(name, fn, assets, prefabs)
end

local STONE_SOUNDS =
{
    idle_loop = "dontstarve/common/together/spawn_vines/spawnportal_idle_LP",
    idle = "dontstarve/common/together/spawn_vines/spawnportal_idle",
    scratch = "dontstarve/common/together/spawn_vines/spawnportal_scratch",
    jacob = "dontstarve/common/together/spawn_vines/spawnportal_jacob",
    blink = "dontstarve/common/together/spawn_vines/spawnportal_blink",
    vines = "dontstarve/common/together/spawn_vines/vines",
    spawning_loop = "dontstarve/common/together/spawn_vines/spawnportal_spawning",
    armswing = "dontstarve/common/together/spawn_vines/spawnportal_armswing",
    shake = "dontstarve/common/together/spawn_vines/spawnportal_shake",
    open = "dontstarve/common/together/spawn_vines/spawnportal_open",
    glow_loop = nil,
    shatter = nil,
    place = nil,
    transmute_pre = nil,
    transmute = nil,
}

local function stone_common_postinit(inst)
    inst.sounds = STONE_SOUNDS
end

local function stone_master_postinit(inst)
    if not GetWorld():HasTag("cave") then
        inst.OnSave = function(inst, data)
            data.playercutscene = inst.playercutscene or false
        end
        inst.OnLoad = function(inst, data)
            inst.playercutscene = data and data.playercutscene or false
            if not inst.playercutscene then
                CutScene(inst)
            end
        end
    end
end

local function construction_common_postinit(inst)
    inst.AnimState:Hide("stage2")
    inst.AnimState:Hide("stage3")
    inst.AnimState:AddOverrideBuild("portal_stone_construction")
    inst.AnimState:OverrideSymbol("portal_moonrock", "portal_moonrock", "portal_moonrock")
    inst.AnimState:OverrideSymbol("curtains", "portal_moonrock", "curtains")

    if GetWorld():HasTag("cave") then
        inst.AnimState:Hide("eyefx")
    else
        inst.AnimState:OverrideSymbol("glow", "portal_moonrock", "glow")
    end

    --constructionsite (from constructionsite component) added to pristine state for optimization
    inst:AddTag("constructionsite")

    inst.constructionname = "multiplayer_portal_moonrock"
    inst:SetPrefabNameOverride("multiplayer_portal")

    inst.sounds = {
        idle_loop = nil,
        idle = "dontstarve/common/together/spawn_vines/spawnportal_idle",
        scratch = nil,
        jacob = "dontstarve/common/together/spawn_vines/spawnportal_jacob",
        blink = nil,
        vines = "dontstarve/common/together/spawn_vines/vines",
        spawning_loop = "dontstarve/common/together/spawn_vines/spawnportal_spawning",
        armswing = nil,
        shake = "dontstarve/common/together/spawn_vines/spawnportal_shake",
        open = "dontstarve/common/together/spawn_vines/spawnportal_open",
        glow_loop = "dontstarve/common/together/spawn_vines/spawnportal_spawning",
        shatter = "dontstarve/common/together/spawn_vines/spawnportal_open",
        place = "dontstarve/common/together/spawn_portal_celestial/reveal",
        transmute_pre = "dontstarve/common/together/spawn_portal_celestial/cracking",
        transmute = "dontstarve/common/together/spawn_portal_celestial/shatter",
    }
end

local function OnStartConstruction(inst)
    inst.sg:GoToState("placeconstruction")
end

local function CalculateConstructionPhase(inst)
    --single ingredients worth one phase each
    --remaining ingredient stacks worth percentage of remaining phases
    local singles_amount = 0
    local singles_total = 0
    local amount = 0
    local total = 0
    for i, v in ipairs(CONSTRUCTION_PLANS[inst.prefab] or {}) do
        if v.amount > 1 then
            amount = amount + inst.components.constructionsite:GetMaterialCount(v.type)
            total = total + v.amount
        else
            singles_amount = singles_amount + inst.components.constructionsite:GetMaterialCount(v.type)
            singles_total = singles_total + 1
        end
    end
    return (total > 0 and math.clamp(singles_amount + math.floor((3 - singles_total) * amount / total) + 1, 1, 4))
        or (singles_total > 0 and math.clamp(math.floor(3 * singles_amount / singles_total) + 1, 1, 4))
        or 1
end

local function OnConstructed(inst, doer)
    local amount = 0
    local total = 0
    for i, v in ipairs(CONSTRUCTION_PLANS[inst.prefab] or {}) do
        amount = amount + inst.components.constructionsite:GetMaterialCount(v.type)
        total = total + v.amount
    end
    inst.sg.mem.targetconstructionphase = CalculateConstructionPhase(inst)
    if not (inst.sg:HasStateTag("busy") or inst.sg:HasStateTag("open")) then
        inst.sg:GoToState(inst.sg.mem.constructionphase >= 3 and inst.sg.mem.targetconstructionphase >= 4 and "constructionphase4" or "constructed")
    end
end

local function construction_onload(inst)--, data, newents)
    inst.sg.mem.targetconstructionphase = CalculateConstructionPhase(inst)
    inst.sg.mem.constructionphase = math.min(3, inst.sg.mem.targetconstructionphase)
    for i = 1, 3 do
        if i == inst.sg.mem.constructionphase then
            inst.AnimState:Show("stage"..tostring(i))
        else
            inst.AnimState:Hide("stage"..tostring(i))
        end
    end
    if inst.sg.mem.constructionphase == 3 then
        inst.AnimState:Hide("hidestage3")
        inst.sounds.vines = nil
    else
        inst.AnimState:Show("hidestage3")
    end
    if inst.sg.mem.targetconstructionphase ~= inst.sg.mem.constructionphase then
        inst.sg:GoToState("constructionphase"..tostring(inst.sg.mem.targetconstructionphase))
    end
end

local function construction_master_postinit(inst)
    inst.sg.mem.nofunny = true
    inst.sg.mem.constructionphase = 1
    inst.sg.mem.targetconstructionphase = 1

    inst:AddComponent("constructionsite")
    inst.components.constructionsite:SetConstructionPrefab("construction_container")
    inst.components.constructionsite:SetOnConstructedFn(OnConstructed)

    inst:ListenForEvent("onstartconstruction", OnStartConstruction)

    inst.OnLoad = construction_onload
end

local MOONROCK_SOUNDS =
{
    idle_loop = nil,
    idle = "dontstarve/common/together/spawn_vines/spawnportal_idle",
    scratch = nil,
    jacob = "dontstarve/common/together/spawn_vines/spawnportal_jacob",
    blink = nil,
    vines = nil,
    spawning_loop = "dontstarve/common/together/spawn_vines/spawnportal_spawning",
    armswing = nil,
    shake = "dontstarve/common/together/spawn_vines/spawnportal_shake",
    open = "dontstarve/common/together/spawn_vines/spawnportal_open",
    glow_loop = nil,
    shatter = nil,
    place = nil,
    transmute_pre = nil,
    transmute = nil,
}

local function moonrock_common_postinit(inst)
    inst.AnimState:OverrideSymbol("portaldoormagic_cycle", "portal_stone", "portaldoormagic_cycle")
    inst.AnimState:OverrideSymbol("portalbg", "portal_stone", "portalbg")
    inst.AnimState:OverrideSymbol("spiralfx", "portal_stone", "spiralfx")

    if GetWorld():HasTag("cave") then
        inst.AnimState:OverrideSymbol("FX_ray", "portal_stone", "FX_ray")
        inst.AnimState:Hide("eyefx")
    else
        inst.AnimState:SetLightOverride(.04)
        inst.AnimState:Hide("eye")
        inst.AnimState:Hide("eyefx")
        inst.AnimState:Hide("FX_rays")

        inst:AddTag("moonportal")
    end

    --moontrader (from moontrader component) added to pristine state for optimization
    inst:AddTag("moontrader")

    inst.fx = not GetWorld():HasTag("cave") and SpawnPrefab("multiplayer_portal_moonrock_fx") or nil
    inst.sounds = MOONROCK_SOUNDS
end

local function moonrock_onsleep(inst)
    if inst._task ~= nil then
        inst._task:Cancel()
        inst._task = nil
    end
end

local MOONPORTALKEY_TAGS = { "moonportalkey" }
local function moonrock_onupdate(inst, instant)
    local x, y, z = inst.Transform:GetWorldPosition()
    for i, v in ipairs(TheSim:FindEntities(x, y, z, 8, MOONPORTALKEY_TAGS)) do
        v:PushEvent("ms_moonportalproximity", { instant = instant })
    end
end

local function moonrock_onwake(inst)
    if inst._task == nil then
        inst._task = inst:DoPeriodicTask(1, moonrock_onupdate)
        moonrock_onupdate(inst, true)
    end
end

local function moonrock_canaccept(inst, item)--, giver)
    if not item:HasTag("moonportalkey") then
        return false
    elseif GetWorld():HasTag("cave") then
        return false, "NOMOON"
    end
    return true
end

local function moonrock_onaccept(inst, giver)--, item)
    giver:PushEvent("ms_playerreroll")
    if giver.components.inventory ~= nil then
        giver.components.inventory:DropEverything()
    end

	if giver.components.leader ~= nil then
		local followers = giver.components.leader.followers
		for k, v in pairs(followers) do
			if k.components.inventory ~= nil then
				k.components.inventory:DropEverything()
			elseif k.components.container ~= nil then
				k.components.container:DropEverything()
			end
		end
	end

    inst._savedata[giver.userid] = giver.SaveForReroll ~= nil and giver:SaveForReroll() or nil
end

local function moonrock_onsave(inst, data)
    data.players = next(inst._savedata) ~= nil and inst._savedata or nil
end

local function moonrock_onload(inst, data)
    inst._savedata = data ~= nil and data.players or inst._savedata
end

local function moonrock_master_postinit(inst)
    inst:AddComponent("moontrader")
    inst.components.moontrader:SetCanAcceptFn(moonrock_canaccept)
    inst.components.moontrader:SetOnAcceptFn(moonrock_onaccept)

    if not GetWorld():HasTag("cave") then
        inst.fx.entity:SetParent(inst.entity)
        inst._task = nil
        inst._savedata = {}
        inst.OnEntitySleep = moonrock_onsleep
        inst.OnEntityWake = moonrock_onwake
        inst.OnSave = moonrock_onsave
        inst.OnLoad = moonrock_onload
    end
end

local function moonrockfxfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    inst.AnimState:SetBank("portal_moonrock_dst")
    inst.AnimState:SetBuild("portal_moonrock")
    inst.AnimState:PlayAnimation("idle_loop", true)
    inst.AnimState:Hide("portal")
    inst.AnimState:OverrideSymbol("FX_ray", "portal_stone", "FX_ray")
    inst.AnimState:SetLightOverride(.2)

    inst:AddTag("FX")

    inst.persists = false

    return inst
end

local function constructfxfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    inst.AnimState:SetBank("portal_construction_dst")
    inst.AnimState:SetBuild("portal_stone_construction")
    inst.AnimState:PlayAnimation("idle_loop", true)
    inst.AnimState:Hide("stage2")
    inst.AnimState:Hide("stage3")
    inst.AnimState:Hide("eye")
    inst.AnimState:HideSymbol("peak")
    inst.AnimState:HideSymbol("op_gem")
    inst.AnimState:HideSymbol("lunar_mote")
    inst.AnimState:HideSymbol("glow_fx02")
    inst:AddTag("FX")

    inst.Disappear = function()
        inst.AnimState:PlayAnimation("final_reveal")
        inst:DoTaskInTime(1, inst.Remove)
    end

    inst.persists = false

    return inst
end

return MakePortal("multiplayer_portal", "portal_dst", "portal_stone", assets_stone, nil, stone_common_postinit, stone_master_postinit),
    MakePortal("multiplayer_portal_moonrock_constr", "portal_construction_dst", "portal_stone", assets_construction, prefabs_construction, construction_common_postinit, construction_master_postinit),
    MakePortal("multiplayer_portal_moonrock", "portal_moonrock_dst", "portal_moonrock", assets_moonrock, prefabs_moonrock, moonrock_common_postinit, moonrock_master_postinit),
    Prefab("multiplayer_portal_moonrock_fx", moonrockfxfn, assets_fx),
    Prefab("multiplayer_portal_preconstruct_fx", constructfxfn, assets_construction)

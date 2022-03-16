--------------------------------------------------------------------------
-- This file exists because player_common got too big for lua.
-- It had too may local variables and functions.
--------------------------------------------------------------------------

local screen_fade_time = .4

--------------------------------------------------------------------------
-- Component Callback Functions
--------------------------------------------------------------------------

local function ShouldKnockout(inst)
    return DefaultKnockoutTest(inst) and not inst.sg:HasStateTag("yawn")
end

--[[ local function GetHopDistance(inst, speed_mult)
	return speed_mult < 0.8 and TUNING.WILSON_HOP_DISTANCE_SHORT
			or speed_mult >= 1.2 and TUNING.WILSON_HOP_DISTANCE_FAR
			or TUNING.WILSON_HOP_DISTANCE
end
 ]]
local function ConfigurePlayerLocomotor(inst)
    inst.components.locomotor:SetSlowMultiplier(0.6)
    inst.components.locomotor.pathcaps = { player = true, ignorecreep = true } -- 'player' cap not actually used, just useful for testing
    inst.components.locomotor.walkspeed = TUNING.WILSON_WALK_SPEED -- 4
    inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED -- 6
    inst.components.locomotor.fasteronroad = true
    --inst.components.locomotor:SetFasterOnCreep(inst:HasTag("spiderwhisperer")) -- Webber rework
    inst.components.locomotor:SetTriggersCreep(not inst:HasTag("spiderwhisperer"))
    -- inst.components.locomotor:SetAllowPlatformHopping(true) --RoT
	-- inst.components.locomotor.hop_distance_fn = GetHopDistance --RoT
end

local function ConfigureGhostLocomotor(inst)
    inst.components.locomotor:SetSlowMultiplier(0.6)
    inst.components.locomotor.pathcaps = { player = true, ignorecreep = true } -- 'player' cap not actually used, just useful for testing
    inst.components.locomotor.walkspeed = TUNING.WILSON_WALK_SPEED -- 4 is base
    inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED -- 6 is base
    inst.components.locomotor.fasteronroad = false
    -- inst.components.locomotor:SetTriggersCreep(false) --RoT
    -- inst.components.locomotor:SetAllowPlatformHopping(false) --RoT
end

--------------------------------------------------------------------------
-- Death and Ghost Functions
--------------------------------------------------------------------------

--Pushed/popped when dying/resurrecting
local function GhostActionFilter(inst, action)
    return action.ghost_valid
end

local function RemoveDeadPlayer(inst, spawnskeleton)
    if spawnskeleton and inst.skeleton_prefab ~= nil then
        local x, y, z = inst.Transform:GetWorldPosition()

        -- Spawn a skeleton
        local skel = SpawnPrefab(inst.skeleton_prefab)
        if skel ~= nil then
            skel.Transform:SetPosition(x, y, z)
            -- Set the description
            --skel:SetSkeletonDescription(inst.prefab, inst:GetDisplayName(), inst.deathcause, inst.deathpkname, inst.userid)
            --skel:SetSkeletonAvatarData(inst.deathclientobj)
        end

        -- Death FX
        SpawnPrefab("die_fx").Transform:SetPosition(x, y, z)
    end

    local followers = inst.components.leader.followers
    for k, v in pairs(followers) do
        if k.components.inventory ~= nil then
            k.components.inventory:DropEverything()
        elseif k.components.container ~= nil then
            k.components.container:DropEverything()
        end
    end

    inst:OnDespawn()
    DeleteUserSession(inst)
    inst:Remove()
end

local function FadeOutDeadPlayer(inst, spawnskeleton)
    inst:ScreenFade(false, screen_fade_time, true)
    inst:DoTaskInTime(screen_fade_time * 1.25, RemoveDeadPlayer, spawnskeleton)
end

--Player has completed death sequence
local function OnPlayerDied(inst, data)
    inst:DoTaskInTime(3, FadeOutDeadPlayer, data ~= nil and data.skeleton)
end

--Player has initiated death sequence
local function OnPlayerDeath(inst, data)
    if inst:HasTag("playerghost") then
        --ghosts should not be able to die atm
        return
    end

    inst:ClearBufferedAction()

    inst.HUD.controls.inv:Hide()
    inst.HUD.controls.crafttabs:Hide()

    inst:PushEvent("ms_closepopups")

    inst.deathcause = data ~= nil and data.cause or "unknown"
	inst.last_death_position = Vector3(inst.Transform:GetWorldPosition())

    if data == nil or data.afflicter == nil then
        inst.deathpkname = nil
    elseif data.afflicter.overridepkname ~= nil then
        inst.deathpkname = data.afflicter.overridepkname
        inst.deathbypet = data.afflicter.overridepkpet
    else
        local killer = data.afflicter.components.follower ~= nil and data.afflicter.components.follower:GetLeader() or nil
        if killer ~= nil and
            killer.components.petleash ~= nil and
            killer.components.petleash:IsPet(data.afflicter) then
            inst.deathbypet = true
        else
            killer = data.afflicter
        end
        inst.deathpkname = killer:HasTag("player") and killer:GetDisplayName() or nil
    end

    if not inst.ghostenabled and inst.components.revivablecorpse == nil then
        if inst.deathcause ~= "file_load" then
            local will_resurrect = inst.components.resurrectable and inst.components.resurrectable:CanResurrect() 
            Morgue:OnDeath({killed_by=inst.deathcause, 
                            days_survived=GetClock().numcycles or 0,
                            character=GetPlayer().prefab, 
                            location= (inst.components.area_aware and inst.components.area_aware.current_area.story) or "unknown", 
                            world= (GetWorld().meta and GetWorld().meta.level_id) or "unknown"})
    
            local game_time = GetClock():ToMetricsString()
            
            RecordDeathStats(inst.deathcause, GetClock():GetPhase(), inst.components.sanity.current, inst.components.hunger.current, will_resurrect)
    
            ProfileStatsAdd("killed_by_"..inst.deathcause)
            ProfileStatsAdd("deaths")
        end
    end

    inst:DoTaskInTime(1.5, function()
        inst:PushEvent("makeplayerghost") -- if we are not on valid ground then don't drop a skeleton -- { skeleton = GetWorld().Map:IsPassableAtPoint(inst.Transform:GetWorldPosition()) }
    end)
end

local function CommonActualRez(inst)
    --inst.player_classified.MapExplorer:EnableUpdate(true)

    inst.HUD.controls.inv:Show()
    inst.HUD.controls.crafttabs:Show()

    inst.components.health.canheal = true
    inst.components.hunger:Resume()
    inst.components.temperature:SetTemp() --nil param will resume temp
    inst.components.frostybreather:Enable()

    MakeMediumBurnableCharacter(inst, "torso")
    inst.components.burnable:SetBurnTime(TUNING.PLAYER_BURN_TIME)
    inst.components.burnable.nocharring = true

    MakeLargeFreezableCharacter(inst, "torso")
    inst.components.freezable:SetResistance(4)
    inst.components.freezable:SetDefaultWearOffTime(TUNING.PLAYER_FREEZE_WEAR_OFF_TIME)

    --inst:AddComponent("grogginess")
    --inst.components.grogginess:SetResistance(3)
    --inst.components.grogginess:SetKnockOutTest(ShouldKnockout)

    inst.components.moisture:ForceDry(false, inst)

    --inst.components.sheltered:Start()

    inst.components.debuffable:Enable(true)

    --don't ignore sanity any more
    inst.components.sanity.ignore = false

    inst.components.talker.offset = nil

    ConfigurePlayerLocomotor(inst)

    inst.rezsource = nil
    inst.remoterezsource = nil

	inst.last_death_position = nil
	inst.last_death_shardid = nil

	inst:RemoveTag("reviving")
end

local function DoActualRez(inst, source, item)
    local x, y, z
    if source ~= nil then
        x, y, z = source.Transform:GetWorldPosition()
    else
        x, y, z = inst.Transform:GetWorldPosition()
    end

    local diefx = SpawnPrefab("die_fx")
    if diefx and x and y and z then
        diefx.Transform:SetPosition(x, y, z)
    end

    inst.AnimState:Hide("HAT")
    inst.AnimState:Hide("HAIR_HAT")
    inst.AnimState:Show("HAIR_NOHAT")
    inst.AnimState:Show("HAIR")
    inst.AnimState:Show("HEAD")
    inst.AnimState:Hide("HEAD_HAT")

    inst:Show()

    inst:SetStateGraph("SGwilson")

    inst.Physics:Teleport(x, y, z)

    inst.HUD.controls.status:SetGhostMode(false)
    GetWorld().components.colourcubemanager:SetOverrideColourCube(nil)

    -- Resurrector is involved
    if source ~= nil then
        inst.DynamicShadow:Enable(true)
        inst.AnimState:SetBank("wilson")
        inst.AnimState:SetBuild(inst.prefab)

        inst.components.bloomer:PopBloom("playerghostbloom")
        inst.AnimState:SetLightOverride(0)

        source:PushEvent("activateresurrection", inst)

        if source.prefab == "amulet" then
            inst.components.inventory:Equip(source)
            inst.sg:GoToState("amulet_rebirth")
        elseif source.prefab == "resurrectionstone" then
            inst.HUD.controls.inv:Hide()
            inst.HUD.controls.crafttabs:Hide()
            inst:PushEvent("ms_closepopups")
            inst.sg:GoToState("wakeup")
        elseif source.prefab == "resurrectionstatue" then
            inst.sg:GoToState("rebirth")
        elseif source:HasTag("multiplayer_portal") then
            --inst.components.health:DeltaPenalty(TUNING.PORTAL_HEALTH_PENALTY)
            --TODO
            source:PushEvent("rez_player")
            inst.sg:GoToState("portal_rez")
        end
    else 
		if item ~= nil and (item.prefab == "pocketwatch_revive" or item.prefab == "pocketwatch_revive_reviver") then
			inst.DynamicShadow:Enable(true)
			inst.AnimState:SetBank("wilson")
            inst.AnimState:SetBuild(inst.prefab)

            inst.components.bloomer:PopBloom("playerghostbloom")
			inst.AnimState:SetLightOverride(0)

			item:PushEvent("activateresurrection", inst)

            inst.HUD.controls.inv:Hide()
            inst.HUD.controls.crafttabs:Hide()
            inst:PushEvent("ms_closepopups")
			if inst:HasTag("wereplayer") then
	            inst.sg:GoToState("wakeup")
			else
	            inst.sg:GoToState("rewindtime_rebirth")
			end

			SpawnPrefab("pocketwatch_ground_fx").Transform:SetPosition(inst.Transform:GetWorldPosition())
		else -- Telltale Heart
	        inst.sg:GoToState("reviver_rebirth", item)
		end
    end

    --Default to electrocute light values
    inst.Light:SetIntensity(.8)
    inst.Light:SetRadius(.5)
    inst.Light:SetFalloff(.65)
    inst.Light:SetColour(255 / 255, 255 / 255, 236 / 255)
    inst.Light:Enable(false)

    ChangeToCharacterPhysics(inst)

    CommonActualRez(inst)

    inst:RemoveTag("playerghost")

    inst:PushEvent("ms_respawnedfromghost")
end

local function DoRezDelay(inst, source, delay)
    if not source:IsValid() or source:IsInLimbo() then
        --Revert OnRespawnFromGhost state
        inst.HUD:Show()
        if inst.components.playercontroller ~= nil then
            inst.components.playercontroller:Enable(true)
        end
        inst.rezsource = nil
        inst.remoterezsource = nil
        --Revert DoMoveToRezSource or DoMoveToRezPosition state
        inst:Show()
        inst.Light:Enable(true)
        TheCamera:SetDefault()
        inst.sg:GoToState("haunt")
        --
    elseif delay == nil or delay <= 0 then
        DoActualRez(inst, source)
    elseif delay > .35 then
        inst:DoTaskInTime(.35, DoRezDelay, source, delay - .35)
    else
        inst:DoTaskInTime(delay, DoRezDelay, source)
    end
end

local function DoMoveToRezSource(inst, source, delay)
    if not source:IsValid() or source:IsInLimbo() then
        --Revert OnRespawnFromGhost state
        inst.HUD:Show()
        if inst.components.playercontroller ~= nil then
            inst.components.playercontroller:Enable(true)
        end
        inst.rezsource = nil
        inst.remoterezsource = nil
        --Revert "remoteresurrect" state
        if inst.sg.currentstate.name == "remoteresurrect" then
            inst.sg:GoToState("haunt")
        end
        --
        return
    end

    inst:Hide()
    inst.Light:Enable(false)
    inst.Physics:Teleport(source.Transform:GetWorldPosition())
    TheCamera:SetDistance(24)
    if inst.sg.currentstate.name == "remoteresurrect" then
        inst:SnapCamera()
    end
    if inst.sg.statemem.faded then
        inst.sg.statemem.faded = false
        inst:ScreenFade(true, 1)
    end

    DoRezDelay(inst, source, delay)
end

local PLAYERSKELETON_TAG = {"playerskeleton"}

local function DoMoveToRezPosition(inst, item, delay, fade_in)
    inst:Hide()
    inst.Light:Enable(false)
	if inst.last_death_position ~= nil and inst.last_death_shardid ~= nil then
		if inst.last_death_shardid == TheShard:GetShardId() then
			inst.Physics:Teleport(inst.last_death_position:Get())
			inst:SnapCamera()
            TheCamera:SetDistance(24)

			if inst.sg.statemem.faded or fade_in then
				inst.sg.statemem.faded = false
				inst:ScreenFade(true, 1)
			end

			inst:DoTaskInTime(delay, DoActualRez, nil, item)
		else
			inst:DoTaskInTime(0, DoActualRez, nil, item)
		end
	else
		inst:DoTaskInTime(0, DoActualRez, nil, item)
	end
end

local function OnRespawnFromGhost(inst, data) -- from ListenForEvent "respawnfromghost"
    if not inst:HasTag("playerghost") then
        return
    end

	inst:AddTag("reviving")

    inst.deathclientobj = nil
    inst.deathcause = nil
    inst.deathpkname = nil
    inst.deathbypet = nil
    inst.HUD:Hide()
    if inst.components.playercontroller ~= nil then
        inst.components.playercontroller:Enable(false)
    end
    if inst.components.talker ~= nil then
        inst.components.talker:ShutUp()
    end
    inst.sg:AddStateTag("busy")

    if data == nil or data.source == nil then
        inst:DoTaskInTime(0, DoActualRez)
    elseif inst.sg.currentstate.name == "remoteresurrect" then
        inst:DoTaskInTime(0, DoMoveToRezSource, data.source, 24 * FRAMES)
    elseif data.source.prefab == "reviver" then
        inst:DoTaskInTime(0, DoActualRez, nil, data.source)
    elseif data.source.prefab == "pocketwatch_revive" then
        if not data.from_haunt then
			inst.sg:GoToState("start_rewindtime_revive")
			inst:DoTaskInTime(24*FRAMES, DoMoveToRezPosition, data.source, inst.skeleton_prefab == nil and 15 * FRAMES or 60 * FRAMES)
		else
			inst:ScreenFade(false, 1)
			inst:DoTaskInTime(9*FRAMES, DoMoveToRezPosition, data.source, inst.skeleton_prefab == nil and 15 * FRAMES or 60 * FRAMES, true)
		end
    elseif data.source.prefab == "pocketwatch_revive_reviver" then
        inst:DoTaskInTime(0, DoActualRez, nil, data.source)
    elseif data.source.prefab == "amulet"
        or data.source.prefab == "resurrectionstone"
        or data.source.prefab == "resurrectionstatue"
        or data.source:HasTag("multiplayer_portal") then
        inst:DoTaskInTime(9 * FRAMES, DoMoveToRezSource, data.source, --[[60-9]] 51 * FRAMES)
    else
        --unsupported rez source...
        inst:DoTaskInTime(0, DoActualRez)
    end

    inst.rezsource =
        data ~= nil and (
            (data.source ~= nil and data.source.prefab ~= "reviver" and data.source:GetBasicDisplayName()) or
            (data.user ~= nil and data.user:GetDisplayName())
        ) or
        STRINGS.NAMES.SHENANIGANS

    inst.remoterezsource =
        data ~= nil and
        data.source ~= nil and
        data.source.components.attunable ~= nil and
        data.source.components.attunable:GetAttunableTag() == "remoteresurrector"
end

local function CommonPlayerDeath(inst)
    --inst.player_classified.MapExplorer:EnableUpdate(false)

    inst:RemoveComponent("burnable")

    inst.components.freezable:Reset()
    inst:RemoveComponent("freezable")
    inst:RemoveComponent("propagator")

    --inst:RemoveComponent("grogginess")

    inst.components.moisture:ForceDry(true, inst)

    --inst.components.sheltered:Stop()

    inst.components.debuffable:Enable(false)

    inst.components.health:SetInvincible(true)
    inst.components.health.canheal = false

    inst.components.sanity:SetPercent(.5, true)
    inst.components.sanity.ignore = true

    inst.components.hunger:SetPercent(2 / 3, true)
    inst.components.hunger:Pause()

    inst.components.temperature:SetTemp(TUNING.STARTING_TEMP)
    inst.components.frostybreather:Disable()
end

local function OnMakePlayerGhost(inst, data)
    if inst:HasTag("playerghost") then
        return
    end

    local x, y, z = inst.Transform:GetWorldPosition()

    -- Spawn a skeleton
    if inst.skeleton_prefab ~= nil and data ~= nil and data.skeleton then
        local skel = SpawnPrefab(inst.skeleton_prefab)
        if skel ~= nil then
            skel.Transform:SetPosition(x, y, z)
            -- Set the description
            --skel:SetSkeletonDescription(inst.prefab, inst:GetDisplayName(), inst.deathcause, inst.deathpkname, inst.userid)
            --skel:SetSkeletonAvatarData(inst.deathclientobj)
        end
    end

    if data ~= nil and data.loading then
        -- Set temporary flag for resuming game as a ghost
        -- Used in ghost stategraph as well as below in this function
        inst.loading_ghost = true
    else
        -- Death FX
        SpawnPrefab("die_fx").Transform:SetPosition(x, y, z)
    end

    inst.AnimState:SetBank("ghost")
    if softresolvefilepath("anim/ghost_"..inst.prefab.."_build.zip") then
        inst.AnimState:SetBuild("ghost_"..inst.prefab.."_build")
    else
        inst.AnimState:SetBuild("ghost_build")
    end 
    --inst.components.bloomer:PushBloom("playerghostbloom", softresolvefilepath("shaders/anim_bloom_ghost.ksh"), 100)
    inst.AnimState:SetLightOverride(TUNING.GHOST_LIGHT_OVERRIDE)

    inst:SetStateGraph("SGwilsonghost")

    --Switch to ghost light values
    inst.Light:SetIntensity(.6)
    inst.Light:SetRadius(.5)
    inst.Light:SetFalloff(.6)
    inst.Light:SetColour(180/255, 195/255, 225/255)
    inst.Light:Enable(true)
    inst.DynamicShadow:Enable(false)

    CommonPlayerDeath(inst)

    ChangeToGhostPhysics(inst)
    inst.Physics:Teleport(x, y, z)

    inst:AddTag("playerghost")

    inst.components.health:SetCurrentHealth(TUNING.RESURRECT_HEALTH * (inst.resurrect_multiplier or 1))
    inst.components.health:ForceUpdateHUD(true)

    inst.components.talker.offset = Vector3(0, -700, 0)

    if inst.components.playercontroller ~= nil then
        inst.components.playercontroller:Enable(true)
    end
    inst.HUD.controls.status:SetGhostMode(true)
    GetWorld().components.colourcubemanager:SetOverrideColourCube(softresolvefilepath("images/colour_cubes/ghost_cc.tex"))

    ConfigureGhostLocomotor(inst)

    inst:PushEvent("ms_becameghost")

    if inst.loading_ghost then
        inst.loading_ghost = nil

        inst.HUD.controls.inv:Hide()
        inst.HUD.controls.crafttabs:Hide()
    else
        local will_resurrect = inst.components.resurrectable and inst.components.resurrectable:CanResurrect() 
        Morgue:OnDeath({killed_by=inst.deathcause, 
                        days_survived=GetClock().numcycles or 0,
                        character=GetPlayer().prefab, 
                        location= (inst.components.area_aware and inst.components.area_aware.current_area.story) or "unknown", 
                        world= (GetWorld().meta and GetWorld().meta.level_id) or "unknown"})

        local game_time = GetClock():ToMetricsString()
        
        RecordDeathStats(inst.deathcause, GetClock():GetPhase(), inst.components.sanity.current, inst.components.hunger.current, will_resurrect)

        ProfileStatsAdd("killed_by_"..inst.deathcause)
        ProfileStatsAdd("deaths")
    end
end

--------------------------------------------------------------------------

local function DoSpookedSanity(inst)
    inst.components.sanity:DoDelta(-TUNING.SANITY_SMALL)
end

local function OnSpooked(inst)
    inst:DoTaskInTime(1.35, DoSpookedSanity)
end

return
{
    ShouldKnockout              = ShouldKnockout,
    ConfigurePlayerLocomotor    = ConfigurePlayerLocomotor,
    ConfigureGhostLocomotor     = ConfigureGhostLocomotor,
    OnPlayerDeath               = OnPlayerDeath,
    OnPlayerDied                = OnPlayerDied,
    OnMakePlayerGhost           = OnMakePlayerGhost,
    OnRespawnFromGhost          = OnRespawnFromGhost,
    OnSpooked                   = OnSpooked,
}
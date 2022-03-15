env.AddPlayerPostInit = function(fn)
    env.AddPrefabPostInitAny( function(inst)
        if inst and inst:HasTag("player") then fn(inst) end
    end)
end
-------------------------------------------------------------------------------------------
function _G.AnimState:SetHaunted(ishaunted, ...)
    print("IsHaunted", ishaunted)
	return ishaunted		
end
-------------------------------------------------------------------------------------------
--"Oooh" string stuff
local Oooh_endings = { "h", "oh", "ohh" }
local Oooh_punc = { ".", "?", "!" }

local function ooohstart(isstart)
    local str = isstart and "O" or "o"
    local l = math.random(2, 4)
    for i = 2, l do
        str = str..(math.random() > 0.3 and "o" or "O")
    end
    return str
end

local function ooohspace()
    local c = math.random()
    local str =
        (c <= .1 and "! ") or
        (c <= .2 and ". ") or
        (c <= .3 and "? ") or
        (c <= .4 and ", ") or
        " "
    return str, c <= .3
end

local function ooohend()
    return Oooh_endings[math.random(#Oooh_endings)]
end

local function ooohpunc()
    return Oooh_punc[math.random(#Oooh_punc)]
end

local function CraftOooh() -- Ghost speech!
    local isstart = true
    local length = math.random(6)
    local str = ""
    for i = 1, length do
        str = str..ooohstart(isstart)..ooohend()
        if i ~= length then
            local space
            space, isstart = ooohspace()
            str = str..space
        end
    end
    return str..ooohpunc()
end
local _GetSpecialCharacterString = _G.GetSpecialCharacterString
function _G.GetSpecialCharacterString(character, ...)
    if character == nil then
        return nil
    end

    character = _G.GetPlayer():HasTag("playerghost") and "ghost" or string.lower(character)

    return character == "ghost" and CraftOooh() or _GetSpecialCharacterString(character, ...)
end

-------------------------------------------------------------------------------------------
-- DEPLOY TESTS

local notags = {'NOBLOCK', 'player', 'FX'}

function _G.TestDeploy_Ground(inst, pt)
	local tiletype = GetGroundTypeAtPosition(pt)
	local ground_OK = tiletype ~= GROUND.ROCKY and tiletype ~= GROUND.ROAD and tiletype ~= GROUND.IMPASSABLE and
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

-------------------------------------------------------------------------------------------

function _G.MakeHauntable(inst, cooldown, haunt_value)
    if not inst.components.hauntable then inst:AddComponent("hauntable") end
    inst.components.hauntable.cooldown = cooldown or TUNING.HAUNT_COOLDOWN_SMALL
	inst.components.hauntable:SetHauntValue(haunt_value or TUNING.HAUNT_TINY)
end

function _G.MakeHauntableLaunch(inst, chance, speed, cooldown, haunt_value)
    if not inst.components.hauntable then inst:AddComponent("hauntable") end
    inst.components.hauntable.cooldown = cooldown or TUNING.HAUNT_COOLDOWN_SMALL
    inst.components.hauntable:SetOnHauntFn(function(inst, haunter)
        chance = chance or TUNING.HAUNT_CHANCE_ALWAYS
        if math.random() <= chance then
            Launch(inst, haunter, speed or TUNING.LAUNCH_SPEED_SMALL)
            inst.components.hauntable.hauntvalue = haunt_value or TUNING.HAUNT_TINY
            return true
        end
        return false
    end)
end

function _G.MakeHauntableLaunchAndSmash(inst, launch_chance, smash_chance, speed, cooldown, launch_haunt_value, smash_haunt_value)
    if not inst.components.hauntable then inst:AddComponent("hauntable") end
    inst.components.hauntable.cooldown = cooldown or TUNING.HAUNT_COOLDOWN_SMALL
    inst.components.hauntable:SetOnHauntFn(function(inst, haunter)
        launch_chance = launch_chance or TUNING.HAUNT_CHANCE_ALWAYS
        if math.random() <= launch_chance then
            Launch(inst, haunter, speed or TUNING.LAUNCH_SPEED_SMALL)
            inst.components.hauntable.hauntvalue = launch_haunt_value or TUNING.HAUNT_TINY
            --#HAUNTFIX
            --smash_chance = smash_chance or TUNING.HAUNT_CHANCE_OCCASIONAL
            --if math.random() < smash_chance then
                --inst.components.hauntable.hauntvalue = smash_haunt_value or TUNING.HAUNT_SMALL
                --inst.smashtask = inst:DoPeriodicTask(.1, function(inst)
                    --local pt = Point(inst.Transform:GetWorldPosition())
                    --if pt.y <= .2 then
                        --inst.SoundEmitter:PlaySound("dontstarve/common/stone_drop")
                        --local pt = Vector3(inst.Transform:GetWorldPosition())
                        --local breaking = SpawnPrefab("ground_chunks_breaking") --spawn break effect
                        --breaking.Transform:SetPosition(pt.x, 0, pt.z)
                        --inst:Remove()
                        --inst.smashtask:Cancel()
                        --inst.smashtask = nil
                    --end
                --end)
            --end
            return true
        end
        return false
    end)
end

function _G.MakeHauntableWork(inst, chance, cooldown, haunt_value)
    if not inst.components.hauntable then inst:AddComponent("hauntable") end
    inst.components.hauntable.cooldown = cooldown or TUNING.HAUNT_COOLDOWN_SMALL
    inst.components.hauntable:SetOnHauntFn(function(inst, haunter)
        --#HAUNTFIX
        --chance = chance or TUNING.HAUNT_CHANCE_OFTEN
        --if math.random() <= chance then
            --if inst.components.workable ~= nil and inst.components.workable:CanBeWorked() then
                --inst.components.hauntable.hauntvalue = haunt_value or TUNING.HAUNT_SMALL
                --inst.components.workable:WorkedBy(haunter, 1)
                --return true
            --end
        --end
        return false
    end)
end

function _G.MakeHauntableWorkAndIgnite(inst, work_chance, ignite_chance, cooldown, work_haunt_value, ignite_haunt_value)
    if not inst.components.hauntable then inst:AddComponent("hauntable") end
    inst.components.hauntable.cooldown = cooldown or TUNING.HAUNT_COOLDOWN_MEDIUM
    inst.components.hauntable:SetOnHauntFn(function(inst, haunter)
        local ret = false

        --#HAUNTFIX
        --work_chance = work_chance or TUNING.HAUNT_CHANCE_OFTEN
        --if math.random() <= work_chance then
            --if inst.components.workable ~= nil and inst.components.workable:CanBeWorked() then
                --inst.components.hauntable.hauntvalue = work_haunt_value or TUNING.HAUNT_SMALL
                --inst.components.workable:WorkedBy(haunter, 1)
                --ret = true
            --end
        --end

        --#HAUNTFIX
        --ignite_chance = ignite_chance or TUNING.HAUNT_CHANCE_SUPERRARE
        --if math.random() <= ignite_chance then
            --if inst.components.burnable and not inst.components.burnable:IsBurning() then
                --inst.components.burnable:Ignite()
                --inst.components.hauntable.hauntvalue = ignite_haunt_value or TUNING.HAUNT_MEDLARGE
                --inst.components.hauntable.cooldown_on_successful_haunt = false
                --ret = true
            --end
        --end

        return ret
    end)
end

function _G.MakeHauntableFreeze(inst, chance, cooldown, haunt_value)
    if inst.components.hauntable == nil then
        inst:AddComponent("hauntable")
    end
    inst.components.hauntable:SetOnHauntFn(function(inst, haunter)
        inst.components.hauntable.cooldown = cooldown or TUNING.HAUNT_COOLDOWN_MEDIUM
        if inst.components.freezable ~= nil and
            not inst.components.freezable:IsFrozen() and
            math.random() <= (chance or TUNING.HAUNT_CHANCE_HALF) then
            inst.components.freezable:AddColdness(math.max(1, inst.components.freezable:ResolveResistance() - inst.components.freezable.coldness + 1))
            inst.components.hauntable.hauntvalue = haunt_value or TUNING.HAUNT_MEDIUM
            inst.components.hauntable.cooldown = cooldown or TUNING.HAUNT_COOLDOWN_HUGE
            return true
        end
        return false
    end)
end

function _G.MakeHauntableIgnite(inst, chance, cooldown, haunt_value)
    if not inst.components.hauntable then inst:AddComponent("hauntable") end
    inst.components.hauntable.cooldown = cooldown or TUNING.HAUNT_COOLDOWN_MEDIUM
    inst.components.hauntable:SetOnHauntFn(function(inst, haunter)
        --#HAUNTFIX
        --chance = chance or TUNING.HAUNT_CHANCE_VERYRARE
        --if math.random() <= chance then
            --if inst.components.burnable and not inst.components.burnable:IsBurning() then
                --inst.components.burnable:Ignite()
                --inst.components.hauntable.hauntvalue = haunt_value or TUNING.HAUNT_LARGE
                --inst.components.hauntable.cooldown_on_successful_haunt = false
                --return true
            --end
        --end
        return false
    end)
end

function _G.MakeHauntableLaunchAndIgnite(inst, launchchance, ignitechance, speed, cooldown, launch_haunt_value, ignite_haunt_value)
    if not inst.components.hauntable then inst:AddComponent("hauntable") end
    inst.components.hauntable.cooldown = cooldown or TUNING.HAUNT_COOLDOWN_SMALL
    inst.components.hauntable:SetOnHauntFn(function(inst, haunter)
        launchchance = launchchance or TUNING.HAUNT_CHANCE_ALWAYS
        if math.random() <= launchchance then
            Launch(inst, haunter, speed or TUNING.LAUNCH_SPEED_SMALL)
            inst.components.hauntable.hauntvalue = launch_haunt_value or TUNING.HAUNT_TINY
            --#HAUNTFIX
            --ignitechance = ignitechance or TUNING.HAUNT_CHANCE_VERYRARE
            --if math.random() <= ignitechance then
                --if inst.components.burnable and not inst.components.burnable:IsBurning() then
                    --inst.components.burnable:Ignite()
                    --inst.components.hauntable.hauntvalue = ignite_haunt_value or TUNING.HAUNT_MEDIUM
                    --inst.components.hauntable.cooldown_on_successful_haunt = false
                --end
            --end
            --return true
        end
        return false
    end)
end

local function DoChangePrefab(inst, newprefab, haunter, nofx)
    local x, y, z = inst.Transform:GetWorldPosition()
    if not nofx then
        SpawnPrefab("small_puff").Transform:SetPosition(x, y, z)
    end
    local new = SpawnPrefab(type(newprefab) == "table" and newprefab[math.random(#newprefab)] or newprefab)
    if new ~= nil then
        new.Transform:SetPosition(x, y, z)
        if new.components.stackable ~= nil and inst.components.stackable ~= nil and inst.components.stackable:IsStack() then
            new.components.stackable:SetStackSize(math.min(new.components.stackable.maxsize, inst.components.stackable:StackSize()))
        end
        if new.components.inventoryitem ~= nil and inst.components.inventoryitem ~= nil then
            new.components.inventoryitem:InheritMoisture(inst.components.inventoryitem:GetMoisture(), inst.components.inventoryitem:IsWet())
        end
        if new.components.perishable ~= nil and inst.components.perishable ~= nil then
            new.components.perishable:SetPercent(inst.components.perishable:GetPercent())
        end
        if new.components.fueled ~= nil and inst.components.fueled ~= nil then
            new.components.fueled:SetPercent(inst.components.fueled:GetPercent())
        end
        if new.components.finiteuses ~= nil and inst.components.finiteuses ~= nil then
            new.components.finiteuses:SetPercent(inst.components.finiteuses:GetPercent())
        end
        local home = inst.components.homeseeker ~= nil and inst.components.homeseeker.home or nil
        inst:PushEvent("detachchild")
        if home ~= nil and home.components.childspawner ~= nil then
            home.components.childspawner:TakeOwnership(new)
        end
        new:PushEvent("spawnedfromhaunt", { haunter = haunter, oldPrefab = inst })
        inst:PushEvent("despawnedfromhaunt", { haunter = haunter, newPrefab = new })
        inst.persists = false
        inst.entity:Hide()
        inst:DoTaskInTime(0, inst.Remove)
    end
end

function _G.MakeHauntableChangePrefab(inst, newprefab, chance, haunt_value, nofx)
    if newprefab == nil or (type(newprefab) == "table" and #newprefab <= 0) then
        return
    elseif inst.components.hauntable == nil then
        inst:AddComponent("hauntable")
    end
    inst.components.hauntable.cooldown_on_successful_haunt = false
    inst.components.hauntable:SetOnHauntFn(function(inst, haunter)
        if math.random() <= (chance or TUNING.HAUNT_CHANCE_HALF) then
            DoChangePrefab(inst, newprefab, haunter, nofx)
            inst.components.hauntable.hauntvalue = haunt_value or TUNING.HAUNT_SMALL
            return true
        end
        return false
    end)
end

function _G.MakeHauntableLaunchOrChangePrefab(inst, launchchance, prefabchance, speed, cooldown, newprefab, prefab_haunt_value, launch_haunt_value, nofx)
    if newprefab == nil or (type(newprefab) == "table" and #newprefab <= 0) then
        return
    elseif inst.components.hauntable == nil then
        inst:AddComponent("hauntable")
    end
    inst.components.hauntable.cooldown = cooldown or TUNING.HAUNT_COOLDOWN_SMALL
    inst.components.hauntable:SetOnHauntFn(function(inst, haunter)
        if math.random() <= (launchchance or TUNING.HAUNT_CHANCE_ALWAYS) then
            if math.random() <= (prefabchance or TUNING.HAUNT_CHANCE_OCCASIONAL) then
                DoChangePrefab(inst, newprefab, haunter, nofx)
                inst.components.hauntable.hauntvalue = prefab_haunt_value or TUNING.HAUNT_SMALL
            else
                Launch(inst, haunter, speed or TUNING.LAUNCH_SPEED_SMALL)
                inst.components.hauntable.hauntvalue = launch_haunt_value or TUNING.HAUNT_TINY
            end
            return true
        end
        return false
    end)
end

function _G.MakeHauntablePerish(inst, perishpct, chance, cooldown, haunt_value)
    if not inst.components.hauntable then inst:AddComponent("hauntable") end
    inst.components.hauntable.cooldown = cooldown or TUNING.HAUNT_COOLDOWN_SMALL
    inst.components.hauntable:SetOnHauntFn(function(inst, haunter)
        --#HAUNTFIX
        --chance = chance or TUNING.HAUNT_CHANCE_HALF
        --if math.random() <= chance then
            --if inst.components.perishable then
                --inst.components.perishable:ReducePercent(perishpct or .3)
                --inst.components.hauntable.hauntvalue = haunt_value or TUNING.HAUNT_MEDIUM
                --return true
            --end
        --end
        return false
    end)
end

function _G.MakeHauntableLaunchAndPerish(inst, launchchance, perishchance, speed, perishpct, cooldown, launch_haunt_value, perish_haunt_value)
    if not inst.components.hauntable then inst:AddComponent("hauntable") end
    inst.components.hauntable:SetOnHauntFn(function(inst, haunter)
        launchchance = launchchance or TUNING.HAUNT_CHANCE_ALWAYS
        if math.random() <= launchchance then
            Launch(inst, haunter, speed or TUNING.LAUNCH_SPEED_SMALL)
            inst.components.hauntable.hauntvalue = launch_haunt_value or TUNING.HAUNT_TINY
            inst.components.hauntable.cooldown = cooldown or TUNING.HAUNT_COOLDOWN_SMALL
            --#HAUNTFIX
            --perishchance = perishchance or TUNING.HAUNT_CHANCE_OCCASIONAL
            --if math.random() <= perishchance then
                --if inst.components.perishable then
                    --inst.components.perishable:ReducePercent(perishpct or .3)
                    --inst.components.hauntable.hauntvalue = perish_haunt_value or TUNING.HAUNT_MEDIUM
                    --inst.components.hauntable.cooldown = cooldown or TUNING.HAUNT_COOLDOWN_MEDIUM
                --end
            --end
            return true
        end
        return false
    end)
end

function _G.MakeHauntablePanic(inst, panictime, chance, cooldown, haunt_value)
    if not inst.components.hauntable then inst:AddComponent("hauntable") end
	inst.components.hauntable.panicable = true
    inst.components.hauntable.cooldown = cooldown or TUNING.HAUNT_COOLDOWN_MEDIUM
    inst.components.hauntable:SetOnHauntFn(function(inst, haunter)
        if inst.components.sleeper then -- Wake up, there's a ghost!
            inst.components.sleeper:WakeUp()
        end

        chance = chance or TUNING.HAUNT_CHANCE_ALWAYS
        if math.random() <= chance then
            inst.components.hauntable.panic = true
            inst.components.hauntable.panictimer = panictime or TUNING.HAUNT_PANIC_TIME_SMALL
            inst.components.hauntable.hauntvalue = haunt_value or TUNING.HAUNT_SMALL
            return true
        end
        return false
    end)
end

function _G.MakeHauntablePanicAndIgnite(inst, panictime, panicchance, ignitechance, cooldown, panic_haunt_value, ignite_haunt_value)
    if not inst.components.hauntable then inst:AddComponent("hauntable") end
	inst.components.hauntable.panicable = true
    inst.components.hauntable.cooldown = cooldown or TUNING.HAUNT_COOLDOWN_MEDIUM
    inst.components.hauntable:SetOnHauntFn(function(inst, haunter)
        panicchance = panicchance or TUNING.HAUNT_CHANCE_ALWAYS
        if math.random() <= panicchance then
            inst.components.hauntable.panic = true
            inst.components.hauntable.panictimer = panictime or TUNING.HAUNT_PANIC_TIME_SMALL
            inst.components.hauntable.hauntvalue = panic_haunt_value or TUNING.HAUNT_SMALL
            --#HAUNTFIX
            --ignitechance = ignitechance or TUNING.HAUNT_CHANCE_RARE
            --if math.random() <= ignitechance then
                --if inst.components.burnable and not inst.components.burnable:IsBurning() then
                    --inst.components.burnable:Ignite()
                    --inst.components.hauntable.hauntvalue = ignite_haunt_value or TUNING.HAUNT_MEDIUM
                    --inst.components.hauntable.cooldown = cooldown or TUNING.HAUNT_COOLDOWN_HUGE
                --end
            --end
            return true
        end
        return false
    end)
end

function _G.MakeHauntablePlayAnim(inst, anim, animloop, pushanim, animduration, endanim, endanimloop, soundevent, soundname, soundduration, chance, cooldown, haunt_value)
    if not anim then return end

    if not inst.components.hauntable then inst:AddComponent("hauntable") end
    inst.components.hauntable.cooldown = cooldown or TUNING.HAUNT_COOLDOWN_SMALL
    inst.components.hauntable:SetOnHauntFn(function(inst, haunter)
        chance = chance or TUNING.HAUNT_CHANCE_ALWAYS
        if math.random() <= chance then

            local loop = animloop ~= nil and animloop or false
            if pushanim then
                inst.AnimState:PushAnimation(anim, loop)
            else
                inst.AnimState:PlayAnimation(anim, loop)
            end
            if animduration and endanim then
                inst:DoTaskInTime(animduration, function(inst) inst.AnimState:PlayAnimation(endanim, endanimloop) end)
            end

            if soundevent and inst.SoundEmitter then
                if soundname then
                    inst.SoundEmitter:PlaySound(soundevent, soundname)
                    if soundduration then
                        inst:DoTaskInTime(soundduration, function(inst) inst.SoundEmitter:KillSound(soundname) end)
                    end
                else
                    inst.SoundEmitter:PlaySound(soundevent)
                end
            end

            inst.components.hauntable.hauntvalue = haunt_value or TUNING.HAUNT_TINY
            return true
        end
        return false
    end)
end

function _G.MakeHauntableGoToState(inst, state, chance, cooldown, haunt_value)
    if not (inst and inst.sg) or not state then return end

    if not inst.components.hauntable then inst:AddComponent("hauntable") end
    inst.components.hauntable.cooldown = cooldown or TUNING.HAUNT_COOLDOWN_SMALL
    inst.components.hauntable:SetOnHauntFn(function(inst, haunter)
        chance = chance or TUNING.HAUNT_CHANCE_ALWAYS
        if math.random() <= chance then
            inst.sg:GoToState(state)
            inst.components.hauntable.hauntvalue = haunt_value or TUNING.HAUNT_TINY
            return true
        end
        return false
    end)
end

function _G.MakeHauntableGoToStateWithChanceFunction(inst, state, chancefn, cooldown, haunt_value)
    if not (inst and inst.sg) or not state then return end
    if not inst.components.hauntable then inst:AddComponent("hauntable") end

    inst.components.hauntable.cooldown = cooldown or TUNING.HAUNT_COOLDOWN_SMALL
    inst.components.hauntable:SetOnHauntFn(function(inst, haunter)
        local haunt_chance = (chancefn ~= nil and chancefn(inst)) or TUNING.HAUNT_CHANCE_ALWAYS
        if math.random() <= haunt_chance then
            inst.sg:GoToState(state)
            inst.components.hauntable.hauntvalue = haunt_value or TUNING.HAUNT_TINY
            return true
        end
        return false
    end)
end

function _G.MakeHauntableDropFirstItem(inst, chance, cooldown, haunt_value)
    if not inst.components.hauntable then inst:AddComponent("hauntable") end
    inst.components.hauntable:SetOnHauntFn(function(inst, haunter)
        inst.components.hauntable.cooldown = cooldown or TUNING.HAUNT_COOLDOWN_SMALL
        --#HAUNTFIX
        --chance = chance or TUNING.HAUNT_CHANCE_OCCASIONAL
        --if math.random() <= chance then
            --if inst.components.inventory then
                --local item = inst.components.inventory:FindItem(function(item) return not item:HasTag("nosteal") end)
                --if item then
                    --local direction = Vector3(haunter.Transform:GetWorldPosition()) - Vector3(inst.Transform:GetWorldPosition() )
                    --inst.components.inventory:DropItem(item, false, direction:GetNormalized())
                    --inst.components.hauntable.hauntvalue = haunt_value or TUNING.HAUNT_MEDIUM
                    --inst.components.hauntable.cooldown = cooldown or TUNING.HAUNT_COOLDOWN_MEDIUM
                    --return true
                --end
            --end
            --if inst.components.container then
                --local item = inst.components.container:FindItem(function(item) return not item:HasTag("nosteal") end)
                --if item then
                    --inst.components.container:DropItem(item)
                    --inst.components.hauntable.hauntvalue = haunt_value or TUNING.HAUNT_MEDIUM
                    --inst.components.hauntable.cooldown = cooldown or TUNING.HAUNT_COOLDOWN_MEDIUM
                    --return true
                --end
            --end
        --end
        return false
    end)
end

function _G.MakeHauntableLaunchAndDropFirstItem(inst, launchchance, dropchance, speed, cooldown, launch_haunt_value, drop_haunt_value)
    if not inst.components.hauntable then inst:AddComponent("hauntable") end
    inst.components.hauntable:SetOnHauntFn(function(inst, haunter)
        launchchance = launchchance or TUNING.HAUNT_CHANCE_ALWAYS
        if math.random() <= launchchance then
            Launch(inst, haunter, speed or TUNING.LAUNCH_SPEED_SMALL)
            inst.components.hauntable.hauntvalue = launch_haunt_value or TUNING.HAUNT_TINY
            inst.components.hauntable.cooldown = cooldown or TUNING.HAUNT_COOLDOWN_SMALL
            --#HAUNTFIX
            --dropchance = dropchance or TUNING.HAUNT_CHANCE_OCCASIONAL
            --if math.random() <= dropchance then
                --if inst.components.inventory then
                    --local item = inst.components.inventory:FindItem(function(item) return not item:HasTag("nosteal") end)
                    --if item then
                        --local direction = Vector3(haunter.Transform:GetWorldPosition()) - Vector3(inst.Transform:GetWorldPosition() )
                        --inst.components.inventory:DropItem(item, false, direction:GetNormalized())
                        --inst.components.hauntable.hauntvalue = drop_haunt_value or TUNING.HAUNT_MEDIUM
                        --inst.components.hauntable.cooldown = cooldown or TUNING.HAUNT_COOLDOWN_MEDIUM
                        --return true
                    --end
                --end
                --if inst.components.container then
                    --local item = inst.components.container:FindItem(function(item) return not item:HasTag("nosteal") end)
                    --if item then
                        --inst.components.container:DropItem(item)
                        --inst.components.hauntable.hauntvalue = drop_haunt_value or TUNING.HAUNT_MEDIUM
                        --inst.components.hauntable.cooldown = cooldown or TUNING.HAUNT_COOLDOWN_MEDIUM
                        --return true
                    --end
                --end
            --end
            return true
        end
        return false
    end)
end

function AddHauntableCustomReaction(inst, fn, secondrxn, ignoreinitialresult, ignoresecondaryresult)
    if not inst.components.hauntable then inst:AddComponent("hauntable") end
    local onhaunt = inst.components.hauntable.onhaunt
    inst.components.hauntable:SetOnHauntFn(function(inst, haunter)
        local result = false
        if secondrxn then -- Custom reaction to come after any existing reactions (i.e. additional effects that are conditional on existing reactions)
            if onhaunt then
                result = onhaunt(inst, haunter)
            end
            if not onhaunt or result or ignoreinitialresult then -- Can use ignore flags if we don't care about the return value of a given part
                local prevresult = result
                result = fn(inst, haunter)
                if ignoresecondaryresult then result = prevresult end
            end
        else -- Custom reaction to come before any existing reactions (i.e. conditions required for existing reaction to trigger)
            result = fn(inst, haunter)
            if (result or ignoreinitialresult) and onhaunt then -- Can use ignore flags if we don't care about the return value of a given part
                local prevresult = result
                result = onhaunt(inst, haunter)
                if ignoresecondaryresult then result = prevresult end
            end
        end
        return result
    end)
end

function AddHauntableDropItemOrWork(inst)
    if not inst.components.hauntable then inst:AddComponent("hauntable") end
    inst.components.hauntable.cooldown = TUNING.HAUNT_COOLDOWN_SMALL
    inst.components.hauntable:SetOnHauntFn(function(inst, haunter)
        local ret = false
        --#HAUNTFIX
        --if math.random() <= TUNING.HAUNT_CHANCE_OCCASIONAL then
            --if inst.components.container then
                --local item = inst.components.container:FindItem(function(item) return not item:HasTag("nosteal") end)
                --if item then
                    --inst.components.container:DropItem(item)
                    --inst.components.hauntable.hauntvalue = TUNING.HAUNT_MEDIUM
                    --ret = true
                --end
            --end
        --end
        --if math.random() <= TUNING.HAUNT_CHANCE_VERYRARE then
            --if inst.components.workable then
                --inst.components.workable:WorkedBy(haunter, 1)
                --inst.components.hauntable.hauntvalue = TUNING.HAUNT_MEDIUM
                --ret = true
            --end
        --end
        return ret
    end)
end

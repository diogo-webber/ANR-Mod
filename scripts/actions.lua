local function DefaultRangeCheck(doer, target)
    if target == nil then
        return
    end
    local target_x, target_y, target_z = target.Transform:GetWorldPosition()
    local doer_x, doer_y, doer_z = doer.Transform:GetWorldPosition()
    local dst = distsq(target_x, target_z, doer_x, doer_z)
    return dst <= 16
end

local HAUNT = Action({ rmb=false, mindistance=2, ghost_valid=true, ghost_exclusive=true, canforce=true, rangecheckfn=DefaultRangeCheck })
HAUNT.str = STRINGS.ACTIONS.HAUNT
HAUNT.id = "HAUNT"
HAUNT.fn = function(act)
    if act.target ~= nil and
        act.target:IsValid() and
        not act.target:IsInLimbo() and
        act.target.components.hauntable ~= nil and
        not (act.target.components.inventoryitem ~= nil and act.target.components.inventoryitem:IsHeld()) and
        not (act.target.components.hauntable.haunted or act.target:HasTag("catchable")) then
        act.doer:PushEvent("haunt", { target = act.target })
        act.target.components.hauntable:DoHaunt(act.doer)
        return true
    end
end
AddAction(HAUNT)
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.HAUNT, "haunt_pre"))

local ATTUNE = Action()
ATTUNE.str = STRINGS.ACTIONS.ATTUNE
ATTUNE.id = "ATTUNE"
ATTUNE.fn = function(act)
    if act.doer ~= nil and
        act.target ~= nil and
        act.target.components.attunable ~= nil then
        return act.target.components.attunable:LinkToPlayer(act.doer)
    end
end
AddAction(ATTUNE)
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.ATTUNE, "dolongaction"))

local REMOTERESURRECT = Action({ rmb=false, ghost_valid=true, ghost_exclusive=true })
REMOTERESURRECT.str = STRINGS.ACTIONS.REMOTERESURRECT
REMOTERESURRECT.id = "REMOTERESURRECT"
REMOTERESURRECT.fn = function(act)
    if act.doer ~= nil and act.doer.components.attuner ~= nil and act.doer:HasTag("playerghost") then
        local target = act.doer.components.attuner:GetAttunedTarget("remoteresurrector")
        if target ~= nil then
            act.doer:PushEvent("respawnfromghost", { source = target })
            return true
        end
    end
end
AddAction(REMOTERESURRECT)
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.REMOTERESURRECT, "remoteresurrect"))

local NUZZLE = Action()
NUZZLE.id = "NUZZLE"
NUZZLE.fn = function(act)
    if act.target then
        --print(string.format("%s loves %s!", act.doer.prefab, act.target.prefab))
        return true
    end
end
AddAction(NUZZLE)

local WRITE = Action()
WRITE.str = STRINGS.ACTIONS.WRITE
WRITE.id = "WRITE"
WRITE.fn = function(act)
    if act.doer ~= nil and
        act.target ~= nil and
        act.target.components.writeable ~= nil and
        not act.target.components.writeable:IsWritten() then

        if act.target.components.writeable:IsBeingWritten() then
            return false, "INUSE"
        end

        --Silent fail for writing in the dark
        if _G.CanEntitySeeTarget(act.doer, act.target) then
            act.target.components.writeable:BeginWriting(act.doer)
        end
        return true
    end
end
AddAction(WRITE)
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.WRITE, "doshortaction"))

-------------------------------------------------------
ACTIONS.LOOKAT.ghost_valid = true
ACTIONS.WALKTO.ghost_valid = true
ACTIONS.JUMPIN.ghost_valid = true


local _HEAL = ACTIONS.HEAL.fn
ACTIONS.HEAL.fn = function(act, ...)
    local target = act.target or act.doer
    if act.invobject.components.maxhealer ~= nil then
        return act.invobject.components.maxhealer:Heal(target)
    else
        return _HEAL(act, ...)
    end
end

local _activatestrfn = ACTIONS.ACTIVATE.strfn
ACTIONS.ACTIVATE.strfn = function(act)
    local targ = act.target
    if targ.prefab == "cave_exit" or targ.prefab == "cave_entrance" then
        return "MIGRATE"
    end
    return _activatestrfn(act)
end


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
        not (act.target:HasTag("haunted") or act.target:HasTag("catchable")) then
        act.doer:PushEvent("haunt", { target = act.target })
        act.target.components.hauntable:DoHaunt(act.doer)
        return true
    end
end
AddAction(HAUNT)
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.HAUNT, "haunt_pre"))

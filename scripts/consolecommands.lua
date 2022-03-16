--Insert some function here
function ConsoleCommandPlayer()
    return (c_sel() ~= nil and c_sel():HasTag("player") and c_sel()) or GetPlayer()
end

function ConsoleWorldPosition()
    return TheInput.overridepos or TheInput:GetWorldPosition()
end

function ConsoleWorldEntityUnderMouse()
    if TheInput.overridepos == nil then
        return TheInput:GetWorldEntityUnderMouse()
    else
        local x, y, z = TheInput.overridepos:Get()
        local ents = TheSim:FindEntities(x, y, z, 1)
        for i, v in ipairs(ents) do
            if v.entity:IsVisible() then
                return v
            end
        end
    end
end

function c_select(inst)
    if not inst then
        inst = ConsoleWorldEntityUnderMouse()
    end
    print("Selected "..tostring(inst or "<nil>") )
    SetDebugEntity(inst)
    return inst
end

_G.we = function()
    _G.GetPlayer().components.builder:GiveAllRecipes()
    _G.c_sethunger(1)
    _G.c_sethealth(1)
    _G.c_setsanity(1)
    _G.c_speed(3)

    local wet = _G.GetPlayer().components.moisture
    if wet then wet:SetMoistureLevel(0) end

    if not _G.GetPlayer().components.health:IsInvincible() then
        _G.c_godmode()
    end
end

 ---------------------------------------------

local GetPlayer = _G.GetPlayer
local IsHUDPaused = _G.IsPaused

_G.c_save = function ()
   if not GetPlayer() then print("Paused? " .. tostring(IsHUDPaused()).. " | Player? ".. tostring(GetPlayer())) return end

    GetPlayer().components.autosaver:DoSave()
end

 ---------------------------------------------

_G.c_reset = function ()
    if not GetPlayer() then print("Paused? " .. tostring(IsHUDPaused()).. " | Player? ".. tostring(GetPlayer())) return end

	_G.SetPause(true)
	_G.StartNextInstance({reset_action=_G.RESET_ACTION.LOAD_SLOT, save_slot = _G.SaveGameIndex:GetCurrentSaveSlot()}, true)
	_G.SetPause(false)
end
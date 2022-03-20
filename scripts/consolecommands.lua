--Insert some function here

local c_sel = _G.c_sel

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

function _G.c_select(inst)
    if not inst then
        inst = ConsoleWorldEntityUnderMouse()
    end
    print("Selected: "..tostring(inst or "<nil>") )
    _G.SetDebugEntity(inst)
    return inst
end

function _G.we()
    GetPlayer().components.builder:GiveAllRecipes()
    _G.c_sethunger(1)
    _G.c_sethealth(1)
    _G.c_setsanity(1)
    _G.c_speed(3)
    GetPlayer().components.temperature:SetTemperature(25)

    local wet = GetPlayer().components.moisture
    if wet then wet:SetMoistureLevel(0) end

    if not GetPlayer().components.health:IsInvincible() then
        _G.c_godmode()
    end
end

 ---------------------------------------------

function _G.c_save()
    GetPlayer().components.autosaver:DoSave()
end

---------------------------------------------

function _G.c_regen()
    GetPlayer().profile:Save(function()
        _G.SaveGameIndex:EraseCurrent(function() 
            _G.scheduler:ExecuteInTime(0.1, function() 
                local function OnProfileSaved()
                    local slot = _G.SaveGameIndex:GetCurrentSaveSlot()
                    _G.SaveGameIndex:DeleteSlot(slot, function() 
                               TheFrontEnd:Fade(false, 0.5, function () 
                                    _G.StartNextInstance({reset_action=_G.RESET_ACTION.LOAD_SLOT, save_slot = slot or _G.SaveGameIndex:GetCurrentSaveSlot()})
                                end )
                            end, true)
                end
                
                -- Record the start of a new game
                Profile:Save(OnProfileSaved)   
            end)
        end)
    end)
end

---------------------------------------------

function _G.c_reset()
    GetPlayer().HUD:Hide()
    _G.TheFrontEnd:HideConsoleLog()

    _G.TheFrontEnd:Fade(false, 1, function()			
        _G.StartNextInstance(
            {
                reset_action=_G.RESET_ACTION.LOAD_SLOT,
                save_slot = _G.SaveGameIndex:GetCurrentSaveSlot()
            },
            true)
    end)
end
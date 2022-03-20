local runned = false
local patched = false

return function(self)
	if runned then 
        return 
    end
    local _Save = self.Save
    self.Save = function(...)
        local generated = GetWorld() and GetWorld().generated
        if self.data and self.data.slots and self.data.slots[self.current_slot] and generated then
            self.data.slots[self.current_slot].generated = generated
        end
        _Save(...)
    end

    local _Load = self.Load
    self.Load = function(...)
        _Load(...)
        local generated = self.data.slots[self.current_slot].generated
    
        if GetWorld() and generated and next(generated) then
            GetWorld().generated = generated
        end

        self.data.slots[self.current_slot].generated = nil
        self:Save(function () print("LoadSavedDSTData CB") end)
    end

    local _LoadSavedSeasonData = self.LoadSavedSeasonData
    self.LoadSavedSeasonData = function(...)
        _LoadSavedSeasonData(self, ...)
        local data = self.data.slots[self.current_slot].clock_data
        local clock = GetClock()
        if clock and data then
            GetClock():OnLoad(data)
        end
    end
    
	if package.loaded.gamelogic then
		runned = true
        if patched then return end

        patched = true
    
        local _PopulateWorld = _G.PopulateWorld
        _G.PopulateWorld = function(savedata, ...)
            local val = _PopulateWorld(savedata, ...)
            if GetWorld() then
                GetWorld().generated = savedata.map.generated
            end
            return val
        end
	end
end


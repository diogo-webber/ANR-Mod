local function IsPlayerGhost(guy)
	if guy and guy:HasTag("playerghost") then
		return nil
	else
		return guy
	end 
end

return function(self)
    local _SetRetargetFunction = self.SetRetargetFunction
    function self:SetRetargetFunction(period, fn, ...)
        _SetRetargetFunction(self, period, fn, ...)
        local targetfn = self.targetfn
		self.targetfn = function(inst)
			return IsPlayerGhost(targetfn(inst))
		end
    end
end
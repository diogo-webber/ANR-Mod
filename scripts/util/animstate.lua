-------------------------------------------------------------------------------------------
function AnimState:SetHaunted(ishaunted, ...)
	return ishaunted		
end

function AnimState:HideSymbol(symbol, ...)
    if not symbol then
        return
    end
    self:OverrideSymbol(symbol, "wilson", "nil")
end

function AnimState:ShowSymbol(symbol, ...)
    if not symbol then
        return
    end
    self:ClearOverrideSymbol(symbol)
end
-------------------------------------------------------------------------------------------

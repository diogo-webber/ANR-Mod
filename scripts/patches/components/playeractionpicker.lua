return function(self)
    local _SortActionList = self.SortActionList
    function self:SortActionList(actions, target, useitem, ...)
        if self.inst:HasTag("playerghost") then
            if #actions > 0 then
                for v=#actions,1,-1 do  
                    if (not actions[v].ghost_valid or actions[v].ghost_valid == false) then
                        table.remove(actions,v)
                    end
                end
            end
        end
        return _SortActionList(self, actions, target, useitem, ...)
    end
end
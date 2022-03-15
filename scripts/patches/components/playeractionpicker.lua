local function OrderByPriority(l, r)
    return l.priority > r.priority
end

return function(self)
    self.actionfilterstack = {} -- only the highest priority filter is active
    self.actionfilter = nil
    
    function self:OnUpdateActionFilterStack()
        local num = #self.actionfilterstack
        if num > 0 then
            local topfilter = self.actionfilterstack[num]
            for i = num - 1, 1, -1 do
                local filter = self.actionfilterstack[i]
                if filter.priority > topfilter.priority then
                    topfilter = filter
                end
            end
            self.actionfilter = topfilter.fn
        else
            self.actionfilter = nil
        end
    end

    function self:PushActionFilter(filterfn, priority)
        table.insert(self.actionfilterstack, { fn = filterfn, priority = priority or 0 })
        self:OnUpdateActionFilterStack()
    end

    function self:PopActionFilter(filterfn)
        if filterfn ~= nil then
            for i = #self.actionfilterstack, 1, -1 do
                if self.actionfilterstack[i].fn == filterfn then
                    table.remove(self.actionfilterstack, i)
                    self:OnUpdateActionFilterStack()
                    return
                end
            end
        else
            table.remove(self.actionfilterstack, #self.actionfilterstack)
            self:OnUpdateActionFilterStack()
        end
    end
    local _SortActionList = self.SortActionList
    function self:SortActionList(actions, target, useitem, ...)
        if self.actionfilter then
            if #actions == 0 then
                return actions
            end
        
            table.sort(actions, OrderByPriority)
        
            local ret = {}
        
            for i, v in ipairs(actions) do
                if self.actionfilter(self.inst, v) then
                    local distance = v == ACTIONS.CASTAOE and useitem ~= nil and useitem.components.aoetargeting ~= nil and useitem.components.aoetargeting:GetRange() or nil
                    if target == nil then
                        table.insert(ret, BufferedAction(self.inst, nil, v, useitem, nil, nil, distance, nil, nil))
                    elseif target:is_a(EntityScript) then
                        table.insert(ret, BufferedAction(self.inst, target, v, useitem, nil, nil, distance, nil, nil))
                    elseif target:is_a(Vector3) then
                        table.insert(ret, BufferedAction(self.inst, nil, v, useitem, target, nil, distance, nil, nil))
                    end
                end
            end
        end
        return _SortActionList(self, actions, target, useitem, ...)
    end
end
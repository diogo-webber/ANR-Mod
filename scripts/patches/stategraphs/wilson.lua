return function(self)
    if self.actionhandlers[ACTIONS.PICK] then
        local _PICK = self.actionhandlers[ACTIONS.PICK].deststate
        self.actionhandlers[ACTIONS.PICK].deststate = function(inst, action)
            local val = _PICK(inst, action)
            local obj = action.target
            
            if val == "dolongaction" and obj.components.pickable.jostlepick then
                return "dojostleaction"
            end
            
            return val
        end
    end

    self.events["canteatfood"] = EventHandler("canteatfood", function(inst)
        if inst.components.health and not inst.components.health:IsDead() then
            inst.sg:GoToState("refuseeat")
        end
    end)

    if self.states["caveenter"] then
        self.states["caveenter"].onenter = function(inst)
            inst.sg:GoToState("idle")
            local x, y, z = inst.Transform:GetWorldPosition()
            inst.Transform:SetPosition(x+0.001, y, z+0.001)
        end
    end
end

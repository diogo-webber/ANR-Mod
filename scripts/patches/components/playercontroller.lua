
local function notriding(inst)
	return not inst.components.rider or not inst.components.rider:IsRiding()
end

return function(self)
    function self:GetToolAction(tool)
        local notags = {"FX", "NOCLICK"}
        if tool and tool.components.tool and tool.components.tool:CanDoAction(ACTIONS.NET) then
            local target = FindEntity(self.inst, 5, 
                function(guy) 					
                    return  guy.components.health and not guy.components.health:IsDead() and 
                            guy.components.workable and
                            guy.components.workable.action == ACTIONS.NET
                end, nil, notags)
            if target then
                return BufferedAction(self.inst, target, ACTIONS.NET, tool)
            end
        end
            

        local rad = 8
        local projectile = FindEntity(self.inst, rad, function(guy)			
            return guy.components.projectile
                and guy.components.projectile:IsThrown()
                and self.inst.components.catcher
                and self.inst.components.catcher:CanCatch()
        end, nil, notags)
        if projectile then
            return BufferedAction(self.inst, projectile, ACTIONS.CATCH)
        end
        
        rad = self.directwalking and 3 or 6
        --pickup
        local pickup = FindEntity(self.inst, rad, function(guy) return (guy.components.inventoryitem and guy.components.inventoryitem.canbepickedup and (not guy.components.sinkable or not guy.components.sinkable.sunken) and (not guy.components.mine or guy.components.mine.inactive)  ) or
                                                                        (tool and tool.components.tool and guy.components.workable and guy.components.workable.workable and guy.components.workable.workleft > 0 and tool.components.tool:CanDoAction(guy.components.workable.action)) or
                                                                        (guy.components.pickable and guy.components.pickable:CanBePicked() and guy.components.pickable.caninteractwith )  or
                                                                        (guy.components.stewer and guy.components.stewer.done) or
                                                                        (guy.components.crop and guy.components.crop:IsReadyForHarvest()) or
                                                                        (guy.components.burnable and guy.components.burnable:IsSmoldering()) or
                                                                        (guy.components.harvestable and guy.components.harvestable:CanBeHarvested()) or
                                                                        (guy.components.trap and guy.components.trap.issprung) or
                                                                        (guy.components.mine and guy.components.mine.issprung) or																	
                                                                        (guy.components.dryer and guy.components.dryer:IsDone()) or
                                                                        (guy.components.activatable and guy.components.activatable.inactive) or 
                                                                        (guy.components.drivable and guy.components.drivable.driver == nil) or 
                                                                        (tool and tool.components.tool and guy.components.hackable  and guy.components.hackable:CanBeHacked() and tool.components.tool:CanDoAction(ACTIONS.HACK)) or
                                                                        (tool and tool.components.tool and guy.components.shearable and guy.components.shearable:CanShear() and tool.components.tool:CanDoAction(ACTIONS.SHEAR)) or
                                                                        ((tool and tool.components.tool and tool.components.tool:CanDoAction(ACTIONS.SPY)) and ((guy.components.mystery and guy:HasTag("mystery")) or (guy.components.door and guy:HasTag("secret_room")))) or
                                                                        (tool and tool.components.dislodger and guy.components.dislodgeable and guy.components.dislodgeable:CanBeDislodged())
                                                                        end, nil, notags)
        if pickup then 
            local action = nil
            
            if notriding(self.inst) and (tool and tool.components.tool and pickup.components.workable and pickup.components.workable:IsActionValid(pickup.components.workable.action) and tool.components.tool:CanDoAction(pickup.components.workable.action)) then
                action = pickup.components.workable.action
            elseif notriding(self.inst) and pickup.components.trap and pickup.components.trap.issprung then
                action = ACTIONS.CHECKTRAP
            elseif notriding(self.inst) and pickup.components.mine and not pickup.components.mine.inactive and pickup.components.mine.issprung then
                action = ACTIONS.RESETMINE    		
            elseif notriding(self.inst) and pickup.components.activatable and pickup.components.activatable.inactive then
                action = ACTIONS.ACTIVATE
            elseif notriding(self.inst) and pickup.components.burnable and pickup.components.burnable:IsSmoldering() then
                action = ACTIONS.SMOTHER
            elseif notriding(self.inst) and pickup.components.inventoryitem and pickup.components.inventoryitem.canbepickedup and (not pickup.components.mine or pickup.components.mine.inactive) then 
                action = ACTIONS.PICKUP
            elseif notriding(self.inst) and pickup.components.pickable and pickup.components.pickable:CanBePicked() then 
                action = ACTIONS.PICK 
            elseif notriding(self.inst) and pickup.components.harvestable and pickup.components.harvestable:CanBeHarvested() then
                action = ACTIONS.HARVEST
            elseif notriding(self.inst) and pickup.components.crop and pickup.components.crop:IsReadyForHarvest() then
                action = ACTIONS.HARVEST
            elseif notriding(self.inst) and pickup.components.dryer and pickup.components.dryer:IsDone() then
                action = ACTIONS.HARVEST
            elseif notriding(self.inst) and pickup.components.stewer and pickup.components.stewer.done then
                action = ACTIONS.HARVEST
            elseif notriding(self.inst) and pickup.components.searchable then 
                action = ACTIONS.SEARCH
            elseif pickup.components.drivable and not pickup.components.drivable.driver then 
                action = ACTIONS.MOUNT
            elseif notriding(self.inst) and (tool and tool.components.tool and pickup.components.hackable  and pickup.components.hackable:CanBeHacked() and tool.components.tool:CanDoAction(ACTIONS.HACK)) then
                action = ACTIONS.HACK
            elseif notriding(self.inst) and (tool and tool.components.tool and pickup.components.shearable and pickup.components.shearable:CanShear() and tool.components.tool:CanDoAction(ACTIONS.SHEAR)) then
                action = ACTIONS.SHEAR
            elseif (tool and tool.components.tool and tool.components.tool:CanDoAction(ACTIONS.SPY)) and ((pickup.components.mystery and pickup:HasTag("mystery")) or (pickup.components.door and pickup:HasTag("secret_room"))) then
                action = ACTIONS.SPY
            elseif notriding(self.inst) and (tool and tool.components.dislodger and pickup.components.dislodgeable and pickup.components.dislodgeable:CanBeDislodged() ) then
                action = ACTIONS.DISLODGE
            end

            if action then
                return BufferedAction(self.inst, pickup, action, tool)
            end
        end

        rad = 4
        local door = FindEntity(self.inst, rad, function(guy)
            if guy.components.door and not guy.components.door.disabled and (not guy.components.burnable or not guy.components.burnable:IsBurning()) then
                return true
            end
        end, nil, notags)
        if door then
            if not self.inst.components.rider or not self.inst.components.rider:IsRiding() then
                return BufferedAction(self.inst, door, ACTIONS.USEDOOR)
            end
        end
    end

    function self:GetActionButtonAction()
        if self.actionbuttonoverride then
            return self.actionbuttonoverride(self.inst)
        end
        
        if self:IsEnabled() and not (self.inst.sg:HasStateTag("working") or self.inst.sg:HasStateTag("doing")) then
            local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            local action = self:GetToolAction(tool)
            if action then
                return action
            else
                tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
                return self:GetToolAction(tool)
            end
        end	
    end 

    function self:GetResurrectButtonAction()
        return self.inst:HasTag("playerghost") and self.inst.components.attuner:HasAttunement("remoteresurrector") and
            BufferedAction(self.inst, nil, ACTIONS.REMOTERESURRECT) or
            nil
    end
    
    function self:DoResurrectButton()
        if not self:IsEnabled() then
            return
        end
        local buffaction = self:GetResurrectButtonAction()
        if buffaction == nil then
            return
        else
            self.inst.components.locomotor:PushAction(buffaction, true)
        end
    end
end

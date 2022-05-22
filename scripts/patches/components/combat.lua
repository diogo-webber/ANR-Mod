local function IsPlayerGhost(guy)
	if guy and guy:HasTag("playerghost") then
		return nil
	else
		return guy
	end 
end

local function _CalcReflectedDamage(inst, attacker, dmg, weapon, stimuli, reflect_list)
    if inst == nil then
        return 0
    end

    local dmg = 0

    if inst.components.damagereflect ~= nil then
        local dmg1 = inst.components.damagereflect:GetReflectedDamage(attacker, dmg, weapon, stimuli)
        if dmg1 > 0 then
            dmg = dmg + dmg1
            table.insert(reflect_list, { inst = inst, attacker = attacker, reflected_dmg = dmg1 })
        end
    end

    if inst.components.inventory ~= nil then
        for k, v in pairs(EQUIPSLOTS) do
            local equip = inst.components.inventory:GetEquippedItem(v)
            if equip ~= nil and equip.components.damagereflect ~= nil then
                local dmg1 = equip.components.damagereflect:GetReflectedDamage(attacker, dmg, weapon, stimuli)
                if dmg1 > 0 then
                    dmg = dmg + dmg1
                    table.insert(reflect_list, { inst = equip, attacker = attacker, reflected_dmg = dmg1 })
                end
            end
        end
    end

    return dmg
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

    function self:CalcReflectedDamage(targ, dmg, weapon, stimuli, reflect_list)
        return targ.components.rider ~= nil
            and targ.components.rider:IsRiding()
            and (   _CalcReflectedDamage(targ.components.rider:GetMount(), self.inst, dmg, weapon, stimuli, reflect_list) +
                    _CalcReflectedDamage(targ.components.rider:GetSaddle(), self.inst, dmg, weapon, stimuli, reflect_list)
                )
            or _CalcReflectedDamage(targ, self.inst, dmg, weapon, stimuli, reflect_list)
    end

    local _DoAttack = self.DoAttack
    function self:DoAttack(targ, weapon, projectile, stimuli, instancemult, ...)
        _DoAttack(self, targ, weapon, projectile, stimuli, instancemult, ...)
        local reflected_dmg = 0
        local reflect_list = {}
        if targ.components.combat ~= nil then
            local mult =
                (   stimuli == "electric" or
                    (weapon ~= nil and weapon.components.weapon ~= nil and weapon.components.weapon.stimuli == "electric")
                )
                and not (targ:HasTag("electricdamageimmune") or
                        (targ.components.inventory ~= nil and targ.components.inventory:IsInsulated()))
                and TUNING.ELECTRIC_DAMAGE_MULT + TUNING.ELECTRIC_WET_DAMAGE_MULT * (targ.components.moisture ~= nil and targ.components.moisture:GetMoisturePercent() or (targ:GetIsWet() and 1 or 0))
                or 1
            local dmg = self:CalcDamage(targ, weapon, mult) * (instancemult or 1)
            --Calculate reflect first, before GetAttacked destroys armor etc.
            if projectile == nil then
                reflected_dmg = self:CalcReflectedDamage(targ, dmg, weapon, stimuli, reflect_list)
            end
            targ.components.combat:GetAttacked(self.inst, dmg, weapon, stimuli)
        elseif projectile == nil then
            reflected_dmg = self:CalcReflectedDamage(targ, 0, weapon, stimuli, reflect_list)
        end
    
        --Apply reflected damage to self after our attack damage is completed
        if reflected_dmg > 0 and self.inst.components.health ~= nil and not self.inst.components.health:IsDead() then
            self:GetAttacked(targ, reflected_dmg)
            for i, v in ipairs(reflect_list) do
                if v.inst:IsValid() then
                    v.inst:PushEvent("onreflectdamage", v)
                end
            end
        end
    end
end
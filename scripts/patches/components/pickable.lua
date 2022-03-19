return function(self)
    self.droppicked = nil
    self.dropheight = nil

    local _Pick = self.Pick
    function self:Pick(picker, ...)
		if self.droppicked and self.inst.components.lootdropper then
			if self.canbepicked and self.caninteractwith then
				if self.transplanted then
					if self.cycles_left ~= nil then
						self.cycles_left = self.cycles_left - 1
					end
				end
				
				local loot = nil
				local pt = self.inst:GetPosition()
				pt.y = pt.y + (self.dropheight or 0)
				if self.use_lootdropper_for_product then
					self.inst.components.lootdropper:DropLoot(pt)
				else
					local num = self.numtoharvest or 1
					for i = 1, num do
						self.inst.components.lootdropper:SpawnLootPrefab(self.product, pt)
					end
				end
			
				if self.onpickedfn then
					self.onpickedfn(self.inst, picker, loot)
				end
				
				self.canbepicked = false
				
				if not self.paused and self.regentime and (self.cycles_left == nil or self.cycles_left > 0) then
					self.task = self.inst:DoTaskInTime(self.regentime, OnRegen, "regen")
					self.targettime = GetTime() + self.regentime
				end
				
				self.inst:PushEvent("picked", {picker = picker, loot = loot})
			end
		else
			_Pick(self, picker, ...)
		end
    end
end
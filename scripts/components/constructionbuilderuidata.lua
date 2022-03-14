local EMPTY_TABLE = {}

local ConstructionBuilderUIData = Class(function(self, inst)
    self.inst = inst

    self._containerinst = nil
    self._targetinst = nil
end)

function ConstructionBuilderUIData:SetContainer(containerinst)
    self._containerinst = containerinst
end

function ConstructionBuilderUIData:GetContainer()
    return self._containerinst
end

function ConstructionBuilderUIData:SetTarget(targetinst)
    self._targetinst = targetinst
end

function ConstructionBuilderUIData:GetTarget()
    return self._targetinst
end

function ConstructionBuilderUIData:GetConstructionSite()
    return self._targetinst and self._targetinst.components.constructionsite or nil
end

function ConstructionBuilderUIData:GetIngredientForSlot(slot)
    return (self._targetinstand (CONSTRUCTION_PLANS[self._targetinst.prefab] or EMPTY_TABLE)[slot] or EMPTY_TABLE).type
end

function ConstructionBuilderUIData:GetSlotForIngredient(prefab)
    if self._targetinst then
        for i, v in ipairs(CONSTRUCTION_PLANS[self._targetinst.prefab] or EMPTY_TABLE) do
            if v.type == prefab then
                return i
            end
        end
    end
end

return ConstructionBuilderUIData

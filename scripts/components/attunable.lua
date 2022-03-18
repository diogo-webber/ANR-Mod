local Attunable = Class(function(self, inst)
    self.inst = inst

    self.attuned = false

    --Tag specifies what group this belongs to since you
    --can only attune to one entity at a time per group.
    --e.g. Players can only attune one remoteresurrector
    --     at a time.
    --Tag can also be used in Attuner:HasAttunement(tag)
    self.attunable_tag = nil

    self.onattunecostfn = nil
    self.onlinkfn = nil
    self.onunlinkfn = nil

    self.onplayerattuned = function(player, data)
        if data.prefab == inst.prefab then
            --Player has attuned to another of the same prefab
            self:UnlinkFromPlayer(player, data.isloading)
        end
    end

    self.onplayerremoved = function(player)
        self.attuned = false
    end

    self.onplayerjoined = function(world, player)
        self:LinkToPlayer(player, true)
    end
end)

function Attunable:OnRemoveEntity()
    if self.attuned then
        self:UnlinkFromPlayer(GetPlayer())
    end
end

Attunable.OnRemoveFromEntity = Attunable.OnRemoveEntity

function Attunable:GetAttunableTag()
    return self.attunable_tag
end

function Attunable:SetAttunableTag(tag)
    self.attunable_tag = tag
    self.inst:AddTag(tag)
end

function Attunable:SetOnAttuneCostFn(fn)
    self.onattunecostfn = fn
end

function Attunable:SetOnLinkFn(fn)
    self.onlinkfn = fn
end

function Attunable:SetOnUnlinkFn(fn)
    self.onunlinkfn = fn
end

function Attunable:IsAttuned(player)
    return self.attuned
end

function Attunable:CanAttune(player)
    return player.components.attuner ~= nil and not self:IsAttuned(player)
end

function Attunable:LinkToPlayer(player, isloading)
    if not self:CanAttune(player) then
        return false
    end

    if not isloading and self.onattunecostfn ~= nil then
        local success, reason = self.onattunecostfn(self.inst, player)
        if not success then
            return false, reason
        end
    end
    self.attuned = true
    -- self.attuned[player] = SpawnPrefab("attunable_classified")
    -- if self.attunable_tag ~= nil then
    --     self.attuned[player]:AddTag(self.attunable_tag)
    -- end
    -- self.attuned[player]:AttachToPlayer(player, self.inst)

    player:PushEvent("attuned", { prefab = self.inst.prefab, isloading = isloading })
    self.inst:ListenForEvent("onremove", self.onplayerremoved, player)
    self.inst:ListenForEvent("attuned", self.onplayerattuned, player)

    if self.onlinkfn ~= nil then
        self.onlinkfn(self.inst, player, isloading)
    end
    return true
end

function Attunable:UnlinkFromPlayer(player, isloading)
    if not self:IsAttuned(player) then
        return
    end

    self.attuned = false

    self.inst:RemoveEventCallback("onremove", self.onplayerremoved, player)
    self.inst:RemoveEventCallback("attuned", self.onplayerattuned, player)

    if self.onunlinkfn ~= nil then
        self.onunlinkfn(self.inst, player, isloading)
    end
end

function Attunable:OnSave()
    local data = {}
    data.attuned = self.attuned or false
    return data
end

function Attunable:OnLoad(data)
    if data then
        self.attuend = data.attuned or false
        if self.attuned then
            self:LinkToPlayer(GetPlayer(), true)
        end
    end
end

function Attunable:GetDebugString()
    local str = "\n          online:"
    return str
end

function Attunable:CollectSceneActions(doer, actions)
    if doer.components.attuner ~= nil and
        not doer.components.attuner:IsAttunedTo(self.inst) then
        table.insert(actions, ACTIONS.ATTUNE)
    end
end

return Attunable

local Attuner = Class(function(self, inst)
    self.inst = inst

    self.attuned = {}
end)

function Attuner:IsAttunedTo(target)
    return self.attuned[target]
end

function Attuner:HasAttunement(tag)
    for k, v in pairs(self.attuned) do
        if k:HasTag(tag) then
            return true
        end
    end
    return false
end

function Attuner:GetAttunedTarget(tag)
    for k, v in pairs(self.attuned) do
        if k:HasTag(tag) then
            return k
        end
    end
end

function Attuner:RegisterAttunedSource(source)
    if not self.attuned[source] then
        self.attuned[source] = true
        self.inst:PushEvent("gotnewattunement", { source = source })
    end
end

function Attuner:UnregisterAttunedSource(source)
    if self.attuned[source] then
        self.attuned[source] = nil
        self.inst:PushEvent("attunementlost", { source = source })
    end
end

function Attuner:GetDebugString()
    local str = ""

    for k, v in ipairs(self.attuned) do
        str = str.."\n          "..tostring(v)
    end

    return str
end

return Attuner

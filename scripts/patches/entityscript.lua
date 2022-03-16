return function(self)
    function self:GetBasicDisplayName()
        return (self.displaynamefn ~= nil and self:displaynamefn())
        or (self.nameoverride ~= nil and STRINGS.NAMES[string.upper(self.nameoverride)])
        or self.name
    end
end
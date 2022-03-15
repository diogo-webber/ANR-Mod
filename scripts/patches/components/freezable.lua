return function(self)
    function self:Reset()
        self.state = "NORMAL"
        self.coldness = 0
        self:UpdateTint()
    end
end
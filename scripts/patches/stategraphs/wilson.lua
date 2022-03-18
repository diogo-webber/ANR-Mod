return function(self)
    for _, data in pairs(self.states) do

        if data.name == "caveenter" then
            data.onenter = function(inst)
                inst.sg:GoToState("idle")
                local x, y, z = GetPlayer().Transform:GetWorldPosition()
                GetPlayer().Transform:SetPosition(x+0.001, y, z+0.001)
            end
        end
    end
end

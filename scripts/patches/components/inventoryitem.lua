return function(self)
    function self:SetANRAtlas(num)
        self.atlasname = num and "images/inventoryimages"..num.."_anr.xml" or "images/inventoryimages.xml"
    end
end
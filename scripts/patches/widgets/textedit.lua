return function(self)
    function self:SetForceEdit(force)
        self.force_edit = force
    end

    function self:EnableRegionSizeLimit(enable)
        self.regionlimit = enable
    end
   
    function self:SetHelpTextEdit(str)
        if str then
            self.edit_helptext = str
        end
    end

    function self:SetHelpTextCancel(str)
        if str then
            self.cancel_helptext = str
        end
    end

    function self:SetHelpTextApply(str)
        if str then
            self.apply_helptext = str
        end
    end
end
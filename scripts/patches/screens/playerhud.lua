local WriteableWidget = require("widgets/writeablewidget")

return function(self)
    function self:ShowWriteableWidget(writeable, config)
        if writeable == nil then
            return
        else
            self.writeablescreen = WriteableWidget(self.owner, writeable, config)
            TheFrontEnd:PushScreen(self.writeablescreen)
            if TheFrontEnd:GetActiveScreen() == self.writeablescreen then
                -- Have to set editing AFTER pushscreen finishes.
                self.writeablescreen.edit_text:SetEditing(true)
            end
            return self.writeablescreen
        end
    end
    
    function self:CloseWriteableWidget()
        if self.writeablescreen then
            self.writeablescreen:Close()
            self.writeablescreen = nil
        end
    end
end
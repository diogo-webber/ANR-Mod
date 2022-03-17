require "behaviours/wander"
require "behaviours/panic"
require "behaviours/follow"
require "behaviours/runaway"

return function(self)
	local haunt = WhileNode( function() return self.inst.components.hauntable and self.inst.components.hauntable.panic end, "PanicHaunted", Panic(self.inst))
	table.insert(self.bt.root.children, 1, haunt)
end
require "behaviours/wander"
require "behaviours/panic"
require "behaviours/follow"
require "behaviours/runaway"
require "behaviours/chattynode"

return function(self)
	local haunt = WhileNode( function() return self.inst.components.hauntable and self.inst.components.hauntable.panic end, "PanicHaunted",
	ChattyNode(self.inst, STRINGS.PIG_TALK_PANICHAUNT,
		Panic(self.inst)))
	table.insert(self.bt.root.children, 1, haunt)
end
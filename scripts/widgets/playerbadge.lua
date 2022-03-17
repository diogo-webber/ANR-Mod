local Image = require "widgets/image"
local Widget = require "widgets/widget"
local UIAnim = require "widgets/uianim"

local DEFAULT_ATLAS = "images/avatars.xml"
local DEFAULT_AVATAR = "avatar_unknown.tex"

function GetPlayerBadgeData(character, ghost, state_1, state_2, state_3 )
	if character == "wormwood" then
		if ghost then
			return "ghost", "idle", "ghost_skin", .15, -55
		else
			if state_1 then
				return "wilson", "idle_loop_ui", "stage_2", .23, -50
			elseif state_2 then
				return "wilson", "idle_loop_ui", "stage_3", .23, -50
			elseif state_3 then
				return "wilson", "idle_loop_ui", "stage_4", .23, -50
			else
				return "wilson", "idle_loop_ui", "normal_skin", .23, -50
			end
		end
	elseif character == "woodie" then
		if ghost then
			if state_1 then
				return "ghost", "idle", "ghost_werebeaver_skin", .15, -55
			elseif state_2 then
				return "ghost", "idle", "ghost_weremoose_skin", .15, -55
			elseif state_3 then
				return "ghost", "idle", "ghost_weregoose_skin", .15, -55
			else
				return "ghost", "idle", "ghost_skin", .15, -55
			end
		else
			if state_1 then
				return "werebeaver", "idle_loop", "werebeaver_skin", .15, -28
			elseif state_2 then
				return "weremoose", "idle_loop", "weremoose_skin", .11, -40
			elseif state_3 then
				return "weregoose", "idle_loop", "weregoose_skin", .17, -24
			else
				return "wilson", "idle_loop_ui", "normal_skin", .23, -50
			end
		end
	else
		if ghost then
			return "ghost", "idle", "ghost_skin", .15, -55
		else
			return "wilson", "idle_loop_ui", "normal_skin", .23, -50
		end
	end
end

local PlayerBadge = Class(Widget, function(self, owner, prefab, colour, userflags)
    Widget._ctor(self, "PlayerBadge")
    self.owner = owner

    self.isFE = false
    self:SetClickable(false)

    self.root = self:AddChild(Widget("root"))

    self.icon = self.root:AddChild(Widget("target"))
    self.icon:SetScale(.8)

    self.userflags = 0 --we need a default for GetBG to not crash
    self.headbg = self.icon:AddChild(Image(DEFAULT_ATLAS, self:GetBG()))
    self:_SetupHeads()

	self.loading_icon = self.icon:AddChild(Image(DEFAULT_ATLAS, "loading_indicator.tex"))
	self.loading_icon:Hide()

    self.headframe = self.icon:AddChild(Image(DEFAULT_ATLAS, "avatar_frame_white.tex"))

    self:Set(prefab, colour, userflags)
end)

function PlayerBadge:_SetupHeads()
    self.head = self.icon:AddChild(Image( DEFAULT_ATLAS, DEFAULT_AVATAR ))
end

function PlayerBadge:Set(prefab, colour, userflags, base_skin)
    self.headframe:SetTint(unpack(colour))
    self.head:SetTexture(DEFAULT_ATLAS, "avatar_"..prefab..".tex")

    local dirty = false

    if self.base_skin ~= base_skin then
        self.base_skin = base_skin
        dirty = true
    end

    if self.prefabname ~= prefab then
        if table.contains(GetOfficialCharacterList(), prefab) then
            self.prefabname = prefab
            self.is_mod_character = false
        elseif table.contains(MODCHARACTERLIST, prefab) then
            self.prefabname = prefab
            self.is_mod_character = true
        elseif prefab == "random" then
            self.prefabname = "random"
            self.is_mod_character = false
        else
            self.prefabname = ""
            self.is_mod_character = (prefab ~= nil and #prefab > 0)
        end
        dirty = true
    end
    if self.userflags ~= userflags then
        self.userflags = userflags
        dirty = true
    end
    if dirty then
        self.headbg:SetTexture(DEFAULT_ATLAS, self:GetBG())
    end

	if self:IsLoading() then
		if not self.loading_icon.shown then
			self.loading_icon:Show()
			local function dorotate() self.loading_icon:RotateTo(0, -360, 1, dorotate) end
			self.loading_icon:CancelRotateTo()
			dorotate()
            self.head:SetTint(0,0,0,1)
		end
	else
		if self.loading_icon.shown then
			self.loading_icon:Hide()
			self.loading_icon:CancelRotateTo()
			self.head:SetTint(1,1,1,1)
		end
	end
end

function PlayerBadge:IsGhost()
    return self.owner:HasTag("playerghost")
end

function PlayerBadge:IsCharacterState1()
    return false --checkbit(self.userflags, USERFLAGS.CHARACTER_STATE_1)
end

function PlayerBadge:IsCharacterState2()
    return false --checkbit(self.userflags, USERFLAGS.CHARACTER_STATE_2)
end

function PlayerBadge:IsCharacterState3()
    return false --checkbit(self.userflags, USERFLAGS.CHARACTER_STATE_3)
end

function PlayerBadge:IsLoading()
    return false --checkbit(self.userflags, USERFLAGS.IS_LOADING)
end

function PlayerBadge:GetBG()
    return (self:IsGhost() and "avatar_ghost_bg.tex")
        or "avatar_bg.tex"
end

function PlayerBadge:GetAvatarImage()
    if self.prefabname == "" then
        return self.is_mod_character and "avatar_mod.tex" or "avatar_unknown.tex"
    end

    return DEFAULT_AVATAR
end

return PlayerBadge

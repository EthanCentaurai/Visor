--local L = AceLibrary("AceLocale-2.2"):new("Visor2")

--<< ================================================= >>--
--    Global Setup                                       --
--<< ================================================= >>--

Visor2 = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceEvent-2.0", "AceDB-2.0", "AceDebug-2.0", "AceModuleCore-2.0")
Visor2:SetModuleMixins("AceEvent-2.0")

local options = {
	type='group',
	args = {
		detail = {
			type = 'text',
			name = 'Detail',
			desc = "Displays all of Visor2's settings for the frame.",
			usage = "list|<frame name>",
			get = false,
			set = "DetailedReport",
			order = 1,
		},
		set = {
			type = 'text',
			name = 'Set',
			desc = "The core command within Visor2.  See '/vz help' for details.",
			usage = "<options>",
			get = false,
			set = "SetupFrame",
			order = 2,
		},
		del = {
			type = 'text',
			name = 'Delete',
			desc = "Delete the Visor2 settings for a frame.  An example of this would be; '/vz del PlayerFrame'.  Requires re-logging, or a '/script ReloadUI()' afterward to take effect.",
			usage = "<frame name>",
			get = false,
			set = "DeleteFrame",
			order = 3,
		},
		global = {
			type = 'text',
			name = 'Global',
			desc = "Use this option to set the global UI-scale.  This allows scales beyond the range in the default UI menu, but please be practical.",
			usage = "<decimal number, ideally 0.5 to 1.5>",
			get = function() return GetCVar("uiScale") end,
			set = "SetGlobalScale",
			order = 4,
		},
		reset = {
			type = 'text',
			name = 'Reset',
			desc = "Remove Visor2's records for all frames, for this profile.  Requires re-logging, or a '/script ReloadUI()' afterward to take effect.",
			usage = "CONFIRM",
			get = false,
			set = "ResetOptionsConfirm",
			order = 5,
		},
		help = {
			type = 'text',
			name = 'Help',
			desc = "List the options available for the '/vz set' command.",
			usage = "[ general | f | s | p | pr | p1 | p2 | x | y | c | ht | wh | n | h | a | st | l ]",
			get = false,
			set = "PrintOutHelp",
			order = 6,
		},
	},
}

Visor2:RegisterChatCommand(VisorLocals.ChatCmd, options)
Visor2:RegisterDB("Visor2DB", "Visor2DBPC")
Visor2:RegisterDefaults("profile", {
	frames = {},
})

--<< ================================================= >>--
--    Initialize                                         --
--<< ================================================= >>--

function Visor2:OnInitialize()
	self.tooltip = "BTooltip"
	self.args = {}
	self.Chk = function(v, t)
			if not t then return v or VisorLocals.Chat_Default end
	            return v and floor(v) or VisorLocals.Chat_Default
	           end

	--self:Print("Visor2 Initialized")
end

--<< ================================================= >>--
--    Enable/Disable, Hooks, Events, Et Cetera           --
--<< ================================================= >>--

function Visor2:OnEnable()
	self:RegisterEvent("ADDON_LOADED", "RefreshVisor")
	self:Print("Visor2 Enabled")
end

function Visor2:OnDisable()
	self:Print("Visor2 Disabled")
	self:ResetFrames()
end

function Visor2:RefreshVisor()
	self:Debug("Called RefreshVisor")
	self:TriggerEvent("VISOR_UPDATE", {ref = TRUE})
end

--<< ================================================= >>--
--    Utility Functions                                  --
--<< ================================================= >>--

function Visor2:ParseByName41(i, p, s, q)
	local tmpDB = {}
	p = p or "=" s = s or " " q = q or "\"" i = i..s
	string.gsub(i, "(%a[%a%d_]-)"..p.."("..q.."?)(.-)%2"..s, function(k, _,  v) tmpDB[k] = string.gsub(v, "\\"..s, s) end)
	return tmpDB
end

--<< ================================================= >>--
--    The Chat Options.                                  --
--<< ================================================= >>--

function Visor2:SetupFrame(v)
	--self:Debug("SetupFrame: currentCmd = " .. v .. ", activeFrame = " .. self.f)

	local p = Visor2:ParseByName41(v, nil, nil, nil)
	p.f = p.f or self.f
	if p.gf then
		if GetMouseFocus() then
			local f = GetMouseFocus():GetName()
			if f == "WorldFrame" or f == "UIParent" then
			return
			else p.f = f
			end
		end
	end

	local np
	for _, v in pairs(self.args) do --self.args do
		if p[v] then np = true end
	end

	if not getglobal(p.f) and not np then
		self:Print(VisorLocals.Chat_NoSuchFrame, (p.f or "Unknown"))
		return
	end

	self.f = p.f
	if not p.sl and not np then
		self:Print(VisorLocals.Chat_ActiveFrame, p.f)
		Visor2:Debug(format(VisorLocals.Debug_Frame, p.f))
		Visor2:Debug(format(VisorLocals.Debug_ObjType, type(db)))
	end

	local db = (self.db.profile.frames[p.f] or {})
	self:TriggerEvent("VISOR_UPDATE", p, db, self.f)
end

function Visor2:Do(v, pf)
	pf = self.f
	self:SetupFrame(v.." sl=TRUE")
	self.f = pf
end

function Visor2:DeleteFrame(v)
	if self.db.profile.frames[v] then
		self.db.profile.frames[v] = nil
		self:Print(VisorLocals.Chat_FrameDeleted, v)
	else
		self:Print(VisorLocals.Chat_NotInDB, v)
	end
end

function Visor2:ResetOptions()
	self:Print(VisorLocals.chatResetNo)
end

function Visor2:ResetOptionsConfirm()
	self:ResetDB("profile")
	self:Print(VisorLocals.chatResetYes)
end

function Visor2:PrintOutHelp(v)
	-- "[general|f|s|wh|ht|p|pr|p1|p2|x|y|c|n|h|a|st|l]",
	local hd = "Notes about the [" .. v .. "] option:"

	self:Print("\n")
	if v == "general" then
		self:Print("General tips and information:")
		self:Print("Any/all of these options may be used together.  Typing '/vz set f=PlayerFrame pr=UIParent p1=CENTER p2=CENTER x=0 y=-200' is no different from typing each of the commands on its own line.")
		self:Print("Other Notes:  When moving a frame, the relative parent (pr) and anchor points (p1, p2) should be assigned before setting the offsets (x, y).  The 'move to mouse' option (c) implicitly sets the relative parent to UIParent.")
	elseif v == "f" then
		self:Print(hd)
		self:Print("Sets the active frame.")
		self:Print("All options that follow will be applied to this frame.")
		self:Print("Example: '/vz set f=PlayerFrame'")
		self:Print("Important: Argument MUST be a valid WoW frame.")
	elseif v == "s" then
		self:Print(hd)
		self:Print("Sets the scale of the active frame.")
		self:Print("Example: '/vz set s=0.5'")
		self:Print("Important: Set the x or y value again afterward to bring the frame back into view.")
	elseif v == "wh" then
		self:Print(hd)
		self:Print("Sets the width of the active frame.")
		self:Print("Example: '/vz set wh=150'")
		self:Print("Important: This will cause the frame to skew horizontally unless a proportionate height is also assigned.  For proportional scaling, use the 's' option.")
	elseif v == "ht" then
		self:Print(hd)
		self:Print("Sets the height of the active frame.")
		self:Print("Example: '/vz set ht=100'")
		self:Print("Important: This will cause the frame to skew vertically unless a proportionate width is also assigned.  For proportional scaling, use the 's' option.")
	elseif v == "p" then
		self:Print(hd)
		self:Print("Sets the parent of the active frame.")
		self:Print("Example: '/vz set p=UIParent'")
		self:Print("Important: The parent controls things like a frame's visibility, transparency and scaling, in addition to its position.  Setting a parent for a frame implicitly sets its relative parent as well.  For positional anchoring only, use 'pr'.")
	elseif v == "pr" then
		self:Print(hd)
		self:Print("Sets the 'relative' parent of the active frame.")
		self:Print("Example: '/vz set pr=UIParent'")
		self:Print("Important: The relative parent provides an coordinate reference point.")
		self:Print("Often used with the options 'p1', 'p2', 'x', 'y'.")
	elseif v == "p1" then
		self:Print(hd)
		self:Print("Sets the anchor point on active frame.")
		self:Print("Example: '/vz set p1=CENTER'")
		self:Print("Important: This is the point ON the active frame where it will attach to its relative parent.  The 'x' and 'y' options are then used to shift the frame horizontally or vertically.  Possible values include TOPLEFT, TOP, TOPRIGHT, LEFT, CENTER, RIGHT, BOTTOMLEFT, BOTTOM, BOTTOMRIGHT.  These values are case-sensitive.")
	elseif v == "p2" then
		self:Print(hd)
		self:Print("Sets the anchor point on active frame's relative parent.")
		self:Print("Example: '/vz set p2=CENTER'")
		self:Print("Important: This is the point on the active frame's RELATIVE PARENT to which the frame's anchor will attach.  Possible values include TOPLEFT, TOP, TOPRIGHT, LEFT, CENTER, RIGHT, BOTTOMLEFT, BOTTOM, BOTTOMRIGHT.  These values are case-sensitive.")
	elseif v == "x" then
		self:Print(hd)
		self:Print("Sets the horizontal anchor offset.")
		self:Print("Example: '/vz set x=120'")
		self:Print("Important: This is the horizontal distance between the active frame's anchor point and the anchor point on its relative parent.")
	elseif v == "y" then
		self:Print(hd)
		self:Print("Sets the vertical anchor offset.")
		self:Print("Example: '/vz set y=50'")
		self:Print("Important: This is the vertical distance between the active frame's anchor point and the anchor point on its relative parent.")
	elseif v == "c" then
		self:Print(hd)
		self:Print("Sets the center of the active frame to the mouse location.")
		self:Print("Example: '/vz set c=TRUE'")
		self:Print("Important: This will clear any pre-existing relative parent setting and set it to 'UIParent' instead.")
	elseif v == "n" then
		self:Print(hd)
		self:Print("Sets the nudge factor.")
		self:Print("Example: '/vz set n=1'")
		self:Print("Important: Keybindings must be assigned for the four nudge directions (up/down/left/right).  This value is the number of pixels that each nudge operation will move the active frame.")
	elseif v == "h" then
		self:Print(hd)
		self:Print("Sets the visibility of the active frame.")
		self:Print("Example: '/vz set h=TRUE' (or) '/vz set h=FALSE'")
		self:Print("Important: Setting the hide to TRUE will make the frame invisible.  Setting to FALSE will show it again.")
	elseif v == "a" then
		self:Print(hd)
		self:Print("Sets the alpha transparency of the active frame.")
		self:Print("Example: '/vz set a=0.5'")
		self:Print("Important: This requires a value between 0 (invisible) and 1 (completely opaque).")
	elseif v == "st" then
		self:Print(hd)
		self:Print("Sets the frame strata of the active frame.")
		self:Print("Example: '/vz set st=TOOLTIP'")
		self:Print("Important: Strata determines which frames show on top of other frames.  From lowest to highest, the strata are: BACKGROUND, LOW, MEDIUM, HIGH, DIALOG, FULLSCREEN, FULLSCREEN_DIALOG, TOOLTIP.  These values are case-sensitive.")
		self:Print("Some words of caution: if you set your frame strata to 'BACKGROUND' it will be blocked from receiving mouse events unless you set frame level to 1 or more.  Same goes for 'TOOLTIP' regardless of frame level.  To set frame level, see the 'l' option.")
	elseif v == "l" then
		self:Print(hd)
		self:Print("Sets the frame level of the active frame.")
		self:Print("Example: '/vz set l=2'")
		self:Print("Important: Using this option is not advised unless you know what you're doing.  For reference - level 0 implies no parent, level 1 implies UIParent as the parent, 2 and higher are open-ended.")
	end
end

function Visor2:DetailedReport(f)
	local rpt_db
	--local foundframes = FALSE

	if f == "list" then
		rpt_db = self.db.profile.frames
		if rpt_db then
			self:Print("Managing details for the following frames:")
			for k, v in pairs(rpt_db) do
				self:Print(" - " .. k)
				--foundframes = TRUE
			end
			--if foundframes == FALSE then
			--	self:Print("  (none)")
			--end
		else
			self:Print("Not managing details for any frames.")
		end
	else
		rpt_db = self.db.profile.frames[f]
		if rpt_db then
			self:Print("Managing these details for [" .. f .. "]:")
			for k, v in pairs(rpt_db) do
				self:Print(" - " .. k .. " = [" .. v .. "]")
			end
		else
			self:Print("Not managing any details for [" .. f .. "].")
		end
	end
end

--<< ================================================= >>--
--    The Global Scale Function                          --
--<< ================================================= >>--

function Visor2:SetGlobalScale(i)
	SetCVar("uiScale", tonumber(i))
	self:Print(VisorLocals.Chat_GlobalScale, i)
end

--<< ================================================= >>--
--    The Frames Reset Function                          --
--<< ================================================= >>--

function Visor2:ResetFrames()
	self:Print(VisorLocals.Misc_ReloadUI)
end

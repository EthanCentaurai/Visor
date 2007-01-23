--<< ================================================= >>--
--    Initialize the Object                              --
--<< ================================================= >>--

Visor2Nudge = Visor2:NewModule("Nudge")

--<< ================================================= >>--
--    Call the Update Event                              --
--<< ================================================= >>--

function Visor2Nudge:OnEnable()
	self:RegisterEvent("VISOR_UPDATE")
end

--<< ================================================= >>--
--    The Chat Handler                                   --
--<< ================================================= >>--

function Visor2Nudge:VISOR_UPDATE(pb, f)
	Visor2:Debug("Called Nudge:VISOR_UPDATE")
	Visor2.f = pb.f or f
	if not pb.n then return end
	Visor2.n = tonumber(pb.n)
	Visor2:Print(VisorLocals.Chat_NudgeSet, pb.n)
end

--<< ================================================= >>--
--    The Nudge Functions                                --
--<< ================================================= >>--

function Visor2Nudge:Up()
	if not Visor2.f then return end
	local v_getglobal = getglobal
	local db = Visor2.db.profile.frames[Visor2.f] or {}
	if not v_getglobal(Visor2.f).GetCenter then
		Visor2:Print(VisorLocals.Chat_NoMove)
		return
	end		
	local x, y = v_getglobal(Visor2.f):GetCenter()
	if not x or not y then
		Visor2:Print(VisorLocals.Chat_CannotBeMoved)
		return
	end
	y = (db.y or y) + (Visor2.n or 45)
	x = db.x or x
	Visor2:SetupFrame("x="..x.." y="..y.." sl=TRUE")
end

function Visor2Nudge:Down()
	if not Visor2.f then return end
	local v_getglobal = getglobal
	local db = Visor2.db.profile.frames[Visor2.f] or {}
	if not v_getglobal(Visor2.f).GetCenter then
		Visor2:Print(VisorLocals.Chat_NoMove)
		return
	end		
	local x, y = v_getglobal(Visor2.f):GetCenter()
	if not x or not y then
		Visor2:Print(VisorLocals.Chat_CannotBeMoved)
		return
	end
	y = (db.y or y) - (Visor2.n or 45)
	x = db.x or x
	Visor2:SetupFrame("x="..x.." y="..y.." sl=TRUE")
end

function Visor2Nudge:Right()
	if not Visor2.f then return end
	local v_getglobal = getglobal
	local db = Visor2.db.profile.frames[Visor2.f] or {}
	if not v_getglobal(Visor2.f).GetCenter then
		Visor2:Print(VisorLocals.Chat_NoMove)
		return
	end		
	local x, y = v_getglobal(Visor2.f):GetCenter()
	if not x or not y then
		Visor2:Print(VisorLocals.Chat_CannotBeMoved)
		return
	end
	x = (db.x or x) + (Visor2.n or 110)
	y = db.y or y
	Visor2:SetupFrame("x="..x.." y="..y.." sl=TRUE")
end

function Visor2Nudge:Left()
	if not Visor2.f then return end
	local v_getglobal = getglobal
	local db = Visor2.db.profile.frames[Visor2.f] or {}
	if not v_getglobal(Visor2.f).GetCenter then
		Visor2:Print(VisorLocals.Chat_NoMove)
		return
	end		
	local x, y = v_getglobal(Visor2.f):GetCenter()
	if not x or not y then
		Visor2:Print(VisorLocals.Chat_CannotBeMoved)
		return
	end
	x = (db.x or x) - (Visor2.n or 110)
	y = db.y or y
	Visor2:SetupFrame("x="..x.." y="..y.." sl=TRUE")
end



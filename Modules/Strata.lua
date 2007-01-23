--<< ================================================= >>--
--    Initialize the Object                              --
--<< ================================================= >>--

Visor2Strata = Visor2:NewModule("Strata")

--<< ================================================= >>--
--    Call the Update Event                              --
--<< ================================================= >>--

function Visor2Strata:OnEnable()
	Visor2:StrataFrames()
	Visor2:FrameLevel()
	self:RegisterEvent("VISOR_UPDATE")
end

--<< ================================================= >>--
--    The Chat Handler                                   --
--<< ================================================= >>--

function Visor2Strata:VISOR_UPDATE(p, db, f)
	if p.det then
		--[[
		for k, v in pairs(Visor2.db.profile.frames) do
			if p.det == strlower(k) then
				tinsert(Visor2.detailDB,
				 {text = VisorLocals.Report_Strata,
				  val  = v.st or VisorLocals.Report_Standard})
				tinsert(Visor2.detailDB,
				 {text = VisorLocals.Report_Level,
				  val  = v.l or VisorLocals.Report_Standard})
			end
		end
		]]
		return
	end
	if p.ref then
		self:OnEnable()
		return
	end
	
	if not (p.st or p.l) then return end
	p.f = p.f or f
	db.st = p.st or db.st
	db.l = p.l or db.l
	Visor2.db.profile.frames[p.f] = db
	if p.st then Visor2:StrataFrames(p.f, db) end
	if p.l then Visor2:FrameLevel(p.f, db) end
	if p.sl then return end
	p.st = Visor2.Chk(p.st)
	p.l = Visor2.Chk(p.l)
	Visor2:Print(VisorLocals.Chat_StrataSet, p.st, p.f)
	Visor2:Print(VisorLocals.Chat_LevelSet, p.l, p.f)
end

--<< ================================================= >>--
-- Section IV: The Strata Function.                       --
--<< ================================================= >>--

function Visor2:StrataFrames(f, db)
	local v_getglobal = getglobal
	if f and db.st then
		Visor2:Debug(format(VisorLocals.Debug_Strata, f))
		v_getglobal(f):SetFrameStrata(db.st)
		return
	end
	for k, v in pairs(Visor2.db.profile.frames) do
		if v_getglobal(k) and v.st then
			Visor2:Debug(format(VisorLocals.Debug_Strata, k))
			v_getglobal(k):SetFrameStrata(v.st)
		end
	end
end

function Visor2:FrameLevel(f, db)
	local v_getglobal = getglobal
	if f and db.l then
		Visor2:Debug(format(VisorLocals.Debug_Level, f))
		v_getglobal(f):SetFrameLevel(db.l)
		return
	end
	for k, v in pairs(Visor2.db.profile.frames) do
		if v_getglobal(k) and v.l then
			Visor2:Debug(format(VisorLocals.Debug_Level, k))
			v_getglobal(k):SetFrameLevel(v.l)
		end
	end
end

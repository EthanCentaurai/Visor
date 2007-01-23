--<< ================================================= >>--
--    Initialize the Object                              --
--<< ================================================= >>--

Visor2Alpha = Visor2:NewModule("Alpha")

--<< ================================================= >>--
--    Call the Update Event                              --
--<< ================================================= >>--

function Visor2Alpha:OnEnable()
	Visor2:AlphaFrames()
	self:RegisterEvent("VISOR_UPDATE")
end

--<< ================================================= >>--
--    The Chat Handler                                   --
--<< ================================================= >>--

function Visor2Alpha:VISOR_UPDATE(p, db, f)
	if p.det then
		--[[
		for k, v in pairs(Visor2.db.profile.frames) do
			if p.det == strlower(k) then
				tinsert(Visor2.detailDB,
				 {text = VisorLocals.Report_Alpha,
				  val  = v.a and format("%.2f", v.a) or VisorLocals.Report_Standard})
			end
		end
		]]
		return
	end
	if p.ref then
		self:OnEnable()
		return
	end

	if not p.a then return end
	p.f = p.f or f
	db.a = p.a or db.a
	Visor2.db.profile.frames[p.f] = db
	if p.a then Visor2:AlphaFrames(p.f, db) end
	if p.sl then return end
	Visor2:Print(VisorLocals.Chat_AlphaSet, p.a, p.f)	
end

--<< ================================================= >>--
--    The Alpha Function                                 --
--<< ================================================= >>--

function Visor2:AlphaFrames(f, db)
	local v_getglobal = getglobal
	if f and db.a and not Visor2:StopExternalAlpha(f) then
		Visor2:Debug(format(VisorLocals.Debug_Alpha, f))
		v_getglobal(f):VisorSetAlpha(db.a)
		return
	end
	for k, v in pairs(Visor2.db.profile.frames) do
		if v_getglobal(k) and v.a and not Visor2:StopExternalAlpha(k) then
			Visor2:Debug(format(VisorLocals.Debug_Alpha, k))
			v_getglobal(k):VisorSetAlpha(v.a)
		end
	end
end

--<< ================================================= >>--
--    The Naughtyness Eradicators                        --
--<< ================================================= >>--

function Visor2:StopExternalAlpha(f)
	f               = getglobal(f)
	if not f then return TRUE end
	if f.VisorSetAlpha then return end
	f.VisorSetAlpha = f.SetAlpha
	f.SetAlpha      = function() end
end

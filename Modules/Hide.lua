--<< ================================================= >>--
--    Initialize the Object                              --
--<< ================================================= >>--

Visor2Hide = Visor2:NewModule("Hide")

--<< ================================================= >>--
--    Call the Update Event                              --
--<< ================================================= >>--

function Visor2Hide:OnEnable()
	Visor2:HideFrames()
	self:RegisterEvent("VISOR_UPDATE")
end

--<< ================================================= >>--
--    The Chat Handler                                   --
--<< ================================================= >>--

function Visor2Hide:VISOR_UPDATE(p, db, f)
	Visor2:Debug("Called Hide:VISOR_UPDATE")

	if p.det then
		--[[
		for k, v in pairs(Visor2.db.profile.frames) do
			if p.det == strlower(k) then
				tinsert(Visor2.detailDB,
				 {text = VisorLocals.Report_Hidden,
				  val  = v.h,
				  map  = ACEG_MAP_ONOFF})
			end
		end
		]]
		return
	end
	if p.ref then
		self:OnEnable()
		return
	end
	if not p.h then return end
	p.f = p.f or f
	db.h = p.h or db.h
	if p.h == "FALSE" then db.h = 0 end
	if p.h == "TRUE" then db.h = 1 end
	Visor2.db.profile.frames[p.f] = db
	if p.h then Visor2:HideFrames(p.f, db) end
	if p.sl then return end
	Visor2:Print(VisorLocals.Chat_HideSet, p.h, p.f)	
end

--<< ================================================= >>--
--    The Hide Function                                  --
--<< ================================================= >>--

function Visor2:HideFrames(f, db)
	local v_getglobal = getglobal
	if f and db.h == 1 and not Visor2:StopExternalHideShow(f) then
		v_getglobal(f):VisorHide()
		Visor2:Debug(format(VisorLocals.Debug_Hiding, f))
		return
	elseif f and db.h == 0 and not Visor2:StopExternalHideShow(f) then
		v_getglobal(f):VisorShow()
		Visor2:Debug(format(VisorLocals.Debug_Showing, f))
		return
	end
	for k, v in pairs(self.db.profile.frames) do
		if v_getglobal(k) and v.h == 1 and not Visor2:StopExternalHideShow(k) then
			Visor2:Debug(format(VisorLocals.Debug_Hiding, k))
			v_getglobal(k):VisorHide()
		elseif v_getglobal(k) and v.h == 0 and not Visor2:StopExternalHideShow(k) then
			v_getglobal(k):VisorShow()
		end
	end
end

--<< ================================================= >>--
--    The Naughtyness Eradicators                        --
--<< ================================================= >>--

function Visor2:StopExternalHideShow(f)
	f           = getglobal(f)
	if not f then return TRUE end
	if f.VisorHide then return end
	f.VisorHide = f.Hide
	f.VisorShow = f.Show
	f.Hide      = function() end
	f.Show      = function() end
end

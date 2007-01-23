--<< ================================================= >>--
--    Initialize the Object                              --
--<< ================================================= >>--

Visor2Basics = Visor2:NewModule("Basics")

--<< ================================================= >>--
--    Call the Update Event                              --
--<< ================================================= >>--

function Visor2Basics:OnEnable()
	Visor2:ScaleFrames()
	Visor2:MoveFrames()
	self:RegisterEvent("VISOR_UPDATE")
end

--<< ================================================= >>--
--    The Chat Handler                                   --
--<< ================================================= >>--

function Visor2Basics:VISOR_UPDATE(p, db, f)
	Visor2:Debug("Called Basics:VISOR_UPDATE")

	local ox, oy, es, os

	if p.det then
		--[[
		for k, v in pairs(Visor2.db.profile.frames) do --self.Get(nil, "framesDB") do
			if p.det == strlower(k) then
				tinsert(Visor2.detailDB,
				 {text = VisorLocals.Report_Frame,
				  val  = k or VisorLocals.Report_Standard})
				tinsert(Visor2.detailDB,
				 {text = VisorLocals.Report_Scale,
				  val  = v.s and format("%.2f", v.s) or VisorLocals.Report_Standard})
				tinsert(Visor2.detailDB,
				 {text = VisorLocals.Report_Height,
				  val  = v.ht or VisorLocals.Report_Standard})
				tinsert(Visor2.detailDB,
				 {text = VisorLocals.Report_Width,
				  val  = v.wh or VisorLocals.Report_Standard})
				tinsert(Visor2.detailDB,
				 {text = VisorLocals.Report_Relative,
				  val  = v.pr or VisorLocals.Report_Standard})
				tinsert(Visor2.detailDB,
				 {text = VisorLocals.Report_PointA,
				  val  = v.p1 or VisorLocals.Report_Standard})
				tinsert(Visor2.detailDB,
				 {text = VisorLocals.Report_PointB,
				  val  = v.p2 or VisorLocals.Report_Standard})
				tinsert(Visor2.detailDB,
				 {text = VisorLocals.Report_OffSetX,
				  val  = v.x and floor(v.x) or VisorLocals.Report_Standard})
				tinsert(Visor2.detailDB,
				 {text = VisorLocals.Report_OffSetY,
				  val  = v.y and floor(v.y) or VisorLocals.Report_Standard})

			end
		end
		]]
		return
	end

	local v_getglobal = getglobal

	if p.ref then
		Visor2:Debug("Refresh section in Basics:VISOR_UPDATE")
		self:OnEnable()
		return
	end

	if p.s or p.x or p.y or p.p1 or p.p2 or p.pr or p.c or p.wh or p.ht then
	else
		return
	end

	p.f = p.f or f
	if p.x then
		Visor2:Debug("1: "..p.x)
	else
		Visor2:Debug("1: nil")
	end
	
	if v_getglobal(p.f).GetScale then
		os = v_getglobal(p.f):GetScale()
		es = v_getglobal(p.f):GetEffectiveScale()
	else
		os = v_getglobal("UIParent"):GetScale()
		es = v_getglobal("UIParent"):GetEffectiveScale()
		p.s = nil
	end

	if v_getglobal(p.f).GetCenter then
		ox, oy = v_getglobal(p.f):GetCenter()
	else
		p.c = nil
	end

	if p.c and p.pr or p.c and p.p2 then
		Visor2:Print(VisorLocals.Misc_NotHappening)
		return
	end
	if p.c or p.x or p.y then
		p.pr       = p.pr or db.pr or "UIParent"
		p.p1, p.p2 = p.p1 or db.p1 or "CENTER", p.p2 or db.p2 or "BOTTOMLEFT"
	end
	if p.c then
		p.x, p.y = GetCursorPosition(UIParent)
		p.p1, p.p2 = "CENTER", "BOTTOMLEFT"
		p.pr = "UIParent"
		if v_getglobal(p.f).GetScale then
			p.s = p.s or v_getglobal(p.f):GetScale()
			Visor2:Debug("p.s:  "..p.s)
		else
			p.s = v_getglobal("UIParent"):GetScale()
			Visor2:Debug("p.s UIParent")
		end
		if p.x then
			Visor2:Debug("2: "..p.x)
		else
			Visor2:Debug("2: nil")
		end
	end

	if p.pr then
		db.x, db.y = db.x or 0, db.y or 0
	end

	db.s = p.s or db.s
	db.x = p.x or db.x
	db.y = p.y or db.y
	db.p1 = p.p1 or db.p1
	db.pr = p.pr or db.pr
	db.p2 = p.p2 or db.p2
	db.ht = p.ht or db.ht
	db.wh = p.wh or db.wh

	if db.x then
		Visor2:Debug("3: "..db.x)
	else
		Visor2:Debug("3: nil")
	end

	if not p.c and p.s and not p.x or p.s and not p.y then
		db.x = nil db.y = nil
		Visor2:Debug("3.5: x y nil")
	elseif p.c or p.s and p.x or p.s and p.y or p.s then
		db.x = db.x / es or ox
		db.y = db.y / es or oy
	end

	if db.x then
		Visor2:Debug("4: "..db.x)
	else
		Visor2:Debug("4: nil")
	end

	Visor2.db.profile.frames[p.f] = db

	if p.s or p.wh or p.ht then
		Visor2:ScaleFrames(p.f, db)
	end

	if p.pr and p.pr ~= "UIParent" and db.x and db.y then
		Visor2:MoveFrames(f, db)
	end

	if p.s or p.x or p.y then
		Visor2:MoveFrames(p.f, db, os, ox, oy)
	end

	if p.sl then return end

	p.s  = Visor2.Chk(p.s, TRUE)
	p.ht = Visor2.Chk(p.ht, TRUE)
	p.wh = Visor2.Chk(p.wh, TRUE)
	p.x  = Visor2.Chk(p.x, TRUE)
	p.y  = Visor2.Chk(p.y, TRUE)
	p.p1 = Visor2.Chk(p.p1)
	p.pr = Visor2.Chk(p.pr)
	p.p2 = Visor2.Chk(p.p2)
	Visor2:Print(VisorLocals.Chat_DepthSet, p.f, p.s, p.ht, p.wh, p.x, p.y, tostring(p.c), p.pr, p.p1, p.p2)
end

--<< ================================================= >>--
--    The Scale Function                                 --
--<< ================================================= >>--

function Visor2:ScaleFrames(f, db)
	Visor2:Debug("Called ScaleFrames")

	local v_getglobal = getglobal
	if f and db.s and not Visor2:StopExternalScale(f) then
		if db.x then Visor2:Debug("5: "..db.x) else Visor2:Debug("5: nil") end
		Visor2:Debug(format(VisorLocals.Debug_Scaling, f))
		if v_getglobal(f).VisorSetScale then
			v_getglobal(f):VisorSetScale(db.s)
		else
			db.s = nil
			Visor2:Print(VisorLocals.Misc_NoScale) return
		end
	end
	if f and db.ht and not Visor2:StopExternalScale(f) then
		Visor2:Debug(format(VisorLocals.Debug_Height, f))
		v_getglobal(f):VisorSetHeight(db.ht)
	end
	if f and db.wh and not Visor2:StopExternalScale(f) then
		Visor2:Debug(format(VisorLocals.Debug_Width, f))
		v_getglobal(f):VisorSetWidth(db.wh)
	end
	if f then return end

	Visor2:Debug("Setup call, scaling all frames in database")
	for k, v in pairs(Visor2.db.profile.frames) do --self.Get(nil, "framesDB") do

		Visor2:Debug("Frame Name = " .. k)

		if v_getglobal(k) and v.s and not Visor2:StopExternalScale(k) then
			Visor2:Debug(format(VisorLocals.Debug_Scaling, k))
			if v_getglobal(k).VisorSetScale then
				v_getglobal(k):VisorSetScale(v.s)
			else
				v.s = nil
				Visor2:Print(VisorLocals.Misc_NoScale) return
			end
		end
		if v_getglobal(k) and v.ht and not Visor2:StopExternalScale(k) then
			Visor2:Debug(format(VisorLocals.Debug_Height, k))
			v_getglobal(k):VisorSetHeight(v.ht)
		end
		if v_getglobal(k) and v.wh and not Visor2:StopExternalScale(k) then
			Visor2:Debug(format(VisorLocals.Debug_Width, k))
			v_getglobal(k):VisorSetWidth(v.wh)
		end
	end
end

--<< ================================================= >>--
--    The Move Function                                  --
--<< ================================================= >>--

function Visor2:MoveFrames(f, db, os, ox, oy)
	Visor2:Debug("MoveFrames: f=%s, os=%s, ox=%s, oy=%s", f, os, ox, oy)

	local v_getglobal = getglobal
	local s

	if f and not Visor2:StopExternalMove(f) then
		if db.x then
			Visor2:Debug("6: db.x "..db.x)
		else
			Visor2:Debug("6: db.x nil")
		end

		if ox then
			Visor2:Debug("6: ox "..ox)
		else
			Visor2:Debug("6: ox nil")
		end

		Visor2:Debug(format(VisorLocals.Debug_Moving, f))
		v_getglobal(f):VisorClearAllPoints()
		if v_getglobal(f).GetScale then
			s = v_getglobal(f):GetScale()
		else
			s = v_getglobal("UIParent"):GetEffectiveScale()
		end
	
		if s then Visor2:Debug("s: "..s) end
		if db.s then Visor2:Debug("db.s: "..db.s) end
		if os then Visor2:Debug("os: "..os) end

		db.x = db.x or (ox / ((db.s or s) / os))
		db.y = db.y or (oy / ((db.s or s) / os))

		if db.x then
			Visor2:Debug("7: "..db.x)
		else
			Visor2:Debug("6: nil")
		end

		v_getglobal(f):VisorSetPoint(
			(db.p1 or "CENTER"),
			(db.pr or (v_getglobal(f):GetParent():GetName()) or "UIParent"),
			(db.p2 or "BOTTOMLEFT"), db.x, db.y)
		return
	end

	Visor2:Debug("Setup call, re-positioning all frames in database")
	for k, v in pairs(Visor2.db.profile.frames) do --self.Get(nil, "framesDB") do
		local g = TRUE
		Visor2:Debug("frame = " .. k)
		if v.pr then Visor2:Debug("--relative parent = " .. v.pr) else Visor2:Debug("--relative parent = nil") end

		if v_getglobal(v.pr) then
			Visor2:Debug("--found: " .. v.pr)
			g = v.pr
		else
			Visor2:Debug("--not found: relative parent")
			g = nil
		end
		if v_getglobal(k) then
			Visor2:Debug("--found: " .. k)
			g = k
		else
			Visor2:Debug("--not found: frame record")
			g = nil
		end

		if g then Visor2:Debug("--frame and relative parent found!") else Visor2:Debug("--could not find frame or its relative parent, aborting") end
		if v.x then Visor2:Debug("--x = " .. v.x) else Visor2:Debug("--x = nil") end
		if v.y then Visor2:Debug("--y = " .. v.y) else Visor2:Debug("--y = nil") end

		if g and v.x or g and v.y then
			if not Visor2:StopExternalMove(k) then
				if v_getglobal(k).GetCenter then
					ox, oy = v_getglobal(k):GetCenter()
				end
				Visor2:Debug(format(VisorLocals.Debug_Moving, k))
				v_getglobal(k):VisorClearAllPoints()
				if v.p2 then Visor2:Debug("--anchor-to: "..v.p2) else Visor2:Debug("--anchor-to point not defined, aborting") end
				v_getglobal(k):VisorSetPoint(
				 (v.p1 or "CENTER"),
				 (v.pr or (v_getglobal(k):GetParent():GetName()) or "UIParent"),
				 (v.p2 or "BOTTOMLEFT"),
				 (v.x or ox),
				 (v.y or oy)
				)
			end
		end
	end
end

--<< ================================================= >>--
--    The Naughtyness Eradicators                        --
--<< ================================================= >>--

function Visor2:StopExternalScale(f)
	f = getglobal(f)
	if not f then return TRUE end
	if not f.VisorSetScale then
		f.VisorSetScale  = f.SetScale
		f.SetScale       = function() end
	end
	if not f.VisorSetHeight then
		f.VisorSetHeight = f.SetHeight
		f.SetHeight      = function() end
	end
	if not f.VisorSetWidth then
		f.VisorSetWidth  = f.SetWidth
		f.SetWidth       = function() end
	end
end

function Visor2:StopExternalMove(f)
	f = getglobal(f)
	if not f then return TRUE end
	if not f.VisorClearAllPoints then
		f.VisorClearAllPoints = f.ClearAllPoints
		f.ClearAllPoints      = function() end
	end
	if not f.VisorSetPoint then
		f.VisorSetPoint       = f.SetPoint
		f.SetPoint            = function() end
	end
end

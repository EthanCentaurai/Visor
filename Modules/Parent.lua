--<< ================================================= >>--
--    Initialize the Object                              --
--<< ================================================= >>--

Visor2Parent = Visor2:NewModule("Parent")

--<< ================================================= >>--
--    Call the Update Event                              --
--<< ================================================= >>--

function Visor2Parent:OnEnable()
	Visor2:ParentFrames()
	self:RegisterEvent("VISOR_UPDATE")
end

--<< ================================================= >>--
--    The Chat Handler                                   --
--<< ================================================= >>--

function Visor2Parent:VISOR_UPDATE(p, db, f)
	if p.det then
		--[[
		for k, v in pairs(Visor2.db.profile.frames) do
			if p.det == strlower(k) then
				tinsert(Visor2.detailDB,
				 {text = VisorLocals.Report_Parent,
				  val  = v.p or VisorLocals.Report_Standard})
			end
		end
		]]
		return
	end
	if p.ref then
		self:OnEnable()
		return
	end
	if not p.p then return end
	p.f           = p.f or f
	db.p          = p.p or db.p
	Visor2.db.profile.frames[p.f] = db
	if p.p then Visor2:ParentFrames(p.f, db) end
	if p.sl then return end
	p.p  = Visor2.Chk(p.p)
	Visor2:Print(VisorLocals.Chat_ParentSet, p.f, p.p)
end

--<< ================================================= >>--
-- Section IV: The Parent Function.                      --
--<< ================================================= >>--

function Visor2:ParentFrames(f, db)
	local v_getglobal = getglobal
	if f and db.p then
		v_getglobal(f):SetParent(db.p)
		return
	end
	for k, v in pairs(Visor2.db.profile.frames) do
		if v_getglobal(k) and v.p then
			Visor2:Debug(format(VisorLocals.Debug_Parent, k))
			v_getglobal(k):SetParent(v_getglobal(v.p))
		end
	end
end


--<< ================================================= >>--
-- Section I: The String Handlers.
--<< ================================================= >>--


function AuraCheck(t, buff, unit)
	local t_getglobal = getglobal
	t = t.tooltip
	local tleft1 = t.."TextLeft1"
	unit = unit or "player"
	local n, found = 1
	while UnitBuff(unit, n) do
		t_getglobal(t):SetUnitBuff(unit, n)
		if t_getglobal(tleft1):GetText() == buff then
			found = 1
			break
		end
		n = n + 1
	end
	n = 1
	while UnitDebuff(unit, n) do
		t_getglobal(t):SetUnitDebuff(unit, n)
		if t_getglobal(tleft1):GetText() == buff then
			found = 1
			break
		end
		n = n + 1
	end
	return found
end

function AuraScan(t, u, db)
   t = t.tooltip 
   local tdb = {}
   if type(u) ~= "string" then
      db = u u = "player"
   end
   for k, v in db do local n, b = 1
      local fnd = function(f, txt, n)
         getglobal(t):ClearLines()
         getglobal(t)[f](getglobal(t), u, n)
         b = getglobal(t..txt):GetText()
         if strfind(b or "", v) then
            tinsert(tdb, k, n)
         end
      end
      while UnitBuff(u, n) do
         if fnd("SetUnitBuff", "TextLeft1", n) then
         break end
         n = n + 1
      end
      n = 1
      while UnitDebuff(u, n) do
         if fnd("SetUnitDebuff", "TextLeft1", n) then
         break end
         n = n + 1
      end
      fnd("SetInventoryItem", "TextLeft6", 16)
   end
   return unpack(tdb)
end

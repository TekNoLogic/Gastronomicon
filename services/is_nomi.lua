
local myname, ns = ...


local NOMI_ID = 101846


function ns.IsNomi()
	local guid = UnitGUID("npc")
	if not guid then return end

	local _, _, _, _, _, npc_id = string.split("-", guid)
	return tonumber(npc_id) == NOMI_ID
end

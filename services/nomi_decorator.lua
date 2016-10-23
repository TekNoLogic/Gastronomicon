
local myname, ns = ...


local NOMI_ID = 101846


function ns.GOSSIP_SHOW()
	local guid = UnitGUID("npc")
	if not guid then return end

	local _, _, _, _, _, npc_id = string.split("-", guid)
	if tonumber(npc_id) ~= NOMI_ID then return end

	local i = 0
	for _,item_id in ipairs(ns.ingredient_order) do
		if (GetItemCount(item_id, true) or 0) >= 5 then
			i = i + 1
			ns.UpdateButton(i, item_id)
		end
	end
end


ns.RegisterEvent("GOSSIP_SHOW")

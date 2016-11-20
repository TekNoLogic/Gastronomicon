
local myname, ns = ...


function ns.GOSSIP_SHOW()
	if not ns.IsNomi() then return end

	local i = 0
	for _,item_id in ipairs(ns.ingredient_order) do
		if (GetItemCount(item_id, true) or 0) >= 5 then
			i = i + 1
			ns.UpdateButton(i, item_id)
		end
	end
end


ns.RegisterEvent("GOSSIP_SHOW")

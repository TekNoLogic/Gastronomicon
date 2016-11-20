
local myname, ns = ...


local INGREDIENT_ORDER = {
	124117, -- Lean Shank
	124121, -- Wildfowl Egg
	124119, -- Big Gamy Ribs
	124118, -- Fatty Bearsteak
	124120, -- Leyblood
	124107, -- Cursed Queenfish
	124108, -- Mossgill Perch
	124109, -- Highmountain Salmon
	124110, -- Stormray
	124111, -- Runescale Koi
	124112, -- Black Barracuda
	133680, -- Slabs of Bacon
	133607, -- Silver Mackerel
}


local function OnNomiOpened()
	local i = 0
	for _,item_id in ipairs(INGREDIENT_ORDER) do
		if (GetItemCount(item_id, true) or 0) >= 5 then
			i = i + 1
			ns.UpdateButton(i, item_id)
		end
	end
end


ns.RegisterEvent("_NOMI_OPENED", OnNomiOpened)


local myname, ns = ...


-- List of recipes you must (probably) already know in order to discover a
-- recipe from Nomi. While technically you need to know the previous rank of a
-- spell to receive the next one, we'll use the base rank as the requirement for
-- all ranks because it's more intuitive. I only want to grey-out recipes that
-- we can't learn because we don't know the base rank.

-- Operating under the following assumptions about how recipes are discovered:
-- 1. You must know the base rank of a recipe to receive higher ranks
-- 2. You must already know all recipes which are reagents for the recipe
--    ** As of 7.1, this does not apply to the "tier 3" feasts

ns.requisites = {
	[201506] = 201501, -- Azshari Salad: Suramar Surf and Turf
	[201508] = 201503, -- Seed-Battered Fish Plate: Kio-Scented Stormray
	[201507] = 201502, -- Nightborne Delicacy Platter: Barracuda Mrglgagh
	[201505] = 201500, -- The Hungry Magister: Leybeque Ribs
	[201511] = 201504, -- Fishbrul Special: Drogbar-Style Salmon

	[201542] = 201515, -- Hearty Feast
	[201562] = 201515, -- Hearty Feast
	[201543] = 201516, -- Lavish Suramar Feast
	[201563] = 201516, -- Lavish Suramar Feast

	[201538] = 201511, -- Fishbrul Special
	[201558] = 201511, -- Fishbrul Special
	[201534] = 201505, -- The Hungry Magister
	[201554] = 201505, -- The Hungry Magister
	[201535] = 201506, -- Azshari Salad
	[201555] = 201506, -- Azshari Salad
	[201536] = 201507, -- Nightborne Delicacy Platter
	[201556] = 201507, -- Nightborne Delicacy Platter
	[201537] = 201508, -- Seed-Battered Fish Plate
	[201557] = 201508, -- Seed-Battered Fish Plate

	[201531] = 201502, -- Barracuda Mrglgagh
	[201551] = 201502, -- Barracuda Mrglgagh
	[201533] = 201504, -- Drogbar-Style Salmon
	[201553] = 201504, -- Drogbar-Style Salmon
	[201539] = 201512, -- Dried Mackerel Strips
	[201559] = 201512, -- Dried Mackerel Strips
	[201541] = 201514, -- Fighter Chow
	[201561] = 201514, -- Fighter Chow
	[201530] = 201501, -- Suramar Surf and Turf
	[201550] = 201501, -- Suramar Surf and Turf
	[201524] = 201413, -- Salt and Pepper Shank
	[201544] = 201413, -- Salt and Pepper Shank
	[201526] = 201497, -- Pickled Stormray
	[201546] = 201497, -- Pickled Stormray
	[201532] = 201503, -- Koi-Scented Stormray
	[201552] = 201503, -- Koi-Scented Stormray
	[201528] = 201499, -- Spiced Rib Roast
	[201548] = 201499, -- Spiced Rib Roast
	[201525] = 201496, -- Deep-Fried Mossgill
	[201545] = 201496, -- Deep-Fried Mossgill
	[201540] = 201513, -- Bear Tartare
	[201560] = 201513, -- Bear Tartare
	[201529] = 201500, -- Leybeque Ribs
	[201549] = 201500, -- Leybeque Ribs
	[201527] = 201498, -- Faronaar Fizz
	[201547] = 201498, -- Faronaar Fizz
}

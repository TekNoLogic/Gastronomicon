
local myname, ns = ...


local function OnShipmentCrafterInfo()
  local _, _, _, _, _, id = C_Garrison.GetShipmentReagentInfo(1)
  if not ns.IsNomi() or not id then return end

  ns.UnregisterEvent("SHIPMENT_CRAFTER_INFO")

  if GetItemCount(id) ~= 1 then return end

  C_Garrison.RequestShipmentCreation(1)
  GarrisonCapacitiveDisplayFrameCloseButton:Click()
end


local function OnShipmentCrafterOpened()
  if not ns.IsNomi() then return end
  ns.RegisterEvent("SHIPMENT_CRAFTER_INFO")
end


ns.RegisterEvent("SHIPMENT_CRAFTER_OPENED", OnShipmentCrafterOpened)

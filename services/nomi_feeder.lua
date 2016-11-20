
local myname, ns = ...


local function OnShipmentCrafterInfo(self)
  local _, _, _, _, _, item_id = C_Garrison.GetShipmentReagentInfo(1)
  if not ns.IsNomi() or not item_id then return end

  -- This event fires a lot, once we have our data we don't need to listen
  ns.UnregisterEvent(self, "SHIPMENT_CRAFTER_INFO")

  if GetItemCount(item_id) ~= 1 then return end

  C_Garrison.RequestShipmentCreation(1)
  GarrisonCapacitiveDisplayFrameCloseButton:Click()
end


local function OnShipmentCrafterOpened(self)
  if not ns.IsNomi() then return end
  ns.RegisterEvent(self, "SHIPMENT_CRAFTER_INFO", OnShipmentCrafterInfo)
end


ns.RegisterEvent("SHIPMENT_CRAFTER_OPENED", OnShipmentCrafterOpened)

--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();

ITEM.name = "Level 5 Card";
ITEM.uniqueID = "kiocard_clearance_5"; -- Do not change.
ITEM.model = "models/gibs/shield_scanner_gib1.mdl";
ITEM.weight = 0.8;
ITEM.access = "X";
ITEM.category = "Clearance";
ITEM.description = "A small keycard.";

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) 
end;

ITEM:Register();
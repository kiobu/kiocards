function kdc:PlayerCanUseDoor(player, entity)

    local cwEntity = Clockwork.entity;

	if (cwEntity:GetOwner(door) and !cwPly:HasDoorAccess(player, door)) then
		return false;
	end;
	
	if (cwEntity:IsDoorFalse(door)) then
		return false;
    end;
    
    local clearance = cwEntity:GetNetworkedString("Clearance");

    if (!clearance or clearance == '') then
        return true;
    else
        pass = false;
            -- for (i = 0, i>5, i++) do
            --if (player:HasItemByID("kiocard_clearance_"..i) && i >= clearance) then
        if (Clockwork.player:HasFlags(player, "X")) then
            pass = true;
        else
            pass = false;
        end;
        return pass;
    end;
end;
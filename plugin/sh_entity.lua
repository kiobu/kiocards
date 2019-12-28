local PLUGIN = PLUGIN;

function kdc:SetDoorClearance(entity, clearance)
    if (Clockwork.entity:IsDoor(entity)) then
        entity:SetNetworkedString("Clearance", clearance);
    end;
end;
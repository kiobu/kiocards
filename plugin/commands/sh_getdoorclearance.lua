local COMMAND = Clockwork.command:New("GetDoorClearance"); 
COMMAND.tip = "Gets a door's clearance level."; 
COMMAND.flags = CMD_DEFAULT;

-- Called when the command has been run. 

function COMMAND:OnRun(player, arguments) 

    local door = player:GetEyeTraceNoCursor().Entity; 
    local trace = player:GetEyeTraceNoCursor(); 
    local target = trace.Entity;

    if ( IsValid(door) and Clockwork.entity:IsDoor(door) ) then
        if (target:GetPos():Distance( player:GetShootPos() ) <= 64) then
            if (!door:GetNetworkedString("Clearance") or (door:GetNetworkedString("Clearance") == '')) then
                Clockwork.player:Notify(player, "There is no clearance level for this door.");
            else 
            Clockwork.player:Notify(player, "Clearance Level: " .. door:GetNetworkedString("Clearance"));
            end;
        else
            Clockwork.player:Notify(player, "Door is too far away!");
        end;
    else
        Clockwork.player:Notify(player, "This is not a valid door!");
    end;
end;

COMMAND:Register();
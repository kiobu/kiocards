local COMMAND = Clockwork.command:New("DoorSetClearance"); 
COMMAND.tip = "Sets a door's clearance level."; 
COMMAND.flags = CMD_DEFAULT;

-- Called when the command has been run. 

function COMMAND:OnRun(player, arguments) 

    local door = player:GetEyeTraceNoCursor().Entity; 
    local trace = player:GetEyeTraceNoCursor(); 
    local target = trace.Entity;

    if ( IsValid(door) and Clockwork.entity:IsDoor(door) ) then
        if (target:GetPos():Distance( player:GetShootPos() ) <= 64) then
            if (!arguments[1]) then
                Clockwork.player:Notify(player, "No clearance level was given.");
            else 
            kdc:SetDoorClearance(door, arguments[1]);
            Clockwork.player:Notify(player, "Clearance level set!");
            timer.Simple(2, function() kdc:SaveDoorClearances() end);
            end;
        else
            Clockwork.player:Notify(player, "Door is too far away!");
        end;
    else
        Clockwork.player:Notify(player, "This is not a valid door!");
    end;
end;

COMMAND:Register();
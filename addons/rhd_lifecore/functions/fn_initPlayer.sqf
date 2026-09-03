if (!hasInterface) exitWith {};

waitUntil {
    uiSleep 0.25;
    !(isNil {missionNamespace getVariable "RHD_LifeCore_Enabled"}) || {time > 30}
};
if !(missionNamespace getVariable ["RHD_LifeCore_Enabled", false]) exitWith {};

private _config = missionNamespace getVariable ["RHD_LifeCore_Config", createHashMap];
private _uid = getPlayerUID player;
if (_uid isEqualTo "") exitWith {};

player setVariable ["RHD_RP_UID", _uid, true];
player setVariable ["RHD_RP_Name", profileName, true];
player setVariable ["RHD_RP_IdentityEnabled", _config getOrDefault ["identityEnabled", true], true];
player setVariable ["RHD_RP_EconomyEnabled", _config getOrDefault ["economyEnabled", true], true];

if (isNil {player getVariable "RHD_RP_MenuAction"}) then {
    private _actionId = player addAction [
        "<t color='#C9A227'>RHD LifeCore</t> - Character Profile",
        {[] call RHD_fnc_openProfile},
        nil, 1.5, true, true, "", "true", 5, false, ""
    ];
    player setVariable ["RHD_RP_MenuAction", _actionId];
};

[player] remoteExecCall ["RHD_fnc_serverLoadProfile", 2];

[] spawn {
    uiSleep 2;
    [] call RHD_fnc_setupInteractions;
};

if (isNil {player getVariable "RHD_RP_RespawnEH"}) then {
    private _eh = player addEventHandler ["Respawn", {
        [] spawn RHD_fnc_initPlayer;
    }];
    player setVariable ["RHD_RP_RespawnEH", _eh];
};

if (_config getOrDefault ["debugLogging", false]) then {
    diag_log format ["[RHD-LifeCore] Player initialization requested: %1 (%2)", profileName, _uid];
};
true
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
player setVariable ["RHD_RP_Cash", _config getOrDefault ["startingCash", 500], true];
player setVariable ["RHD_RP_Bank", _config getOrDefault ["startingBank", 1000], true];
player setVariable ["RHD_RP_Initialized", true, true];

if (_config getOrDefault ["identity", true]) then {
    player setVariable ["RHD_RP_IdentityEnabled", true, true];
};

if (_config getOrDefault ["economy", true]) then {
    player setVariable ["RHD_RP_EconomyEnabled", true, true];
};

if (isNil {player getVariable "RHD_RP_MenuAction"}) then {
    private _actionId = player addAction [
        "<t color='#C9A227'>RHD LifeCore</t> - RP Menu",
        {[] call RHD_fnc_openMenu},
        nil,
        1.5,
        true,
        true,
        "",
        "true",
        5,
        false,
        ""
    ];
    player setVariable ["RHD_RP_MenuAction", _actionId];
};

if (isNil {player getVariable "RHD_RP_RespawnEH"}) then {
    private _eh = player addEventHandler ["Respawn", {
        [] spawn RHD_fnc_initPlayer;
    }];
    player setVariable ["RHD_RP_RespawnEH", _eh];
};

if (_config getOrDefault ["debug", false]) then {
    diag_log format ["[RHD-LifeCore] Player initialized: %1 (%2)", profileName, _uid];
};

true
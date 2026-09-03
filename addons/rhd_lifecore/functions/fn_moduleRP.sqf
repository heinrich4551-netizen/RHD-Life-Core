params ["_logic", "_units", "_activated"];

if (!_activated) exitWith {};

private _config = createHashMapFromArray [
    ["identity", _logic getVariable ["RHD_EnableIdentity", true]],
    ["economy", _logic getVariable ["RHD_EnableEconomy", true]],
    ["startingCash", _logic getVariable ["RHD_StartingCash", 500]],
    ["startingBank", _logic getVariable ["RHD_StartingBank", 1000]],
    ["debug", _logic getVariable ["RHD_Debug", false]]
];

missionNamespace setVariable ["RHD_LifeCore_Enabled", true, true];
missionNamespace setVariable ["RHD_LifeCore_Config", _config, true];

if (_config get "debug") then {
    diag_log format ["[RHD-LifeCore] RP module initialized. Config: %1", _config];
};

true
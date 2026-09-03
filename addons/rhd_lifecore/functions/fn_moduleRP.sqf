params ["_logic", "_units", "_activated"];

if (!_activated) exitWith {false};

private _config = [_logic] call RHD_fnc_applyModuleConfig;

missionNamespace setVariable ["RHD_LifeCore_Enabled", true, true];
missionNamespace setVariable ["RHD_LifeCore_Module", _logic, true];
missionNamespace setVariable ["RHD_LifeCore_Config", _config, true];

if (isServer) then {
    [] call RHD_fnc_serverInit;
};

if (missionNamespace getVariable ["RHD_LifeCore_Config", createHashMap] getOrDefault ["debug", false]) then {
    diag_log format ["[RHD-LifeCore] 3DEN RP module initialized: %1", _config];
};

true
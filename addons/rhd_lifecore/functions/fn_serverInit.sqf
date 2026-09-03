if (!isServer) exitWith {false};

if (missionNamespace getVariable ["RHD_LifeCore_ServerReady", false]) exitWith {true};

missionNamespace setVariable ["RHD_LifeCore_ServerProfiles", createHashMap];
missionNamespace setVariable ["RHD_LifeCore_ServerReady", true];

private _cfg = missionNamespace getVariable ["RHD_LifeCore_Config", createHashMap];
if (_cfg getOrDefault ["debugLogging", false]) then {
    diag_log "[RHD-LifeCore] Server service layer ready.";
};

true
if (!isServer) exitWith {false};

waitUntil {time > 0 && {!isNil "RHD_LifeCore_WorldConfig"}};
private _cfg = missionNamespace getVariable ["RHD_LifeCore_WorldConfig",createHashMap];
if !(_cfg getOrDefault ["enabled",true]) exitWith {false};

private _started = missionNamespace getVariable ["RHD_LifeCore_WorldStarted",false];
[] call RHD_fnc_generateLocations;
if (_cfg getOrDefault ["generateSpawnLocations",true]) then {[] call RHD_fnc_generateSpawnLocations;};

if (_started) exitWith {true};
missionNamespace setVariable ["RHD_LifeCore_WorldStarted",true,true];
[] spawn RHD_fnc_worldController;
true

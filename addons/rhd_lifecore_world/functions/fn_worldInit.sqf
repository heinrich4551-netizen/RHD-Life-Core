if (!isServer) exitWith {false};

waitUntil {time > 0 && {!isNil "RHD_LifeCore_WorldConfig"}};
private _cfg = missionNamespace getVariable ["RHD_LifeCore_WorldConfig",createHashMap];
if !(_cfg getOrDefault ["enabled",true]) exitWith {false};
if (missionNamespace getVariable ["RHD_LifeCore_WorldStarted",false]) exitWith {true};
missionNamespace setVariable ["RHD_LifeCore_WorldStarted",true,true];

[] call RHD_fnc_generateLocations;
if (_cfg getOrDefault ["generateSpawnLocations",true]) then { [] call RHD_fnc_generateSpawnLocations; };

[] spawn RHD_fnc_worldController;
true

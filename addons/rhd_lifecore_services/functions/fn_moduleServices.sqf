params ["_logic", "_units", "_activated"];
if (!_activated || {isNull _logic}) exitWith {false};

[_logic] call RHD_fnc_serviceConfig;
missionNamespace setVariable ["RHD_LifeCore_ServicesModule", _logic, true];

if (isServer) then {
    [] call RHD_fnc_antistasiDetect;
    [] call RHD_fnc_antistasiAdapter;
    [] call RHD_fnc_extdbInit;
};

true

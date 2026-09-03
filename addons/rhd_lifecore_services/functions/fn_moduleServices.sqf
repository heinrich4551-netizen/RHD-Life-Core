params ['_logic','_units','_activated'];
if (!_activated) exitWith {false};
[_logic] call RHD_fnc_serviceConfig;
if (isServer) then {[] call RHD_fnc_extdbInit;};
true
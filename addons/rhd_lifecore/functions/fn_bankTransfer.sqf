if (!isServer) exitWith {false};
params [["_targetUID", "", [""]], ["_amount", 0, [0]]];
[_targetUID, _amount] call RHD_fnc_serverEconomy

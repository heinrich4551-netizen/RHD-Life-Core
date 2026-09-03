params [
    ["_action", "", [""]],
    ["_amount", 0, [0]],
    ["_targetUID", "", [""]]
];
if (!hasInterface || {getPlayerUID player isEqualTo ""}) exitWith {false};
[_action, _amount, _targetUID] remoteExecCall ["RHD_fnc_serverEconomy", 2];
true
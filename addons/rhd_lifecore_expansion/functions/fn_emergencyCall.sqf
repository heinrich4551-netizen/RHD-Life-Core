params [["_type","police",[""]], ["_message","Emergency call",[""]]];
if (!hasInterface) exitWith {false};
[player,_type,_message,getPosATL player] remoteExecCall ["RHD_fnc_dispatchCreate",2];
true

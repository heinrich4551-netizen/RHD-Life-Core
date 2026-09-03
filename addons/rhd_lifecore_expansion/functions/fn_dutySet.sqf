params [["_role","civilian",[""]], ["_onDuty",true,[true]]];
if (!isServer) exitWith {[player,_role,_onDuty] remoteExecCall ["RHD_fnc_dutySet",2]; true};
if (!isPlayer player) exitWith {false};
if (!([player,_role] call RHD_fnc_roleCan)) exitWith {false};
player setVariable ["RHD_RP_DutyRole",if (_onDuty) then {_role} else {"civilian"},true];
true

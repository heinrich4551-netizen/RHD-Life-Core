params [["_unit",objNull,[objNull]], ["_role","civilian",[""]], ["_onDuty",true,[true]]];
if (!isServer) exitWith {[player,_role,_onDuty] remoteExecCall ["RHD_fnc_dutySet",2]; true};
if (isNull _unit || {!isPlayer _unit}) exitWith {false};
if (!([_unit,_role] call RHD_fnc_roleCan)) exitWith {false};
_unit setVariable ["RHD_RP_DutyRole",if (_onDuty) then {_role} else {"civilian"},true];
true

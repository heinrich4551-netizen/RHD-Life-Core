params [["_uid","",[""]], ["_reason","",[""]], ["_issuer",objNull,[objNull]]];
if (!isServer) exitWith {[_uid,_reason,player] remoteExecCall ["RHD_fnc_warrantAdd",2]; true};
if (_uid isEqualTo "" || {_reason isEqualTo ""}) exitWith {false};
private _list = missionNamespace getVariable ["RHD_RP_Warrants",[]];
if ((_list findIf {(_x param [0,""]) isEqualTo _uid}) >= 0) exitWith {false};
_list pushBack [_uid,_reason,if (isNull _issuer) then {"SYSTEM"} else {name _issuer},diag_tickTime];
missionNamespace setVariable ["RHD_RP_Warrants",_list,true];
true

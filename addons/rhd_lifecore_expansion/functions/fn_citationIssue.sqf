params [["_target",objNull,[objNull]], ["_amount",0,[0]], ["_reason","",[""]]];
if (!isServer) exitWith {[player,_target,_amount,_reason] remoteExecCall ["RHD_fnc_citationIssue",2]; true};
if (isNull _target || {!isPlayer _target} || {_amount < 0} || {_reason isEqualTo ""}) exitWith {false};
private _citations = _target getVariable ["RHD_RP_Citations",[]];
_citations pushBack [_amount,_reason,diag_tickTime,getPlayerUID player];
_target setVariable ["RHD_RP_Citations",_citations,true];
true

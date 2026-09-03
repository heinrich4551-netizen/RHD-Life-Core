params [["_unit",objNull,[objNull]], ["_type","general",[""]], ["_message","",[""]], ["_pos",[],[[]]]];
if (!isServer) exitWith {[player,_type,_message,getPosATL player] remoteExecCall ["RHD_fnc_dispatchCreate",2]; true};
if (isNull _unit || {!isPlayer _unit} || {_message isEqualTo ""}) exitWith {false};
private _calls = missionNamespace getVariable ["RHD_RP_Dispatch",[]];
_calls pushBack [diag_tickTime,_type,_message,_pos,getPlayerUID _unit,name _unit];
if ((count _calls) > 100) then {_calls deleteAt 0;};
missionNamespace setVariable ["RHD_RP_Dispatch",_calls,true];
true

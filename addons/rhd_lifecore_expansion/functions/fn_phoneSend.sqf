params [["_target",objNull,[objNull]], ["_message","",[""]]];
if (isNull _target || {!isPlayer _target} || {_message isEqualTo ""}) exitWith {false};
if (!isServer) exitWith {[player,_target,_message] remoteExecCall ["RHD_fnc_phoneSend",2]; true};
private _messages = _target getVariable ["RHD_RP_PhoneMessages",[]];
_messages pushBack [getPlayerUID player,name player,_message,diag_tickTime];
if ((count _messages) > 50) then {_messages deleteAt 0;};
_target setVariable ["RHD_RP_PhoneMessages",_messages,true];
true

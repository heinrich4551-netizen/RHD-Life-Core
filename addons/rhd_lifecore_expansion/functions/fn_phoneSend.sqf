params [["_sender",objNull,[objNull]], ["_target",objNull,[objNull]], ["_message","",[""]]];
if (!isServer) exitWith {[player,_target,_message] remoteExecCall ["RHD_fnc_phoneSend",2]; true};
if (isNull _sender || {!isPlayer _sender} || {isNull _target} || {!isPlayer _target} || {_message isEqualTo ""}) exitWith {false};
private _messages = _target getVariable ["RHD_RP_PhoneMessages",[]];
_messages pushBack [getPlayerUID _sender,name _sender,_message,diag_tickTime];
if ((count _messages) > 50) then {_messages deleteAt 0;};
_target setVariable ["RHD_RP_PhoneMessages",_messages,true];
true

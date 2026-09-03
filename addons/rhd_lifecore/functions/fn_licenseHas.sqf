params [["_player", player, [objNull]], ["_licenseId", "", [""]]];
if (isNull _player) exitWith {false};
_licenseId in (_player getVariable ["RHD_RP_Licenses", []])
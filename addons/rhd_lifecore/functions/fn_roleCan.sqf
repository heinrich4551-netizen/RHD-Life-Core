params [["_requiredRole", "civilian", [""]], ["_player", player, [objNull]]];
if (isNull _player) exitWith {false};
(toLower (_player getVariable ["RHD_RP_Role", "civilian"])) isEqualTo toLower _requiredRole
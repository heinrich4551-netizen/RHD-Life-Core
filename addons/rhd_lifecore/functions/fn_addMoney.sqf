params [["_amount", 0, [0]], ["_account", "cash", [""]]];
if (!hasInterface) exitWith {false};
if !(_account in ["cash", "bank"]) exitWith {false};
private _action = if (_account isEqualTo "bank") then {"addbank"} else {"addcash"};
[_action, _amount] call RHD_fnc_economyRequest
params [["_account", "cash"]];

if !(_account in ["cash", "bank"]) exitWith {0};
private _variable = if (_account isEqualTo "bank") then {"RHD_RP_Bank"} else {"RHD_RP_Cash"};
player getVariable [_variable, 0]
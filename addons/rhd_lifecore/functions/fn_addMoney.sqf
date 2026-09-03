params ["_amount", ["_account", "cash"]];

if (!isNumber _amount) exitWith {false};
if !(_account in ["cash", "bank"]) exitWith {false};

private _variable = if (_account isEqualTo "bank") then {"RHD_RP_Bank"} else {"RHD_RP_Cash"};
private _current = player getVariable [_variable, 0];
private _new = _current + _amount;

if (_new < 0) exitWith {false};
player setVariable [_variable, _new, true];

true
params ["_firstName", "_lastName"];

if (!hasInterface || {isNull player}) exitWith {false};
if !(_firstName isEqualType "") exitWith {false};
if !(_lastName isEqualType "") exitWith {false};

private _fullName = [_firstName, _lastName] joinString " ";
player setVariable ["RHD_RP_FirstName", _firstName, true];
player setVariable ["RHD_RP_LastName", _lastName, true];
player setVariable ["RHD_RP_Name", _fullName, true];

true
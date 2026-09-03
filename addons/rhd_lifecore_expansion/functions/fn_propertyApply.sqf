params [["_unit",objNull,[objNull]], ["_props",[],[[]]]];
if (!hasInterface || {_unit != player}) exitWith {false};
player setVariable ["RHD_RP_Properties",_props,true];
true

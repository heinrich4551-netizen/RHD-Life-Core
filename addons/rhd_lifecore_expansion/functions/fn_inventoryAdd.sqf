params [["_id","",[""]], ["_delta",0,[0]]];
if (_id isEqualTo "" || {_delta isEqualTo 0}) exitWith {false};
private _inv = player getVariable ["RHD_RP_Inventory", []];
private _idx = _inv findIf {(_x param [0,""]) isEqualTo _id};
if (_idx < 0) then {_inv pushBack [_id,0]; _idx = (count _inv) - 1;};
private _entry = +(_inv select _idx);
private _count = (_entry param [1,0]) + _delta;
if (_count < 0) exitWith {false};
if (_count isEqualTo 0) then {_inv deleteAt _idx;} else {_entry set [1,_count]; _inv set [_idx,_entry];};
player setVariable ["RHD_RP_Inventory",_inv,true];
true

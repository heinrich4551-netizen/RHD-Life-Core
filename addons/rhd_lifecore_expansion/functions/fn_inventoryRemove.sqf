params [["_id","",[""]], ["_amount",0,[0]]];
if (_amount <= 0) exitWith {false};
private _inv = player getVariable ["RHD_RP_Inventory", []];
private _idx = _inv findIf {(_x param [0,""]) isEqualTo _id};
if (_idx < 0) exitWith {false};
private _have = ((_inv select _idx) param [1,0]);
if (_have < _amount) exitWith {false};
[_id,-_amount] call RHD_fnc_inventoryAdd;
true

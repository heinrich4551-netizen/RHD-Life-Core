params [["_item","",[""]]];
if (!hasInterface) exitWith {false};
private _cfg = missionNamespace getVariable ["RHD_LifeCore_Config", createHashMap];
private _list = _cfg getOrDefault ["farmingConfig", []];
private _def = _list select {(_x param [0,""]) isEqualTo _item};
if (_def isEqualTo []) exitWith {false};
private _row = _def param [0,[]];
private _min = _row param [1,1];
private _max = _row param [2,_min];
private _qty = floor (_min + random ((_max - _min) + 1));
if (_qty < 1) exitWith {false};
[_item,_qty] call RHD_fnc_inventoryAdd;
player setVariable ["RHD_RP_LastHarvest",diag_tickTime,true];
true

params [["_id","",[""]]];
private _inv = player getVariable ["RHD_RP_Inventory", []];
private _idx = _inv findIf {(_x param [0,""]) isEqualTo _id};
if (_idx < 0) exitWith {0};
(_inv select _idx) param [1,0]

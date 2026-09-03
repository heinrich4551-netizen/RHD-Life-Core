params [["_unit",objNull,[objNull]], ["_recipe","",[""]]];
if (!isServer) exitWith { [player,_recipe] remoteExecCall ["RHD_fnc_craftItem",2]; true };
if (isNull _unit || {!isPlayer _unit} || {_recipe isEqualTo ""}) exitWith {false};
private _recipes = missionNamespace getVariable ["RHD_LifeCore_Recipes",createHashMap];
private _recipeData = _recipes getOrDefault [_recipe,[]];
if (_recipeData isEqualTo []) exitWith {false};
private _inputs = _recipeData param [0,[]];
private _output = _recipeData param [1,[]];
private _inv = _unit getVariable ["RHD_RP_Inventory",[]];
private _get = {
    params ["_item"];
    private _i = _inv findIf {(_x param [0,""]) isEqualTo _item};
    if (_i < 0) then {0} else {(_inv select _i) param [1,0]}
};
private _ok = true;
{if ([_x param [0,"" ]] call _get < (_x param [1,0])) then {_ok=false;};} forEach _inputs;
if (!_ok) exitWith {false};
{private _id=_x param [0,""]; private _i=_inv findIf {(_x param [0,""]) isEqualTo _id}; if (_i>=0) then {private _e=+(_inv select _i); _e set [1,((_e param [1,0])-(_x param [1,0]))]; if ((_e param [1,0])<=0) then {_inv deleteAt _i;} else {_inv set [_i,_e];};};} forEach _inputs;
{private _id=_x param [0,""]; private _i=_inv findIf {(_x param [0,""]) isEqualTo _id}; if (_i<0) then {_inv pushBack [_id,_x param [1,0]];} else {private _e=+(_inv select _i); _e set [1,(_e param [1,0])+(_x param [1,0])]; _inv set [_i,_e];};} forEach _output;
_unit setVariable ["RHD_RP_Inventory",_inv,true];
true

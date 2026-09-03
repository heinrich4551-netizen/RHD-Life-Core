params [["_recipe","",[""]]];
if (!isServer) exitWith {[player,_recipe] remoteExecCall ["RHD_fnc_craftItem",2]; true};
private _recipes = missionNamespace getVariable ["RHD_LifeCore_Recipes", createHashMap];
private _recipeData = _recipes getOrDefault [_recipe,[]];
if (_recipeData isEqualTo []) exitWith {false};
private _inputs = _recipeData param [0,[]];
private _output = _recipeData param [1,[]];
private _unit = if ((param [0,objNull]) isEqualType objNull) then {param [0,objNull]} else {objNull};
if (isNull _unit || {!isPlayer _unit}) exitWith {false};
private _ok = true;
{if ([_x param [0,""],_x param [1,0]] call RHD_fnc_inventoryGet < (_x param [1,0])) then {} else {_ok=false;};} forEach _inputs;
if (!_ok) exitWith {false};
{[_x param [0,""],-(_x param [1,0])] remoteExecCall ["RHD_fnc_inventoryAdd",_unit];} forEach _inputs;
{[_x param [0,""],_x param [1,0]] remoteExecCall ["RHD_fnc_inventoryAdd",_unit];} forEach _output;
true

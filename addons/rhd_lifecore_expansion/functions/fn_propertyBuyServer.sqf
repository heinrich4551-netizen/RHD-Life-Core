params [["_unit",objNull,[objNull]], ["_propertyId","",[""]], ["_price",0,[0]], ["_name","Property",[""]]];
if (isNull _unit || {!isPlayer _unit} || {_propertyId isEqualTo ""} || {_price < 0}) exitWith {false};
private _props = _unit getVariable ["RHD_RP_Properties",[]];
if ((_props findIf {(_x param [0,""]) isEqualTo _propertyId}) >= 0) exitWith {false};
private _cash = _unit getVariable ["RHD_RP_Cash",0];
if (_cash < _price) exitWith {false};
_unit setVariable ["RHD_RP_Cash",_cash-_price,true];
_props pushBack [_propertyId,_name,getPosATL _unit,owner _unit];
_unit setVariable ["RHD_RP_Properties",_props,true];
[_unit,_props] remoteExecCall ["RHD_fnc_propertyApply",owner _unit];
true

params [["_unit", player, [objNull]], ["_classes", "", [""]]];
private _types = (_classes splitString ",") apply {trim _x};
private _near = nearestObjects [_unit, _types, 5];
if (count _near > 0) then {_near select 0} else {objNull}
params [["_index",-1,[0]]];
if (!hasInterface) exitWith {false};
if (_index >= 0) exitWith {[((_d=uiNamespace getVariable ["RHD_GarageDialog",displayNull]) displayCtrl 8891) lbData _index] remoteExecCall ["RHD_fnc_garageRetrieveServer",2];true};
createDialog "RHD_GarageDialog";
private _d=uiNamespace getVariable ["RHD_GarageDialog",displayNull]; private _l=_d displayCtrl 8891; lbClear _l;
{
  private _class=_x param [0,""]; private _plate=_x param [1,""]; private _price=_x param [2,0]; private _state=_x param [3,"garage"];
  if (_state isEqualTo "out") then {_state="Out";} else {if (_state isEqualTo "impounded") then {_state="Impounded";} else {_state="Stored";};};
  private _i=_l lbAdd format ["%1 | %2 | %3",_class,_plate,_state];
  _l lbSetData [_i,_plate];
} forEach (player getVariable ["RHD_RP_Vehicles",[]]);
true
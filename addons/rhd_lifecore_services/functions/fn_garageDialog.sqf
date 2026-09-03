params [["_index", -1, [0]]];
if (!hasInterface) exitWith {false};

private _display = uiNamespace getVariable ["RHD_GarageDialog", displayNull];
if (_index >= 0 && {!isNull _display}) exitWith {
    private _plate = (_display displayCtrl 8891) lbData _index;
    if (_plate isEqualTo "") exitWith {false};
    [_plate] remoteExecCall ["RHD_fnc_garageRetrieveServer", 2];
    true
};

if !(createDialog "RHD_GarageDialog") exitWith {false};
_display = uiNamespace getVariable ["RHD_GarageDialog", displayNull];
if (isNull _display) exitWith {false};

private _list = _display displayCtrl 8891;
lbClear _list;

private _vehicles = player getVariable ["RHD_RP_Vehicles", []];
{
    private _class = _x param [0, ""];
    private _plate = _x param [1, ""];
    private _price = _x param [2, 0];
    private _state = _x param [3, "garage"];

    private _cfg = configFile >> "CfgVehicles" >> _class;
    private _name = if (isClass _cfg) then {getText (_cfg >> "displayName")} else {_class};
    if (_name isEqualTo "") then {_name = _class};

    private _stateText = switch (_state) do {
        case "out": {"Out"};
        case "impounded": {"Impounded"};
        case "garage": {"Stored"};
        case "stored": {"Stored"};
        default {toUpper _state};
    };

    private _idx = _list lbAdd format ["%1 | %2 | %3 | $%4", _name, _plate, _stateText, _price];
    _list lbSetData [_idx, _plate];

    if (isClass _cfg) then {
        private _picture = getText (_cfg >> "picture");
        if !(_picture isEqualTo "") then {
            _list lbSetPicture [_idx, _picture];
        };
    };
} forEach _vehicles;

if ((lbSize _list) > 0) then {_list lbSetCurSel 0;};
true

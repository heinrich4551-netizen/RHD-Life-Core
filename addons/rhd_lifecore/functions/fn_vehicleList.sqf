if (!hasInterface) exitWith {[]};

private _vehicles = player getVariable ["RHD_RP_Vehicles", []];
if (count _vehicles == 0) exitWith {
    hint "RHD Vehicle Registry: No owned vehicles.";
    []
};

private _lines = [];
{
    private _class = _x param [0, ""];
    private _plate = _x param [1, ""];
    private _price = _x param [2, 0];
    private _state = _x param [3, "garage"];
    private _cfg = configFile >> "CfgVehicles" >> _class;
    private _name = if (isClass _cfg) then {getText (_cfg >> "displayName")} else {_class};
    if (_name isEqualTo "") then {_name = _class};

    private _stateText = switch (_state) do {
        case "out": {"OUT"};
        case "impounded": {"IMPOUNDED"};
        case "garage": {"STORED"};
        case "stored": {"STORED"};
        default {toUpper _state};
    };

    _lines pushBack format ["%1  |  %2  |  %3  |  $%4", _name, _plate, _stateText, _price];
} forEach _vehicles;

hint parseText format [
    "<t size='1.2' color='#C9A227'>RHD VEHICLE REGISTRY</t><br/><br/>%1",
    _lines joinString "<br/>"
];

_vehicles

params [];
if (!hasInterface) exitWith {false};

private _vehicle = vehicle player;
if (_vehicle isEqualTo player || {driver _vehicle isNotEqualTo player}) exitWith {
    hint "RHD Garage: You must be the driver of the vehicle you want to store.";
    false
};

private _plate = getPlateNumber _vehicle;
if (_plate isEqualTo "") exitWith {
    hint "RHD Garage: This vehicle does not have a registered plate.";
    false
};

[_plate] remoteExecCall ["RHD_fnc_garageStoreServer", 2];
true

if (!hasInterface) exitWith {false};
if (!alive player) exitWith {false};

private _vehicle = vehicle player;
if (_vehicle isEqualTo player || {driver _vehicle isNotEqualTo player}) exitWith {
    hint "RHD Vehicle Registration: You must be the driver of the vehicle.";
    false
};
if (!alive _vehicle) exitWith {false};

private _existingOwner = _vehicle getVariable ["RHD_VehicleOwnerUID", ""];
if !(_existingOwner isEqualTo "") exitWith {
    if (_existingOwner isEqualTo getPlayerUID player) then {
        hint "RHD Vehicle Registration: This vehicle is already registered to you.";
    } else {
        hint "RHD Vehicle Registration: This vehicle is already registered to another owner.";
    };
    false
};

_vehicle remoteExecCall ["RHD_fnc_vehicleRegister", 2];
true

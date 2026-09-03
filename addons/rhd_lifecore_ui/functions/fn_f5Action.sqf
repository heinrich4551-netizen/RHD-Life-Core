params [["_action","",[""]]];
if (!hasInterface) exitWith {false};

closeDialog 0;

private _call = {
    params ["_name"];
    private _fn = missionNamespace getVariable [_name, {}];
    if !(isNil {_fn}) then {
        [] call _fn;
    };
};

switch (_action) do {
    case "profile": { ["RHD_fnc_openProfile"] call _call; };
    case "bank": { ["RHD_fnc_bankOpen"] call _call; };
    case "shop": { ["RHD_fnc_shopOpen"] call _call; };
    case "jobs": { ["RHD_fnc_jobDialog"] call _call; };
    case "licenses": { ["RHD_fnc_licenseDialog"] call _call; };
    case "garage": { ["RHD_fnc_garageDialog"] call _call; };
    case "registry": { ["RHD_fnc_vehicleList"] call _call; };
    case "register": { [] call RHD_fnc_registerCurrentVehicle; };
    case "impound": { ["RHD_fnc_impoundDialog"] call _call; };
    default { false };
};
true

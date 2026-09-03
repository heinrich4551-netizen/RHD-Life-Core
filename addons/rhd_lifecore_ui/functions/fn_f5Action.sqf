params [["_action","",[""]]];
if (!hasInterface) exitWith {false};

closeDialog 0;

/*
    Mission compatibility layer:
    missions built around the RHD cTab tablet expose RHD_fnc_ctabOpen and
    RHD_fnc_ctabPage. Prefer that single tablet for F5 so the addon UI does
    not conflict with a mission's existing player interface. Standalone
    LifeCore missions still use the native F5 service dialogs.
*/
private _ctabOpen = missionNamespace getVariable ["RHD_fnc_ctabOpen", {}];
private _ctabPage = missionNamespace getVariable ["RHD_fnc_ctabPage", {}];
private _hasCTab = (_ctabOpen isEqualType {}) && (_ctabPage isEqualType {}) && {!(isNull (uiNamespace getVariable ["cTab_Tablet_dlg", displayNull])) || {isClass (configFile >> "CfgPatches" >> "ctab_core")}};

if (_hasCTab) exitWith {
    if !(call _ctabOpen) exitWith {false};
    private _page = switch (_action) do {
        case "profile": {"STATUS"};
        case "bank": {"BANK"};
        case "shop": {"MARKET"};
        case "jobs": {"JOBS"};
        case "licenses": {"SERVICES"};
        case "garage": {"VEHICLES"};
        case "registry": {"VEHICLES"};
        case "register": {"VEHICLES"};
        case "impound": {"SERVICES"};
        default {"STATUS"};
    };
    [_page] call _ctabPage;
    true
};

private _call = {
    params ["_name"];
    private _fn = missionNamespace getVariable [_name, {}];
    if (_fn isEqualType {}) then {
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

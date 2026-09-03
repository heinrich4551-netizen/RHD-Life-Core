if (!hasInterface) exitWith {false};
private _cfg = missionNamespace getVariable ["RHD_LifeCore_Config", createHashMap];
private _types = {
    params ["_key"];
    ((_cfg getOrDefault [_key, ""]) splitString ",") apply {trim _x} select {_x != ""}
};

private _atmTypes = ["atmClasses"] call _types;
private _shopTypes = ["shopClasses"] call _types;
private _garageTypes = ["garageClasses"] call _types;
private _jobTypes = ["jobClasses"] call _types;
private _licenseTypes = ["licenseOfficeClasses"] call _types;
private _impoundTypes = ["impoundClasses"] call _types;

{
    _x addAction ["<t color='#C9A227'>RHD ATM</t> - Banking", {[] call RHD_fnc_bankOpen}, nil, 1.5, true, true, "", "true", 3, false, ""];
} forEach (allMissionObjects "All" select {typeOf _x in _atmTypes});

{
    _x addAction ["<t color='#C9A227'>RHD Shop</t> - Catalog", {[] call RHD_fnc_shopOpen}, nil, 1.5, true, true, "", "true", 3, false, ""];
} forEach (allMissionObjects "All" select {typeOf _x in _shopTypes});

{
    _x addAction ["<t color='#C9A227'>RHD Garage</t> - Vehicle Storage", {[] call RHD_fnc_garageDialog}, nil, 1.5, true, true, "", "true", 3, false, ""];
} forEach (allMissionObjects "All" select {typeOf _x in _garageTypes});

{
    _x addAction ["<t color='#C9A227'>RHD Jobs</t> - Employment Office", {[] call RHD_fnc_jobDialog}, nil, 1.5, true, true, "", "true", 3, false, ""];
} forEach (allMissionObjects "All" select {typeOf _x in _jobTypes});

{
    _x addAction ["<t color='#C9A227'>RHD Licenses</t> - Licensing Office", {[] call RHD_fnc_licenseDialog}, nil, 1.5, true, true, "", "true", 3, false, ""];
} forEach (allMissionObjects "All" select {typeOf _x in _licenseTypes});

{
    _x addAction ["<t color='#C9A227'>RHD Impound</t> - Vehicle Release", {[] call RHD_fnc_impoundDialog}, nil, 1.5, true, true, "", "true", 3, false, ""];
} forEach (allMissionObjects "All" select {typeOf _x in _impoundTypes});
true

if (!hasInterface) exitWith {false};
private _cfg = missionNamespace getVariable ["RHD_LifeCore_Config", createHashMap];
private _atmTypes = (_cfg getOrDefault ["atmClasses", ""] splitString ",") apply {trim _x};
private _shopTypes = (_cfg getOrDefault ["shopClasses", ""] splitString ",") apply {trim _x};

{
    private _obj = _x;
    if (isNull (_obj getVariable ["RHD_ATM_Interaction", objNull])) then {
        _obj addAction ["<t color='#C9A227'>RHD ATM</t> - Banking", {[] call RHD_fnc_bankOpen}, nil, 1.5, true, true, "", "true", 3, false, ""];
        _obj addAction ["Deposit $100", {['deposit',100] call RHD_fnc_economyRequest}, nil, 1.4, true, true, "", "true", 3, false, ""];
        _obj addAction ["Withdraw $100", {['withdraw',100] call RHD_fnc_economyRequest}, nil, 1.4, true, true, "", "true", 3, false, ""];
        _obj setVariable ["RHD_ATM_Interaction", _obj];
    };
} forEach (allMissionObjects "All" select {typeOf _x in _atmTypes});

{
    private _obj = _x;
    if (isNull (_obj getVariable ["RHD_Shop_Interaction", objNull])) then {
        _obj addAction ["<t color='#C9A227'>RHD Shop</t> - Catalog", {[] call RHD_fnc_shopOpen}, nil, 1.5, true, true, "", "true", 3, false, ""];
        {
            if (count _x >= 4) then {
                private _id = _x select 0;
                private _display = _x select 1;
                private _price = _x select 2;
                _obj addAction [format ["Buy 1x %1 ($%2)", _display, _price], {params ["_target","_caller","_id"]; [_id,1] remoteExecCall ["RHD_fnc_shopBuy",2];}, _id, 1.2, true, true, "", "true", 3, false, ""];
            };
        } forEach ([_cfg getOrDefault ["shopCatalog", ""]] call RHD_fnc_parseList);
        {
            if (count _x >= 3) then {
                private _jobId = _x select 0;
                private _display = _x select 1;
                _obj addAction [format ["Apply for %1", _display], {params ["_target","_caller","_jobId"]; [_jobId] remoteExecCall ["RHD_fnc_jobSet",2];}, _jobId, 1.1, true, true, "", "true", 3, false, ""];
            };
        } forEach ([_cfg getOrDefault ["jobs", ""]] call RHD_fnc_parseList);
        {
            if (count _x >= 3) then {
                private _licenseId = _x select 0;
                private _display = _x select 1;
                private _price = _x select 2;
                _obj addAction [format ["Purchase %1 ($%2)", _display, _price], {params ["_target","_caller","_licenseId"]; [_licenseId] remoteExecCall ["RHD_fnc_licenseBuy",2];}, _licenseId, 1.0, true, true, "", "true", 3, false, ""];
            };
        } forEach ([_cfg getOrDefault ["licenses", ""]] call RHD_fnc_parseList);
        {
            if (count _x >= 3) then {
                private _class = _x select 0;
                private _display = _x select 1;
                private _price = _x select 2;
                _obj addAction [format ["Buy %1 ($%2)", _display, _price], {params ["_target","_caller","_class"]; [_class] remoteExecCall ["RHD_fnc_vehicleBuy",2];}, _class, 0.9, true, true, "", "true", 3, false, ""];
            };
        } forEach ([_cfg getOrDefault ["vehicleCatalog", ""]] call RHD_fnc_parseList);
        _obj setVariable ["RHD_Shop_Interaction", _obj];
    };
} forEach (allMissionObjects "All" select {typeOf _x in _shopTypes});
true
params ["_count"];
if (!isServer || {_count <= 0}) exitWith {0};
private _cfg = missionNamespace getVariable ["RHD_LifeCore_WorldConfig",createHashMap];
private _locations = missionNamespace getVariable ["RHD_LifeCore_Locations",[]];
private _classes = (_cfg getOrDefault ["ambientVehicleClasses","C_Offroad_01_F,C_Hatchback_01_F,C_SUV_01_F"]) splitString ",";
_classes = _classes select {_x != "" && {isClass (configFile >> "CfgVehicles" >> _x)}};
if (_locations isEqualTo [] || {_classes isEqualTo []}) exitWith {0};

private _vehicles = missionNamespace getVariable ["RHD_LifeCore_AmbientVehicles",[]];
private _created = 0;
for "_i" from 1 to _count do {
    private _loc = selectRandom _locations;
    private _locPos = _loc select 2;
    private _pos = [_locPos,40,160] call RHD_fnc_safeSpawnPos;
    if (_pos isNotEqualTo []) then {
        private _veh = createVehicle [selectRandom _classes,_pos,[],0,"NONE"];
        if (!isNull _veh) then {
            _veh setDir (random 360);
            _veh setFuel (0.35 + random 0.65);
            _veh setVariable ["RHD_LifeCore_AmbientVehicle",true,true];
            if (_cfg getOrDefault ["dynamicSimulation",true]) then {_veh enableDynamicSimulation true;};
            _vehicles pushBack _veh;
            _created = _created + 1;
        };
    };
};
missionNamespace setVariable ["RHD_LifeCore_AmbientVehicles",_vehicles,true];
_created

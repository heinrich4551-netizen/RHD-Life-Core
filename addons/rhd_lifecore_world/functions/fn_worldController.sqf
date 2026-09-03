if (!isServer) exitWith {false};
private _cfg = missionNamespace getVariable ["RHD_LifeCore_WorldConfig",createHashMap];
if !(_cfg getOrDefault ["enabled",true]) exitWith {false};

private _anti = missionNamespace getVariable ["RHD_LifeCore_AntistasiDetected",false];
if (_anti && {_cfg getOrDefault ["antistasiCompatibility",true]} && {!(_cfg getOrDefault ["antistasiAIOverride",false])}) exitWith {
    diag_log "[RHD-LifeCore] Antistasi Ultimate detected: native AI/world population retained.";
    false
};

private _locations = missionNamespace getVariable ["RHD_LifeCore_Locations",[]];
if (_locations isEqualTo [] && {_cfg getOrDefault ["generateLocations",true]}) then {_locations = [] call RHD_fnc_generateLocations;};
if ((_cfg getOrDefault ["generateSpawnLocations",true]) && {missionNamespace getVariable ["RHD_LifeCore_SpawnLocations",[]] isEqualTo []}) then {[] call RHD_fnc_generateSpawnLocations;};

missionNamespace setVariable ["RHD_LifeCore_Civilians",missionNamespace getVariable ["RHD_LifeCore_Civilians",[]],true];
missionNamespace setVariable ["RHD_LifeCore_AmbientVehicles",missionNamespace getVariable ["RHD_LifeCore_AmbientVehicles",[]],true];

private _players = allPlayers select {isPlayer _x && {alive _x}};
private _playerCap = (_cfg getOrDefault ["civilianPlayerCap",12]) max 1;
private _effective = ((count _players) max 1) min _playerCap;
private _target = ((_cfg getOrDefault ["civilianBasePopulation",115]) - ((_effective - 1) * (_cfg getOrDefault ["civilianReductionPerPlayer",5]))) max (_cfg getOrDefault ["civilianMinimumPopulation",60]);
_target = _target min (_cfg getOrDefault ["civilianMaximumPopulation",115]);

private _spawnBatch = (_cfg getOrDefault ["civilianSpawnBatch",12]) max 1;
if (_cfg getOrDefault ["initialPopulationFill",true] && {_cfg getOrDefault ["civilianPopulationEnabled",true]} && {_players isNotEqualTo []}) then {
    private _remaining = (_target - count (missionNamespace getVariable ["RHD_LifeCore_Civilians",[]])) max 0;
    while {_remaining > 0} do {
        private _created = [_remaining min _spawnBatch] call RHD_fnc_spawnCivilianBatch;
        if (_created <= 0) exitWith {};
        _remaining = _remaining - _created;
        uiSleep 0.25;
    };
};

while {missionNamespace getVariable ["RHD_LifeCore_WorldStarted",false]} do {
    uiSleep ((_cfg getOrDefault ["updateInterval",15]) max 5);
    _cfg = missionNamespace getVariable ["RHD_LifeCore_WorldConfig",_cfg];
    _anti = missionNamespace getVariable ["RHD_LifeCore_AntistasiDetected",false];
    if (_anti && {_cfg getOrDefault ["antistasiCompatibility",true]} && {!(_cfg getOrDefault ["antistasiAIOverride",false])}) exitWith {};
    [] call RHD_fnc_cleanupAmbient;

    _players = allPlayers select {isPlayer _x && {alive _x}};
    _effective = ((count _players) max 1) min ((_cfg getOrDefault ["civilianPlayerCap",12]) max 1);
    _target = ((_cfg getOrDefault ["civilianBasePopulation",115]) - ((_effective - 1) * (_cfg getOrDefault ["civilianReductionPerPlayer",5]))) max (_cfg getOrDefault ["civilianMinimumPopulation",60]);
    _target = _target min (_cfg getOrDefault ["civilianMaximumPopulation",115]);

    if (_cfg getOrDefault ["civilianPopulationEnabled",true]) then {
        private _current = count (missionNamespace getVariable ["RHD_LifeCore_Civilians",[]]);
        if (_current < _target && {_players isNotEqualTo []}) then {
            [(_target - _current) min ((_cfg getOrDefault ["civilianSpawnBatch",12]) max 1)] call RHD_fnc_spawnCivilianBatch;
        };
    };

    if (_cfg getOrDefault ["ambientVehiclesEnabled",false]) then {
        private _vTarget = (_cfg getOrDefault ["ambientVehicleCount",12]) max 0;
        private _vCurrent = count (missionNamespace getVariable ["RHD_LifeCore_AmbientVehicles",[]]);
        if (_vCurrent < _vTarget && {_locations isNotEqualTo []}) then {
            [(_vTarget - _vCurrent) min ((_cfg getOrDefault ["ambientVehicleBatch",2]) max 1)] call RHD_fnc_spawnAmbientVehicleBatch;
        };
    };
};
true

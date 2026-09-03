params ["_logic", "_units", "_activated"];

if (!_activated) exitWith {false};

private _config = [_logic] call RHD_fnc_applyModuleConfig;

missionNamespace setVariable ["RHD_LifeCore_Enabled", true, true];
missionNamespace setVariable ["RHD_LifeCore_Module", _logic, true];
missionNamespace setVariable ["RHD_LifeCore_Config", _config, true];

if (isServer) then {
    [] call RHD_fnc_serverInit;
};

// The core module also supplies sensible world/population defaults. The dedicated
// World Controller module can override these values later with its full settings.
if (isServer && {!isNil "RHD_fnc_worldInit"}) then {
    private _worldCfg = createHashMap;
    _worldCfg set ["enabled", true];
    _worldCfg set ["generateLocations", true];
    _worldCfg set ["locationTypes", "NameCityCapital,NameCity,NameVillage,NameLocal"];
    _worldCfg set ["locationMax", 0];
    _worldCfg set ["locationMinSpacing", 250];
    _worldCfg set ["generateSpawnLocations", true];
    _worldCfg set ["spawnPointsPerLocation", 12];
    _worldCfg set ["spawnSearchRadius", 600];
    _worldCfg set ["spawnMinDistance", 75];
    _worldCfg set ["civilianPopulationEnabled", _config getOrDefault ["civilianPopulationEnabled", true]];
    _worldCfg set ["civilianBasePopulation", _config getOrDefault ["civilianBasePopulation", 115]];
    _worldCfg set ["civilianReductionPerPlayer", _config getOrDefault ["civilianReductionPerPlayer", 5]];
    _worldCfg set ["civilianMinimumPopulation", _config getOrDefault ["civilianMinimumPopulation", 60]];
    _worldCfg set ["civilianMaximumPopulation", _config getOrDefault ["civilianMaximumPopulation", 115]];
    _worldCfg set ["civilianPlayerCap", _config getOrDefault ["civilianActivePlayerCap", 12]];
    _worldCfg set ["civilianSpawnBatch", 12];
    _worldCfg set ["civilianGroupSize", 4];
    _worldCfg set ["civilianClasses", "C_Man_1_F,C_Man_1_1_F,C_Man_1_2_F,C_Man_1_3_F,C_Man_1_4_F,C_Man_1_6_F,C_Man_2_F,C_Man_2_1_F,C_Man_2_2_F,C_Man_2_3_F,C_Man_2_4_F,C_Man_3_F"];
    _worldCfg set ["civilianBehaviour", "CARELESS"];
    _worldCfg set ["civilianSkill", 0.10];
    _worldCfg set ["civilianDespawnRadius", _config getOrDefault ["civilianDespawnRadius", 2500]];
    _worldCfg set ["updateInterval", _config getOrDefault ["civilianUpdateInterval", 15]];
    _worldCfg set ["ambientVehiclesEnabled", false];
    _worldCfg set ["ambientVehicleCount", 12];
    _worldCfg set ["ambientVehicleClasses", "C_Offroad_01_F,C_Hatchback_01_F,C_SUV_01_F"];
    _worldCfg set ["ambientVehicleBatch", 2];
    _worldCfg set ["dynamicSimulation", true];
    _worldCfg set ["dynamicSimulationDistance", 1500];
    _worldCfg set ["debugMarkers", _config getOrDefault ["debug", false]];
    _worldCfg set ["antistasiCompatibility", true];
    _worldCfg set ["antistasiAIOverride", false];
    _worldCfg set ["antistasiEconomyOverride", false];
    _worldCfg set ["blacklistLocations", ""];
    _worldCfg set ["initialPopulationFill", true];
    missionNamespace setVariable ["RHD_LifeCore_WorldConfig", _worldCfg, true];
    [] call RHD_fnc_worldInit;
};

if (missionNamespace getVariable ["RHD_LifeCore_Config", createHashMap] getOrDefault ["debug", false]) then {
    diag_log format ["[RHD-LifeCore] 3DEN RP module initialized: %1", _config];
};

true

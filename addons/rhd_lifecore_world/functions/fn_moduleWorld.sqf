params ["_logic", "_units", "_activated"];
if (!_activated || {isNull _logic}) exitWith {false};

private _cfg = createHashMap;
{
    private _key = _x select 0;
    private _var = _x select 1;
    private _default = _x select 2;
    _cfg set [_key, _logic getVariable [_var, _default]];
} forEach [
    ["enabled","RHD_WorldEnabled",true],
    ["generateLocations","RHD_GenerateLocations",true],
    ["locationTypes","RHD_LocationTypes","NameCityCapital,NameCity,NameVillage,NameLocal"],
    ["locationMax","RHD_LocationMax",0],
    ["locationMinSpacing","RHD_LocationMinSpacing",250],
    ["generateSpawnLocations","RHD_GenerateSpawnLocations",true],
    ["spawnPointsPerLocation","RHD_SpawnPointsPerLocation",12],
    ["spawnSearchRadius","RHD_SpawnSearchRadius",600],
    ["spawnMinDistance","RHD_SpawnMinDistance",75],
    ["civilianPopulationEnabled","RHD_CivilianPopulationEnabled",true],
    ["civilianBasePopulation","RHD_CivilianBasePopulation",115],
    ["civilianReductionPerPlayer","RHD_CivilianReductionPerPlayer",5],
    ["civilianMinimumPopulation","RHD_CivilianMinimumPopulation",60],
    ["civilianMaximumPopulation","RHD_CivilianMaximumPopulation",115],
    ["civilianPlayerCap","RHD_CivilianPlayerCap",12],
    ["civilianSpawnBatch","RHD_CivilianSpawnBatch",12],
    ["civilianGroupSize","RHD_CivilianGroupSize",4],
    ["civilianClasses","RHD_CivilianClasses","C_Man_1_F,C_Man_1_1_F,C_Man_1_2_F,C_Man_1_3_F,C_Man_1_4_F,C_Man_1_6_F,C_Man_2_F,C_Man_2_1_F,C_Man_2_2_F,C_Man_2_3_F,C_Man_2_4_F,C_Man_3_F"],
    ["civilianBehaviour","RHD_CivilianBehaviour","CARELESS"],
    ["civilianSkill","RHD_CivilianSkill",0.10],
    ["civilianDespawnRadius","RHD_CivilianSpawnRadius",2500],
    ["updateInterval","RHD_UpdateInterval",15],
    ["ambientVehiclesEnabled","RHD_AmbientVehiclesEnabled",false],
    ["ambientVehicleCount","RHD_AmbientVehicleCount",12],
    ["ambientVehicleClasses","RHD_AmbientVehicleClasses","C_Offroad_01_F,C_Hatchback_01_F,C_SUV_01_F"],
    ["ambientVehicleBatch","RHD_AmbientVehicleBatch",2],
    ["dynamicSimulation","RHD_DynamicSimulation",true],
    ["dynamicSimulationDistance","RHD_DynamicSimulationDistance",1500],
    ["debugMarkers","RHD_DebugMarkers",false],
    ["antistasiCompatibility","RHD_AntistasiCompatibility",true],
    ["antistasiAIOverride","RHD_AntistasiAIOverride",false],
    ["antistasiEconomyOverride","RHD_AntistasiEconomyOverride",false],
    ["blacklistLocations","RHD_BlacklistLocations",""],
    ["initialPopulationFill","RHD_InitialPopulationFill",true]
];

missionNamespace setVariable ["RHD_LifeCore_WorldConfig",_cfg,true];
missionNamespace setVariable ["RHD_LifeCore_WorldModule",_logic,true];

private _hasAntistasi = isClass (configFile >> "CfgPatches" >> "A3A");
missionNamespace setVariable ["RHD_LifeCore_AntistasiDetected",_hasAntistasi,true];
missionNamespace setVariable ["RHD_AntistasiNoOverrideAI",(_hasAntistasi && {_cfg getOrDefault ["antistasiCompatibility",true]} && {!(_cfg getOrDefault ["antistasiAIOverride",false])}),true];

if (_cfg getOrDefault ["enabled",true]) then {
    if (isServer) then { [] call RHD_fnc_worldInit; } else { [] remoteExecCall ["RHD_fnc_worldInit",2]; };
};

true

/*
    RHD LifeCore - 3DEN module configuration publisher
    Keeps all gameplay setup in the placed module and publishes a normalized
    configuration HashMap for the rest of LifeCore to consume.
*/
params ["_logic"];

if (isNull _logic) exitWith {};

private _config = createHashMap;
_config set ["identityEnabled", _logic getVariable ["RHD_IdentityEnabled", true]];
_config set ["economyEnabled", _logic getVariable ["RHD_EconomyEnabled", true]];
_config set ["startingCash", (_logic getVariable ["RHD_StartingCash", 500]) max 0];
_config set ["startingBank", (_logic getVariable ["RHD_StartingBank", 1000]) max 0];
_config set ["farmingEnabled", _logic getVariable ["RHD_FarmingEnabled", true]];
_config set ["miningEnabled", _logic getVariable ["RHD_MiningEnabled", true]];
_config set ["refiningEnabled", _logic getVariable ["RHD_RefiningEnabled", true]];
_config set ["shopsEnabled", _logic getVariable ["RHD_ShopsEnabled", true]];
_config set ["civilianPopulationEnabled", _logic getVariable ["RHD_CivilianPopulationEnabled", true]];
_config set ["civilianBasePopulation", (_logic getVariable ["RHD_CivilianBasePopulation", 115]) max 1];
_config set ["civilianMinimumPopulation", (_logic getVariable ["RHD_CivilianMinimumPopulation", 60]) max 1];
_config set ["civilianReductionPerPlayer", (_logic getVariable ["RHD_CivilianReductionPerPlayer", 5]) max 0];
_config set ["civilianMaximumPopulation", (_logic getVariable ["RHD_CivilianMaximumPopulation", 115]) max 1];
_config set ["civilianActivePlayerCap", (_logic getVariable ["RHD_CivilianActivePlayerCap", 12]) max 1];
_config set ["civilianSpawnRadius", (_logic getVariable ["RHD_CivilianSpawnRadius", 1500]) max 100];
_config set ["civilianDespawnRadius", (_logic getVariable ["RHD_CivilianDespawnRadius", 2500]) max 200];
_config set ["civilianUpdateInterval", (_logic getVariable ["RHD_CivilianUpdateInterval", 30]) max 5];
_config set ["debugLogging", _logic getVariable ["RHD_DebugLogging", false]];

// Farming harvest quantities.
_config set ["farmAppleMin", (_logic getVariable ["RHD_FarmAppleMin", 1]) max 0];
_config set ["farmAppleMax", (_logic getVariable ["RHD_FarmAppleMax", 4]) max 0];
_config set ["farmCannabisMin", (_logic getVariable ["RHD_FarmCannabisMin", 1]) max 0];
_config set ["farmCannabisMax", (_logic getVariable ["RHD_FarmCannabisMax", 3]) max 0];
_config set ["farmCocaMin", (_logic getVariable ["RHD_FarmCocaMin", 1]) max 0];
_config set ["farmCocaMax", (_logic getVariable ["RHD_FarmCocaMax", 3]) max 0];
_config set ["farmCornMin", (_logic getVariable ["RHD_FarmCornMin", 1]) max 0];
_config set ["farmCornMax", (_logic getVariable ["RHD_FarmCornMax", 5]) max 0];
_config set ["farmGrapeMin", (_logic getVariable ["RHD_FarmGrapeMin", 1]) max 0];
_config set ["farmGrapeMax", (_logic getVariable ["RHD_FarmGrapeMax", 4]) max 0];
_config set ["farmPeachMin", (_logic getVariable ["RHD_FarmPeachMin", 1]) max 0];
_config set ["farmPeachMax", (_logic getVariable ["RHD_FarmPeachMax", 4]) max 0];

// Mining harvest quantities.
_config set ["mineIronMin", (_logic getVariable ["RHD_MineIronMin", 1]) max 0];
_config set ["mineIronMax", (_logic getVariable ["RHD_MineIronMax", 4]) max 0];
_config set ["mineCopperMin", (_logic getVariable ["RHD_MineCopperMin", 1]) max 0];
_config set ["mineCopperMax", (_logic getVariable ["RHD_MineCopperMax", 4]) max 0];
_config set ["mineGoldMin", (_logic getVariable ["RHD_MineGoldMin", 1]) max 0];
_config set ["mineGoldMax", (_logic getVariable ["RHD_MineGoldMax", 2]) max 0];
_config set ["mineDiamondMin", (_logic getVariable ["RHD_MineDiamondMin", 0]) max 0];
_config set ["mineDiamondMax", (_logic getVariable ["RHD_MineDiamondMax", 1]) max 0];
_config set ["mineOilSandMin", (_logic getVariable ["RHD_MineOilSandMin", 1]) max 0];
_config set ["mineOilSandMax", (_logic getVariable ["RHD_MineOilSandMax", 4]) max 0];

// Enforce valid min/max pairs.
{
    private _minKey = _x select 0;
    private _maxKey = _x select 1;
    private _minValue = _config get _minKey;
    private _maxValue = _config get _maxKey;
    if (_maxValue < _minValue) then {_config set [_maxKey, _minValue];};
} forEach [
    ["farmAppleMin", "farmAppleMax"], ["farmCannabisMin", "farmCannabisMax"],
    ["farmCocaMin", "farmCocaMax"], ["farmCornMin", "farmCornMax"],
    ["farmGrapeMin", "farmGrapeMax"], ["farmPeachMin", "farmPeachMax"],
    ["mineIronMin", "mineIronMax"], ["mineCopperMin", "mineCopperMax"],
    ["mineGoldMin", "mineGoldMax"], ["mineDiamondMin", "mineDiamondMax"],
    ["mineOilSandMin", "mineOilSandMax"]
];

_config set ["civilianMinimumPopulation", (_config get "civilianMinimumPopulation") min (_config get "civilianMaximumPopulation")];
missionNamespace setVariable ["RHD_LifeCore_Config", _config, true];
missionNamespace setVariable ["RHD_LifeCore_Enabled", true, true];

if (_config get "debugLogging") then {
    diag_log format ["[RHD LifeCore] 3DEN configuration applied: %1", _config];
};

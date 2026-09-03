/* RHD LifeCore - central 3DEN configuration publisher */
params ["_logic"];
if (isNull _logic) exitWith {createHashMap};

private _config = createHashMap;
_config set ["identityEnabled", _logic getVariable ["RHD_EnableIdentity", true]];
_config set ["economyEnabled", _logic getVariable ["RHD_EnableEconomy", true]];
_config set ["storageAdapter", toLower (_logic getVariable ["RHD_StorageAdapter", "profilenamespace"])];
_config set ["startingCash", (_logic getVariable ["RHD_StartingCash", 500]) max 0];
_config set ["startingBank", (_logic getVariable ["RHD_StartingBank", 1000]) max 0];
_config set ["defaultJob", _logic getVariable ["RHD_DefaultJob", "unemployed"]];
_config set ["jobs", _logic getVariable ["RHD_Jobs", "civilian:Citizen:0,police:Police:250,ems:EMS:250,driver:Driver:175"]];
_config set ["licenses", _logic getVariable ["RHD_Licenses", "driving:Driving:250,weapon:Weapons:1500,commercial:Commercial:750"]];
_config set ["shopCatalog", _logic getVariable ["RHD_ShopCatalog", "apple:Apple:10:4,corn:Corn:8:3,grapes:Grapes:12:5,peaches:Peach:12:5,iron:Iron:35:15,copper:Copper:45:20,gold:Gold:150:75,diamond:Diamond:500:250,oil_sand:Oil Sand:25:10"]];
_config set ["atmClasses", _logic getVariable ["RHD_ATMClasses", "Land_Atm_01_F,Land_Atm_02_F,Land_Atm_01_malden_F,Land_Atm_02_malden_F"]];
_config set ["shopClasses", _logic getVariable ["RHD_ShopClasses", "Land_Shed_Small_F,Land_Kiosk_redburger_F"]];
_config set ["vehicleCatalog", _logic getVariable ["RHD_VehicleCatalog", "C_Offroad_01_F:Offroad:15000,C_Hatchback_01_F:Hatchback:18000,C_SUV_01_F:SUV:30000"]];
_config set ["bankingEnabled", _logic getVariable ["RHD_EnableBanking", true]];
_config set ["shopsEnabled", _logic getVariable ["RHD_EnableShops", true]];
_config set ["vehiclesEnabled", _logic getVariable ["RHD_EnableVehicles", true]];
_config set ["jobsEnabled", _logic getVariable ["RHD_EnableJobs", true]];
_config set ["rolesEnabled", _logic getVariable ["RHD_EnableRoles", true]];
_config set ["civilianPopulationEnabled", _logic getVariable ["RHD_CivilianPopulationEnabled", true]];
_config set ["civilianBasePopulation", (_logic getVariable ["RHD_CivilianBasePopulation", 115]) max 1];
_config set ["civilianMinimumPopulation", (_logic getVariable ["RHD_CivilianMinimumPopulation", 60]) max 1];
_config set ["civilianReductionPerPlayer", (_logic getVariable ["RHD_CivilianReductionPerPlayer", 5]) max 0];
_config set ["civilianMaximumPopulation", (_logic getVariable ["RHD_CivilianMaximumPopulation", 115]) max 1];
_config set ["civilianActivePlayerCap", (_logic getVariable ["RHD_CivilianActivePlayerCap", 12]) max 1];
_config set ["civilianSpawnRadius", (_logic getVariable ["RHD_CivilianSpawnRadius", 1500]) max 100];
_config set ["civilianDespawnRadius", (_logic getVariable ["RHD_CivilianDespawnRadius", 2500]) max 200];
_config set ["civilianUpdateInterval", (_logic getVariable ["RHD_CivilianUpdateInterval", 30]) max 5];
_config set ["farmingConfig", _logic getVariable ["RHD_FarmingConfig", "apple:1:4,cannabis:1:3,coca:1:3,corn:2:8,grapes:1:5,peaches:1:5"]];
_config set ["miningConfig", _logic getVariable ["RHD_MiningConfig", "iron:1:5,copper:1:4,gold:1:2,diamond:0:1,oil_sand:1:4"]];
_config set ["debugLogging", _logic getVariable ["RHD_Debug", false]];

missionNamespace setVariable ["RHD_LifeCore_Config", _config, true];
missionNamespace setVariable ["RHD_LifeCore_Enabled", true, true];

if (_config getOrDefault ["debugLogging", false]) then {
    diag_log format ["[RHD-LifeCore] 3DEN configuration applied: %1", _config];
};
_config
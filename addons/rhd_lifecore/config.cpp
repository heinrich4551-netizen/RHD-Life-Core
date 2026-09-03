class CfgPatches
{
    class RHD_LifeCore
    {
        name = "RHD - LifeCore";
        author = "LT. Toad";
        url = "https://github.com/heinrich4551-netizen/RHD-Life-Core";
        requiredVersion = 2.14;
        requiredAddons[] = {"A3_Modules_F"};
        units[] = {"RHD_Module_RP"};
        weapons[] = {};
    };
};

class CfgFunctions
{
    class RHD
    {
        class LifeCore
        {
            file = "\\x\\rhd_lifecore\\addons\\rhd_lifecore\\functions";
            class moduleRP {};
            class applyModuleConfig {};
            class initPlayer { postInit = 1; };
            class serverInit { postInit = 1; };
            class setupInteractions {};
            class openMenu {};
            class openProfile {};
            class setIdentity {};
            class getMoney {};
            class addMoney {};
            class economyRequest {};
            class serverEconomy {};
            class serverLoadProfile {};
            class serverSaveProfile {};
            class profileGet {};
            class profileSet {};
            class parseList {};
            class jobSet {};
            class jobGet {};
            class licenseBuy {};
            class licenseHas {};
            class shopOpen {};
            class shopBuy {};
            class shopSell {};
            class bankOpen {};
            class bankTransfer {};
            class atmFind {};
            class vehicleBuy {};
            class vehicleRegister {};
            class vehicleList {};
            class roleSet {};
            class roleGet {};
            class roleCan {};
            class getCivilianCount {};
        };
    };
};

class CfgRemoteExec
{
    class Functions
    {
        mode = 2;
        jip = 0;
        class RHD_fnc_serverLoadProfile { allowedTargets = 2; jip = 0; };
        class RHD_fnc_serverSaveProfile { allowedTargets = 2; jip = 0; };
        class RHD_fnc_serverEconomy { allowedTargets = 2; jip = 0; };
        class RHD_fnc_economyRequest { allowedTargets = 2; jip = 0; };
        class RHD_fnc_jobSet { allowedTargets = 2; jip = 0; };
        class RHD_fnc_licenseBuy { allowedTargets = 2; jip = 0; };
        class RHD_fnc_shopBuy { allowedTargets = 2; jip = 0; };
        class RHD_fnc_shopSell { allowedTargets = 2; jip = 0; };
        class RHD_fnc_bankTransfer { allowedTargets = 2; jip = 0; };
        class RHD_fnc_vehicleBuy { allowedTargets = 2; jip = 0; };
        class RHD_fnc_vehicleRegister { allowedTargets = 2; jip = 0; };
        class RHD_fnc_roleSet { allowedTargets = 2; jip = 0; };
    };
};

class Cfg3DEN
{
    class Group
    {
        class AttributeCategories;
    };
};

class CfgVehicles
{
    class Logic;
    class Module_F: Logic
    {
        class AttributesBase;
        class ModuleDescription;
    };

    class RHD_Module_RP: Module_F
    {
        scope = 2;
        scopeCurator = 2;
        displayName = "RHD LifeCore - RP Framework";
        icon = "\\A3\\ui_f\\data\\logos\\arma3_alpha_ca.paa";
        category = "RHD_LifeCore";
        function = "RHD_fnc_moduleRP";
        isGlobal = 1;
        isTriggerActivated = 1;
        isDisposable = 0;
        curatorCanAttach = 1;

        class Attributes: AttributesBase
        {
            class RHD_EnableIdentity
            {
                property = "RHD_EnableIdentity";
                displayName = "Enable Character Identity";
                tooltip = "Enables the character profile and RP identity service.";
                control = "Checkbox";
                expression = "_this setVariable ['RHD_EnableIdentity',_value,true]";
                defaultValue = "true";
                typeName = "BOOL";
            };
            class RHD_EnableEconomy
            {
                property = "RHD_EnableEconomy";
                displayName = "Enable Economy";
                tooltip = "Enables server-authoritative cash and bank balances.";
                control = "Checkbox";
                expression = "_this setVariable ['RHD_EnableEconomy',_value,true]";
                defaultValue = "true";
                typeName = "BOOL";
            };
            class RHD_StorageAdapter
            {
                property = "RHD_StorageAdapter";
                displayName = "Profile Storage Adapter";
                tooltip = "profileNamespace works without external dependencies. EXTDB is reserved for a future adapter.";
                control = "Edit";
                expression = "_this setVariable ['RHD_StorageAdapter',toLower _value,true]";
                defaultValue = "profilenamespace";
                typeName = "STRING";
            };
            class RHD_StartingCash
            {
                property = "RHD_StartingCash";
                displayName = "Starting Cash";
                tooltip = "Cash issued to a new character profile.";
                control = "Edit";
                expression = "_this setVariable ['RHD_StartingCash',_value,true]";
                defaultValue = "500";
                typeName = "NUMBER";
            };
            class RHD_StartingBank
            {
                property = "RHD_StartingBank";
                displayName = "Starting Bank";
                tooltip = "Bank balance issued to a new character profile.";
                control = "Edit";
                expression = "_this setVariable ['RHD_StartingBank',_value,true]";
                defaultValue = "1000";
                typeName = "NUMBER";
            };
            class RHD_DefaultJob
            {
                property = "RHD_DefaultJob";
                displayName = "Default Job";
                control = "Edit";
                expression = "_this setVariable ['RHD_DefaultJob',_value,true]";
                defaultValue = "unemployed";
                typeName = "STRING";
            };
            class RHD_Jobs
            {
                property = "RHD_Jobs";
                displayName = "Jobs";
                tooltip = "Comma-separated job definitions: id:display:pay. Example civilian:Citizen:0,police:Police:250,ems:EMS:250,driver:Driver:175";
                control = "Edit";
                expression = "_this setVariable ['RHD_Jobs',_value,true]";
                defaultValue = "civilian:Citizen:0,police:Police:250,ems:EMS:250,driver:Driver:175";
                typeName = "STRING";
            };
            class RHD_Licenses
            {
                property = "RHD_Licenses";
                displayName = "Licenses";
                tooltip = "Comma-separated license definitions: id:display:price. Example driving:Driving:250,weapon:Weapon:1500";
                control = "Edit";
                expression = "_this setVariable ['RHD_Licenses',_value,true]";
                defaultValue = "driving:Driving:250,weapon:Weapons:1500,commercial:Commercial:750";
                typeName = "STRING";
            };
            class RHD_ShopCatalog
            {
                property = "RHD_ShopCatalog";
                displayName = "Shop Catalog";
                tooltip = "Comma-separated item definitions: id:display:buy:sell. Prices are server-validated.";
                control = "Edit";
                expression = "_this setVariable ['RHD_ShopCatalog',_value,true]";
                defaultValue = "apple:Apple:10:4,cannabis:Cannabis:50:20,corn:Corn:8:3,grapes:Grapes:12:5,peaches:Peach:12:5,iron:Iron:35:15,copper:Copper:45:20,gold:Gold:150:75,diamond:Diamond:500:250,oil_sand:Oil Sand:25:10";
                typeName = "STRING";
            };
            class RHD_ATMClasses
            {
                property = "RHD_ATMClasses";
                displayName = "ATM Object Classes";
                tooltip = "Comma-separated object class names used as ATM interaction points.";
                control = "Edit";
                expression = "_this setVariable ['RHD_ATMClasses',_value,true]";
                defaultValue = "Land_Atm_01_F,Land_Atm_02_F,Land_Atm_01_malden_F,Land_Atm_02_malden_F";
                typeName = "STRING";
            };
            class RHD_ShopClasses
            {
                property = "RHD_ShopClasses";
                displayName = "Shop Object Classes";
                tooltip = "Comma-separated object class names used as shop interaction points.";
                control = "Edit";
                expression = "_this setVariable ['RHD_ShopClasses',_value,true]";
                defaultValue = "Land_Shed_Small_F,Land_Kiosk_redburger_F";
                typeName = "STRING";
            };
            class RHD_VehicleCatalog
            {
                property = "RHD_VehicleCatalog";
                displayName = "Vehicle Catalog";
                tooltip = "Comma-separated vehicles: classname:display:price. Example C_Offroad_01_F:Offroad:15000";
                control = "Edit";
                expression = "_this setVariable ['RHD_VehicleCatalog',_value,true]";
                defaultValue = "C_Offroad_01_F:Offroad:15000,C_Hatchback_01_F:Hatchback:18000,C_SUV_01_F:SUV:30000";
                typeName = "STRING";
            };
            class RHD_EnableBanking
            {
                property = "RHD_EnableBanking";
                displayName = "Enable Banking / ATM";
                control = "Checkbox";
                expression = "_this setVariable ['RHD_EnableBanking',_value,true]";
                defaultValue = "true";
                typeName = "BOOL";
            };
            class RHD_EnableShops
            {
                property = "RHD_EnableShops";
                displayName = "Enable Shops";
                control = "Checkbox";
                expression = "_this setVariable ['RHD_EnableShops',_value,true]";
                defaultValue = "true";
                typeName = "BOOL";
            };
            class RHD_EnableVehicles
            {
                property = "RHD_EnableVehicles";
                displayName = "Enable Vehicle Ownership";
                control = "Checkbox";
                expression = "_this setVariable ['RHD_EnableVehicles',_value,true]";
                defaultValue = "true";
                typeName = "BOOL";
            };
            class RHD_EnableJobs
            {
                property = "RHD_EnableJobs";
                displayName = "Enable Jobs / Licenses";
                control = "Checkbox";
                expression = "_this setVariable ['RHD_EnableJobs',_value,true]";
                defaultValue = "true";
                typeName = "BOOL";
            };
            class RHD_EnableRoles
            {
                property = "RHD_EnableRoles";
                displayName = "Enable Police / EMS / Civilian Roles";
                control = "Checkbox";
                expression = "_this setVariable ['RHD_EnableRoles',_value,true]";
                defaultValue = "true";
                typeName = "BOOL";
            };
            class RHD_CivilianPopulationEnabled
            {
                property = "RHD_CivilianPopulationEnabled";
                displayName = "Enable Dynamic Civilian Population";
                control = "Checkbox";
                expression = "_this setVariable ['RHD_CivilianPopulationEnabled',_value,true]";
                defaultValue = "true";
                typeName = "BOOL";
            };
            class RHD_CivilianBasePopulation
            {
                property = "RHD_CivilianBasePopulation";
                displayName = "Civilian AI at 1 Player";
                control = "Edit";
                expression = "_this setVariable ['RHD_CivilianBasePopulation',_value,true]";
                defaultValue = "115";
                typeName = "NUMBER";
            };
            class RHD_CivilianMinimumPopulation
            {
                property = "RHD_CivilianMinimumPopulation";
                displayName = "Civilian AI Minimum";
                control = "Edit";
                expression = "_this setVariable ['RHD_CivilianMinimumPopulation',_value,true]";
                defaultValue = "60";
                typeName = "NUMBER";
            };
            class RHD_CivilianReductionPerPlayer
            {
                property = "RHD_CivilianReductionPerPlayer";
                displayName = "AI Reduction per Additional Player";
                control = "Edit";
                expression = "_this setVariable ['RHD_CivilianReductionPerPlayer',_value,true]";
                defaultValue = "5";
                typeName = "NUMBER";
            };
            class RHD_CivilianMaximumPopulation
            {
                property = "RHD_CivilianMaximumPopulation";
                displayName = "Civilian AI Maximum";
                control = "Edit";
                expression = "_this setVariable ['RHD_CivilianMaximumPopulation',_value,true]";
                defaultValue = "115";
                typeName = "NUMBER";
            };
            class RHD_CivilianActivePlayerCap
            {
                property = "RHD_CivilianActivePlayerCap";
                displayName = "Active Player Scaling Cap";
                control = "Edit";
                expression = "_this setVariable ['RHD_CivilianActivePlayerCap',_value,true]";
                defaultValue = "12";
                typeName = "NUMBER";
            };
            class RHD_CivilianSpawnRadius
            {
                property = "RHD_CivilianSpawnRadius";
                displayName = "Civilian Spawn Radius";
                control = "Edit";
                expression = "_this setVariable ['RHD_CivilianSpawnRadius',_value,true]";
                defaultValue = "1500";
                typeName = "NUMBER";
            };
            class RHD_CivilianDespawnRadius
            {
                property = "RHD_CivilianDespawnRadius";
                displayName = "Civilian Despawn Radius";
                control = "Edit";
                expression = "_this setVariable ['RHD_CivilianDespawnRadius',_value,true]";
                defaultValue = "2500";
                typeName = "NUMBER";
            };
            class RHD_CivilianUpdateInterval
            {
                property = "RHD_CivilianUpdateInterval";
                displayName = "Civilian Population Update Interval";
                control = "Edit";
                expression = "_this setVariable ['RHD_CivilianUpdateInterval',_value,true]";
                defaultValue = "30";
                typeName = "NUMBER";
            };
            class RHD_FarmingConfig
            {
                property = "RHD_FarmingConfig";
                displayName = "Farming Harvest Min/Max";
                tooltip = "Comma-separated item:min:max definitions.";
                control = "Edit";
                expression = "_this setVariable ['RHD_FarmingConfig',_value,true]";
                defaultValue = "apple:1:4,cannabis:1:3,coca:1:3,corn:2:8,grapes:1:5,peaches:1:5";
                typeName = "STRING";
            };
            class RHD_MiningConfig
            {
                property = "RHD_MiningConfig";
                displayName = "Mining Harvest Min/Max";
                tooltip = "Comma-separated item:min:max definitions.";
                control = "Edit";
                expression = "_this setVariable ['RHD_MiningConfig',_value,true]";
                defaultValue = "iron:1:5,copper:1:4,gold:1:2,diamond:0:1,oil_sand:1:4";
                typeName = "STRING";
            };
            class RHD_Debug
            {
                property = "RHD_Debug";
                displayName = "Debug Logging";
                control = "Checkbox";
                expression = "_this setVariable ['RHD_Debug',_value,true]";
                defaultValue = "false";
                typeName = "BOOL";
            };
            class ModuleDescription: ModuleDescription {};
        };
    };
};

class CfgFactionClasses
{
    class RHD_LifeCore
    {
        displayName = "RHD - LifeCore";
        priority = 5;
        side = 7;
    };
};

class RscText;
class RscStructuredText;
class RscButton;

class RHD_ProfileDialog
{
    idd = 8840;
    movingEnable = 0;
    enableSimulation = 1;
    onLoad = "uiNamespace setVariable ['RHD_ProfileDialog',_this select 0];";
    class controlsBackground
    {
        class Background: RscText
        {
            x = 0.20; y = 0.12; w = 0.60; h = 0.72;
            colorBackground[] = {0,0,0,0.88};
        };
        class Header: RscText
        {
            x = 0.20; y = 0.12; w = 0.60; h = 0.08;
            text = "RHD - LifeCore | Character Profile";
            sizeEx = 0.035;
            colorBackground[] = {0.12,0.12,0.12,0.95};
        };
    };
    class controls
    {
        class Profile: RscStructuredText
        {
            idc = 8841;
            x = 0.23; y = 0.23; w = 0.54; h = 0.50;
            size = 0.9;
            text = "Loading profile...";
        };
        class Close: RscButton
        {
            idc = 8842;
            x = 0.61; y = 0.76; w = 0.16; h = 0.05;
            text = "Close";
            action = "closeDialog 0";
        };
    };
};

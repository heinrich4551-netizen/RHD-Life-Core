class CfgPatches
{
    class RHD_LifeCore_World
    {
        name = "RHD - LifeCore World Controller";
        author = "LT. Toad";
        url = "https://github.com/heinrich4551-netizen/RHD-Life-Core";
        requiredVersion = 2.14;
        requiredAddons[] = {"RHD_LifeCore","A3_Modules_F"};
        units[] = {"RHD_Module_World"};
        weapons[] = {};
    };
};

class CfgFunctions
{
    class RHD
    {
        class LifeCoreWorld
        {
            file = "\\x\\rhd_lifecore\\addons\\rhd_lifecore_world\\functions";
            class moduleWorld {};
            class worldInit { postInit = 1; };
            class generateLocations {};
            class generateSpawnLocations {};
            class safeSpawnPos {};
            class worldController {};
            class spawnCivilianBatch {};
            class spawnAmbientVehicleBatch {};
            class cleanupAmbient {};
        };
    };
};

class CfgRemoteExec
{
    class Functions
    {
        mode = 2;
        jip = 0;
        class RHD_fnc_moduleWorld { allowedTargets = 2; jip = 0; };
        class RHD_fnc_worldInit { allowedTargets = 2; jip = 0; };
    };
};

class Logic;
class Module_F: Logic
{
    class AttributesBase;
    class ModuleDescription;
};

class CfgVehicles
{
    class RHD_Module_World: Module_F
    {
        scope = 2;
        scopeCurator = 2;
        displayName = "RHD LifeCore - World / Population Controller";
        icon = "\\x\\rhd_lifecore\\addons\\rhd_lifecore\\pictures\\RHD_LifeCore_Module.jpg";
        editorPreview = "\\x\\rhd_lifecore\\addons\\rhd_lifecore\\pictures\\RHD_LifeCore_Module.jpg";
        category = "RHD_LifeCore";
        function = "RHD_fnc_moduleWorld";
        isGlobal = 1;
        isTriggerActivated = 1;
        isDisposable = 0;
        curatorCanAttach = 1;

        class Attributes: AttributesBase
        {
            class RHD_WorldEnabled
            {
                property = "RHD_WorldEnabled";
                displayName = "Enable World Controller";
                tooltip = "Master switch for the RHD location, spawn and ambient population controller.";
                control = "Checkbox";
                expression = "_this setVariable ['RHD_WorldEnabled',_value,true]";
                defaultValue = "true";
                typeName = "BOOL";
            };
            class RHD_GenerateLocations
            {
                property = "RHD_GenerateLocations";
                displayName = "Generate Map Locations";
                tooltip = "Scans the current world for named cities, towns, villages and local locations.";
                control = "Checkbox";
                expression = "_this setVariable ['RHD_GenerateLocations',_value,true]";
                defaultValue = "true";
                typeName = "BOOL";
            };
            class RHD_LocationTypes
            {
                property = "RHD_LocationTypes";
                displayName = "Location Types";
                tooltip = "Comma-separated CfgWorlds location types to include. NameCityCapital,NameCity,NameVillage,NameLocal are the normal civilian population targets.";
                control = "Edit";
                expression = "_this setVariable ['RHD_LocationTypes',_value,true]";
                defaultValue = "NameCityCapital,NameCity,NameVillage,NameLocal";
                typeName = "STRING";
            };
            class RHD_LocationMax
            {
                property = "RHD_LocationMax";
                displayName = "Maximum Locations";
                tooltip = "Maximum number of discovered named locations kept in the runtime database. 0 means unlimited.";
                control = "Edit";
                expression = "_this setVariable ['RHD_LocationMax',_value,true]";
                defaultValue = "0";
                typeName = "NUMBER";
            };
            class RHD_LocationMinSpacing
            {
                property = "RHD_LocationMinSpacing";
                displayName = "Location Minimum Spacing";
                tooltip = "Minimum distance between generated population locations. Helps prevent duplicate/overlapping map locations.";
                control = "Edit";
                expression = "_this setVariable ['RHD_LocationMinSpacing',_value,true]";
                defaultValue = "250";
                typeName = "NUMBER";
            };
            class RHD_GenerateSpawnLocations
            {
                property = "RHD_GenerateSpawnLocations";
                displayName = "Generate Spawn Locations";
                tooltip = "Creates a pool of safe civilian spawn positions around every generated map location.";
                control = "Checkbox";
                expression = "_this setVariable ['RHD_GenerateSpawnLocations',_value,true]";
                defaultValue = "true";
                typeName = "BOOL";
            };
            class RHD_SpawnPointsPerLocation
            {
                property = "RHD_SpawnPointsPerLocation";
                displayName = "Spawn Points per Location";
                tooltip = "Number of candidate civilian spawn positions generated for each named location.";
                control = "Edit";
                expression = "_this setVariable ['RHD_SpawnPointsPerLocation',_value,true]";
                defaultValue = "12";
                typeName = "NUMBER";
            };
            class RHD_SpawnSearchRadius
            {
                property = "RHD_SpawnSearchRadius";
                displayName = "Spawn Search Radius";
                tooltip = "Maximum distance in metres used when looking for a safe civilian position around a location center.";
                control = "Edit";
                expression = "_this setVariable ['RHD_SpawnSearchRadius',_value,true]";
                defaultValue = "600";
                typeName = "NUMBER";
            };
            class RHD_SpawnMinDistance
            {
                property = "RHD_SpawnMinDistance";
                displayName = "Spawn Minimum Distance";
                tooltip = "Minimum distance from the location center before a candidate civilian spawn is accepted.";
                control = "Edit";
                expression = "_this setVariable ['RHD_SpawnMinDistance',_value,true]";
                defaultValue = "75";
                typeName = "NUMBER";
            };
            class RHD_CivilianPopulationEnabled
            {
                property = "RHD_CivilianPopulationEnabled";
                displayName = "Enable Civilian Population";
                tooltip = "Turns dynamic civilian population management on or off.";
                control = "Checkbox";
                expression = "_this setVariable ['RHD_CivilianPopulationEnabled',_value,true]";
                defaultValue = "true";
                typeName = "BOOL";
            };
            class RHD_CivilianBasePopulation
            {
                property = "RHD_CivilianBasePopulation";
                displayName = "Civilian Population at 1 Player";
                tooltip = "Target number of civilian AI with one active player.";
                control = "Edit";
                expression = "_this setVariable ['RHD_CivilianBasePopulation',_value,true]";
                defaultValue = "115";
                typeName = "NUMBER";
            };
            class RHD_CivilianReductionPerPlayer
            {
                property = "RHD_CivilianReductionPerPlayer";
                displayName = "Civilian Reduction per Additional Player";
                tooltip = "Subtract this many civilians from the target for each additional active player.";
                control = "Edit";
                expression = "_this setVariable ['RHD_CivilianReductionPerPlayer',_value,true]";
                defaultValue = "5";
                typeName = "NUMBER";
            };
            class RHD_CivilianMinimumPopulation
            {
                property = "RHD_CivilianMinimumPopulation";
                displayName = "Civilian Population Minimum";
                tooltip = "Lower bound for the dynamic civilian target.";
                control = "Edit";
                expression = "_this setVariable ['RHD_CivilianMinimumPopulation',_value,true]";
                defaultValue = "60";
                typeName = "NUMBER";
            };
            class RHD_CivilianMaximumPopulation
            {
                property = "RHD_CivilianMaximumPopulation";
                displayName = "Civilian Population Maximum";
                tooltip = "Upper bound for the dynamic civilian target.";
                control = "Edit";
                expression = "_this setVariable ['RHD_CivilianMaximumPopulation',_value,true]";
                defaultValue = "115";
                typeName = "NUMBER";
            };
            class RHD_CivilianPlayerCap
            {
                property = "RHD_CivilianPlayerCap";
                displayName = "Population Scaling Player Cap";
                tooltip = "Active player count used by the formula stops increasing beyond this number.";
                control = "Edit";
                expression = "_this setVariable ['RHD_CivilianPlayerCap',_value,true]";
                defaultValue = "12";
                typeName = "NUMBER";
            };
            class RHD_CivilianSpawnBatch
            {
                property = "RHD_CivilianSpawnBatch";
                displayName = "Civilian Spawn Batch";
                tooltip = "Maximum number of civilians created per population controller pass. Larger values fill the population faster but create more server work at once.";
                control = "Edit";
                expression = "_this setVariable ['RHD_CivilianSpawnBatch',_value,true]";
                defaultValue = "12";
                typeName = "NUMBER";
            };
            class RHD_CivilianGroupSize
            {
                property = "RHD_CivilianGroupSize";
                displayName = "Civilian Group Size";
                tooltip = "Maximum number of civilians grouped together when spawned near the same location.";
                control = "Edit";
                expression = "_this setVariable ['RHD_CivilianGroupSize',_value,true]";
                defaultValue = "4";
                typeName = "NUMBER";
            };
            class RHD_CivilianClasses
            {
                property = "RHD_CivilianClasses";
                displayName = "Civilian Unit Classes";
                tooltip = "Comma-separated civilian unit classes selected for dynamic population.";
                control = "Edit";
                expression = "_this setVariable ['RHD_CivilianClasses',_value,true]";
                defaultValue = "C_Man_1_F,C_Man_1_1_F,C_Man_1_2_F,C_Man_1_3_F,C_Man_1_4_F,C_Man_1_6_F,C_Man_2_F,C_Man_2_1_F,C_Man_2_2_F,C_Man_2_3_F,C_Man_2_4_F,C_Man_3_F";
                typeName = "STRING";
            };
            class RHD_CivilianBehaviour
            {
                property = "RHD_CivilianBehaviour";
                displayName = "Civilian Behaviour";
                tooltip = "Behaviour assigned to spawned civilians. CARELESS is the civilian-default, but SAFE can be useful for dense RP scenes.";
                control = "Edit";
                expression = "_this setVariable ['RHD_CivilianBehaviour',toUpper _value,true]";
                defaultValue = "CARELESS";
                typeName = "STRING";
            };
            class RHD_CivilianSkill
            {
                property = "RHD_CivilianSkill";
                displayName = "Civilian Skill";
                tooltip = "AI skill assigned to civilians. Keep this low for non-combat population.";
                control = "Edit";
                expression = "_this setVariable ['RHD_CivilianSkill',_value max 0 min 1,true]";
                defaultValue = "0.10";
                typeName = "NUMBER";
            };
            class RHD_CivilianSpawnRadius
            {
                property = "RHD_CivilianSpawnRadius";
                displayName = "Civilian Despawn Distance";
                tooltip = "Civilians farther than this distance from every active player are eligible for cleanup.";
                control = "Edit";
                expression = "_this setVariable ['RHD_CivilianSpawnRadius',_value,true]";
                defaultValue = "2500";
                typeName = "NUMBER";
            };
            class RHD_UpdateInterval
            {
                property = "RHD_UpdateInterval";
                displayName = "World Update Interval";
                tooltip = "Seconds between population cleanup/spawn passes.";
                control = "Edit";
                expression = "_this setVariable ['RHD_UpdateInterval',_value max 5,true]";
                defaultValue = "15";
                typeName = "NUMBER";
            };
            class RHD_AmbientVehiclesEnabled
            {
                property = "RHD_AmbientVehiclesEnabled";
                displayName = "Enable Ambient Civilian Vehicles";
                tooltip = "Adds a configurable number of lightweight civilian vehicles around active locations.";
                control = "Checkbox";
                expression = "_this setVariable ['RHD_AmbientVehiclesEnabled',_value,true]";
                defaultValue = "false";
                typeName = "BOOL";
            };
            class RHD_AmbientVehicleCount
            {
                property = "RHD_AmbientVehicleCount";
                displayName = "Ambient Vehicle Target";
                tooltip = "Target number of ambient civilian vehicles in the world controller pool.";
                control = "Edit";
                expression = "_this setVariable ['RHD_AmbientVehicleCount',_value max 0,true]";
                defaultValue = "12";
                typeName = "NUMBER";
            };
            class RHD_AmbientVehicleClasses
            {
                property = "RHD_AmbientVehicleClasses";
                displayName = "Ambient Vehicle Classes";
                tooltip = "Comma-separated civilian vehicle classes.";
                control = "Edit";
                expression = "_this setVariable ['RHD_AmbientVehicleClasses',_value,true]";
                defaultValue = "C_Offroad_01_F,C_Hatchback_01_F,C_SUV_01_F";
                typeName = "STRING";
            };
            class RHD_AmbientVehicleBatch
            {
                property = "RHD_AmbientVehicleBatch";
                displayName = "Ambient Vehicle Spawn Batch";
                tooltip = "Maximum number of ambient vehicles created per update pass.";
                control = "Edit";
                expression = "_this setVariable ['RHD_AmbientVehicleBatch',_value max 1,true]";
                defaultValue = "2";
                typeName = "NUMBER";
            };
            class RHD_DynamicSimulation
            {
                property = "RHD_DynamicSimulation";
                displayName = "Use Dynamic Simulation";
                tooltip = "Enables Arma dynamic simulation on RHD-managed ambient units and vehicles when supported.";
                control = "Checkbox";
                expression = "_this setVariable ['RHD_DynamicSimulation',_value,true]";
                defaultValue = "true";
                typeName = "BOOL";
            };
            class RHD_DynamicSimulationDistance
            {
                property = "RHD_DynamicSimulationDistance";
                displayName = "Dynamic Simulation Distance";
                tooltip = "Simulation distance applied to RHD-managed civilian AI.";
                control = "Edit";
                expression = "_this setVariable ['RHD_DynamicSimulationDistance',_value max 100,true]";
                defaultValue = "1500";
                typeName = "NUMBER";
            };
            class RHD_DebugMarkers
            {
                property = "RHD_DebugMarkers";
                displayName = "Show Generated Location Markers";
                tooltip = "Displays generated location centers and spawn points for mission debugging.";
                control = "Checkbox";
                expression = "_this setVariable ['RHD_DebugMarkers',_value,true]";
                defaultValue = "false";
                typeName = "BOOL";
            };
            class RHD_AntistasiCompatibility
            {
                property = "RHD_AntistasiCompatibility";
                displayName = "Antistasi Compatibility Mode";
                tooltip = "When Antistasi Ultimate is detected, RHD avoids replacing its native AI/world population systems and uses compatibility-safe behavior instead.";
                control = "Checkbox";
                expression = "_this setVariable ['RHD_AntistasiCompatibility',_value,true]";
                defaultValue = "true";
                typeName = "BOOL";
            };
            class RHD_AntistasiAIOverride
            {
                property = "RHD_AntistasiAIOverride";
                displayName = "Allow RHD to Override Antistasi AI";
                tooltip = "Advanced option. Disabled by default so RHD does not fight Antistasi Ultimate's AI manager.";
                control = "Checkbox";
                expression = "_this setVariable ['RHD_AntistasiAIOverride',_value,true]";
                defaultValue = "false";
                typeName = "BOOL";
            };
            class RHD_AntistasiEconomyOverride
            {
                property = "RHD_AntistasiEconomyOverride";
                displayName = "Allow RHD to Override Antistasi Economy";
                tooltip = "Advanced option. Disabled by default so RHD economy services remain compatible with Antistasi's economy.";
                control = "Checkbox";
                expression = "_this setVariable ['RHD_AntistasiEconomyOverride',_value,true]";
                defaultValue = "false";
                typeName = "BOOL";
            };
            class RHD_BlacklistLocations
            {
                property = "RHD_BlacklistLocations";
                displayName = "Location Blacklist";
                tooltip = "Comma-separated exact location display names to exclude from population generation.";
                control = "Edit";
                expression = "_this setVariable ['RHD_BlacklistLocations',_value,true]";
                defaultValue = "";
                typeName = "STRING";
            };
            class RHD_InitialPopulationFill
            {
                property = "RHD_InitialPopulationFill";
                displayName = "Fill Population Immediately";
                tooltip = "Performs an initial multi-unit population fill immediately after location generation instead of waiting for the first interval.";
                control = "Checkbox";
                expression = "_this setVariable ['RHD_InitialPopulationFill',_value,true]";
                defaultValue = "true";
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

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
            file = "\\rhd_lifecore\\functions";
            class moduleRP {};
            class initPlayer { postInit = 1; };
            class openMenu {};
            class setIdentity {};
            class addMoney {};
            class getMoney {};
        };
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
                tooltip = "Creates the RP identity profile and player RP menu.";
                control = "Checkbox";
                expression = "_this setVariable ['RHD_EnableIdentity',_value,true]";
                defaultValue = "true";
                typeName = "BOOL";
            };
            class RHD_EnableEconomy
            {
                property = "RHD_EnableEconomy";
                displayName = "Enable Basic Economy";
                tooltip = "Enables basic cash/bank variables and pay functions.";
                control = "Checkbox";
                expression = "_this setVariable ['RHD_EnableEconomy',_value,true]";
                defaultValue = "true";
                typeName = "BOOL";
            };
            class RHD_StartingCash
            {
                property = "RHD_StartingCash";
                displayName = "Starting Cash";
                tooltip = "Cash given when a UID has no existing RHD economy state.";
                control = "Edit";
                expression = "_this setVariable ['RHD_StartingCash',_value,true]";
                defaultValue = "500";
                typeName = "NUMBER";
            };
            class RHD_StartingBank
            {
                property = "RHD_StartingBank";
                displayName = "Starting Bank";
                tooltip = "Bank balance given when a UID has no existing RHD economy state.";
                control = "Edit";
                expression = "_this setVariable ['RHD_StartingBank',_value,true]";
                defaultValue = "1000";
                typeName = "NUMBER";
            };
            class RHD_Debug
            {
                property = "RHD_Debug";
                displayName = "Debug Logging";
                tooltip = "Writes RHD LifeCore initialization diagnostics to the RPT.";
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

class Cfg3DEN
{
    class Mission
    {
        class Scenario
        {
            class AttributeCategories
            {
                class RHD_LifeCoreInfo
                {
                    displayName = "RHD - LifeCore";
                    collapsed = 1;
                    class Attributes
                    {
                        class RHD_Info
                        {
                            displayName = "Framework";
                            tooltip = "Place the RHD LifeCore - RP Framework module in the mission to enable RP services.";
                            typeName = "STRING";
                            control = "Edit";
                            defaultValue = "'Place the RHD LifeCore - RP Framework module'";
                            expression = "";
                            condition = "1";
                        };
                    };
                };
            };
        };
    };
};

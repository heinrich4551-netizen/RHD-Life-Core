class CfgPatches
{
    class RHD_LifeCore_Expansion
    {
        name = "RHD - LifeCore Expansion";
        author = "LT. Toad";
        requiredVersion = 2.14;
        requiredAddons[] = {"RHD_LifeCore"};
    };
};

class CfgFunctions
{
    class RHD
    {
        class LifeCoreExpansion
        {
            file = "\\x\\rhd_lifecore\\addons\\rhd_lifecore_expansion\\functions";
            class inventoryAdd {};
            class inventoryGet {};
            class inventoryRemove {};
            class farmingHarvest {};
            class miningHarvest {};
            class craftItem {};
            class propertyBuyServer {};
            class propertyApply {};
            class dispatchCreate {};
            class dispatchList {};
            class warrantAdd {};
            class warrantHas {};
            class citationIssue {};
            class dutySet {};
            class phoneSend {};
            class phoneGet {};
            class emergencyCall {};
            class jobProgress {};
            class paycheck {};
            class systemInit { postInit = 1; };
        };
    };
};

class CfgRemoteExec
{
    class Functions
    {
        class RHD_fnc_inventoryAdd {allowedTargets = 1;};
        class RHD_fnc_farmingHarvest {allowedTargets = 2;};
        class RHD_fnc_miningHarvest {allowedTargets = 2;};
        class RHD_fnc_craftItem {allowedTargets = 2;};
        class RHD_fnc_propertyBuyServer {allowedTargets = 2;};
        class RHD_fnc_propertyApply {allowedTargets = 1; jip = 1;};
        class RHD_fnc_dispatchCreate {allowedTargets = 2;};
        class RHD_fnc_dispatchList {allowedTargets = 2;};
        class RHD_fnc_warrantAdd {allowedTargets = 2;};
        class RHD_fnc_citationIssue {allowedTargets = 2;};
        class RHD_fnc_dutySet {allowedTargets = 2;};
        class RHD_fnc_phoneSend {allowedTargets = 2;};
        class RHD_fnc_emergencyCall {allowedTargets = 2;};
        class RHD_fnc_paycheck {allowedTargets = 2;};
    };
};

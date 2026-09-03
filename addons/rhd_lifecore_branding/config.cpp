class CfgPatches
{
    class RHD_LifeCore_Branding
    {
        name = "RHD - LifeCore Branding";
        author = "LT. Toad";
        requiredVersion = 2.14;
        requiredAddons[] = {"RHD_LifeCore","RHD_LifeCore_Services","RHD_LifeCore_World"};
    };
};

class CfgFactionClasses
{
    class RHD_LifeCore
    {
        displayName = "RHD - LifeCore";
        priority = 1;
    };
};

class CfgVehicles
{
    class RHD_Module_RP
    {
        category = "RHD_LifeCore";
        icon = "\\x\\rhd_lifecore\\addons\\rhd_lifecore\\pictures\\RHD_LifeCore_Module.jpg";
        editorPreview = "\\x\\rhd_lifecore\\addons\\rhd_lifecore\\pictures\\RHD_LifeCore_Module.jpg";
    };
    class RHD_Module_RP_Services
    {
        category = "RHD_LifeCore";
        icon = "\\x\\rhd_lifecore\\addons\\rhd_lifecore\\pictures\\RHD_LifeCore_Module.jpg";
        editorPreview = "\\x\\rhd_lifecore\\addons\\rhd_lifecore\\pictures\\RHD_LifeCore_Module.jpg";
    };
    class RHD_Module_World
    {
        category = "RHD_LifeCore";
        icon = "\\x\\rhd_lifecore\\addons\\rhd_lifecore\\pictures\\RHD_LifeCore_Module.jpg";
        editorPreview = "\\x\\rhd_lifecore\\addons\\rhd_lifecore\\pictures\\RHD_LifeCore_Module.jpg";
    };
};

class CfgPatches
{
    class RHD_LifeCore_UI
    {
        name = "RHD - LifeCore UI";
        author = "LT. Toad";
        url = "https://github.com/heinrich4551-netizen/RHD-Life-Core";
        requiredVersion = 2.14;
        requiredAddons[] = {"RHD_LifeCore","RHD_LifeCore_Services"};
        units[] = {};
        weapons[] = {};
    };
};

class CfgFunctions
{
    class RHD
    {
        class LifeCoreUI
        {
            file = "\\x\\rhd_lifecore\\addons\\rhd_lifecore_ui\\functions";
            class openF5Menu {};
            class f5Action {};
            class registerF5Menu {postInit = 1;};
            class registerCurrentVehicle {};
        };
    };
};

class RscText;
class RscStructuredText;
class RscButton;

class RHD_F5MenuDialog
{
    idd = 8910;
    movingEnable = 0;
    enableSimulation = 1;
    onLoad = "uiNamespace setVariable ['RHD_F5MenuDialog',_this select 0]; [] call RHD_fnc_openF5Menu;";
    class controlsBackground
    {
        class Background:RscText
        {
            x=.14; y=.08; w=.72; h=.84;
            colorBackground[]={0,0,0,.91};
        };
        class Header:RscText
        {
            x=.14; y=.08; w=.72; h=.08;
            text="RHD - LifeCore | F5 SERVICES";
            sizeEx=.035;
            colorBackground[]={.12,.12,.12,.98};
        };
        class Hint:RscStructuredText
        {
            x=.19; y=.18; w=.62; h=.09;
            text="";
            size=.85;
        };
    };
    class controls
    {
        class Character:RscButton{x=.19;y=.29;w=.19;h=.075;text="Character Profile";action="['profile'] call RHD_fnc_f5Action;";};
        class Banking:RscButton{x=.405;y=.29;w=.19;h=.075;text="Banking / ATM";action="['bank'] call RHD_fnc_f5Action;";};
        class Shop:RscButton{x=.62;y=.29;w=.16;h=.075;text="Shop";action="['shop'] call RHD_fnc_f5Action;";};
        class Jobs:RscButton{x=.19;y=.39;w=.19;h=.075;text="Jobs";action="['jobs'] call RHD_fnc_f5Action;";};
        class Licenses:RscButton{x=.405;y=.39;w=.19;h=.075;text="Licenses";action="['licenses'] call RHD_fnc_f5Action;";};
        class Garage:RscButton{x=.62;y=.39;w=.16;h=.075;text="Garage";action="['garage'] call RHD_fnc_f5Action;";};
        class Registry:RscButton{x=.19;y=.49;w=.19;h=.075;text="Vehicle Registry";action="['registry'] call RHD_fnc_f5Action;";};
        class Register:RscButton{x=.405;y=.49;w=.19;h=.075;text="Register Current Vehicle";action="['register'] call RHD_fnc_f5Action;";};
        class Impound:RscButton{x=.62;y=.49;w=.16;h=.075;text="Impound";action="['impound'] call RHD_fnc_f5Action;";};
        class Close:RscButton{x=.59;y=.78;w=.19;h=.06;text="Close";action="closeDialog 0";};
    };
};

class CfgVehicles
{
    class RHD_Module_RP
    {
        class Attributes
        {
            class RHD_ATMClasses
            {
                defaultValue = "Land_Atm_01_F,Land_Atm_02_F";
                expression = "_this setVariable ['RHD_ATMClasses',_value,true]";
            };
            class RHD_ShopClasses
            {
                defaultValue = "Land_CashDesk_F";
                expression = "_this setVariable ['RHD_ShopClasses',_value,true]";
            };
            class RHD_F5MenuEnabled
            {
                property = "RHD_F5MenuEnabled";
                displayName = "Enable F5 Services Menu";
                tooltip = "Adds a single F5 menu for character, banking, jobs, licenses, garage, vehicle registry, vehicle registration and impound services.";
                control = "Checkbox";
                expression = "_this setVariable ['RHD_F5MenuEnabled',_value,true]";
                defaultValue = "true";
                typeName = "BOOL";
            };
        };
    };

    class RHD_Module_RP_Services
    {
        class Attributes
        {
            class RHD_GarageClasses
            {
                defaultValue = "Land_InfoStand_V2_F";
                expression = "_this setVariable ['RHD_GarageClasses',_value,true]";
            };
        };
    };
};

params [["_logic",objNull,[objNull]]];
if (isNull _logic) exitWith {false};

private _base = missionNamespace getVariable ["RHD_LifeCore_Config",createHashMap];
_base set ["storageAdapter",toLower (_logic getVariable ["RHD_StorageAdapter","profilenamespace"] )];
_base set ["extdbDatabase",_logic getVariable ["RHD_ExtDBDatabase","RHDLifeCore"]];
_base set ["extdbProtocol",toUpper (_logic getVariable ["RHD_ExtDBProtocol","SQL_RAW"] )];
_base set ["policeWhitelist",_logic getVariable ["RHD_PoliceWhitelist",""]];
_base set ["emsWhitelist",_logic getVariable ["RHD_EMSWhitelist",""]];
_base set ["adminWhitelist",(_logic getVariable ["RHD_AdminWhitelist",""]) splitString ","];
_base set ["garageClasses",_logic getVariable ["RHD_GarageClasses","Land_InfoStand_V2_F"]];
_base set ["impoundReleaseFee",(_logic getVariable ["RHD_ImpoundReleaseFee",2500]) max 0];
_base set ["antistasiAdapter",_logic getVariable ["RHD_EnableAntistasiAdapter",true]];
_base set ["antistasiEconomyPassthrough",_logic getVariable ["RHD_AntistasiEconomyPassthrough",true]];
_base set ["antistasiAIPassthrough",_logic getVariable ["RHD_AntistasiAIPassthrough",true]];
missionNamespace setVariable ["RHD_LifeCore_Config",_base,true];
true

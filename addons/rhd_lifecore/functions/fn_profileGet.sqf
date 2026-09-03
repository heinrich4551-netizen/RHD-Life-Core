if (!isServer) exitWith {[]};
params [["_uid", "", [""]]];
if (_uid isEqualTo "") exitWith {[]};
private _cfg = missionNamespace getVariable ["RHD_LifeCore_Config", createHashMap];
switch (toLower (_cfg getOrDefault ["storageAdapter", "profilenamespace"])) do {
    case "profilenamespace": {profileNamespace getVariable [format ["RHD_LifeCore_Profile_%1", _uid], []]};
    default {profileNamespace getVariable [format ["RHD_LifeCore_Profile_%1", _uid], []]};
}
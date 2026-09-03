if (!isServer) exitWith {false};
params [["_uid", "", [""]], ["_data", [], [[]]]];
if (_uid isEqualTo "") exitWith {false};
private _cfg = missionNamespace getVariable ["RHD_LifeCore_Config", createHashMap];
switch (toLower (_cfg getOrDefault ["storageAdapter", "profilenamespace"])) do {
    case "profilenamespace": {
        profileNamespace setVariable [format ["RHD_LifeCore_Profile_%1", _uid], _data];
        saveProfileNamespace;
        true
    };
    default {
        profileNamespace setVariable [format ["RHD_LifeCore_Profile_%1", _uid], _data];
        saveProfileNamespace;
        true
    };
}
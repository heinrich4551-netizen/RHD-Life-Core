if (!isServer) exitWith {false};
params [["_player", objNull, [objNull]]];
if (isNull _player || {!isPlayer _player}) exitWith {false};

private _uid = getPlayerUID _player;
if (_uid isEqualTo "") exitWith {false};
private _profiles = missionNamespace getVariable ["RHD_LifeCore_ServerProfiles", createHashMap];
private _profile = _profiles getOrDefault [_uid, createHashMap];
if (count _profile == 0) exitWith {false};

private _data = [
    _profile getOrDefault ["cash", 0],
    _profile getOrDefault ["bank", 0],
    _profile getOrDefault ["name", name _player],
    _profile getOrDefault ["job", "unemployed"],
    _profile getOrDefault ["licenses", []],
    _profile getOrDefault ["vehicles", []],
    _profile getOrDefault ["role", "civilian"]
];
profileNamespace setVariable [format ["RHD_LifeCore_Profile_%1", _uid], _data];
saveProfileNamespace;
true
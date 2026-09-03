if (!isServer) exitWith {false};
params [["_licenseId", "", [""]]];
private _owner = remoteExecutedOwner;
private _player = allPlayers select {owner _x == _owner} param [0, objNull];
if (isNull _player) exitWith {false};
private _cfg = missionNamespace getVariable ["RHD_LifeCore_Config", createHashMap];
if !(_cfg getOrDefault ["jobsEnabled", true]) exitWith {false};
private _licenses = [_cfg getOrDefault ["licenses", ""]] call RHD_fnc_parseList;
private _entry = _licenses select {toLower (_x param [0, ""]) isEqualTo toLower _licenseId} param [0, []];
if (count _entry < 3) exitWith {false};

private _uid = getPlayerUID _player;
private _profiles = missionNamespace getVariable ["RHD_LifeCore_ServerProfiles", createHashMap];
private _profile = _profiles getOrDefault [_uid, createHashMap];
if (count _profile == 0) exitWith {false};
private _owned = _profile getOrDefault ["licenses", []];
if (_licenseId in _owned) exitWith {false};
private _price = (parseNumber (_entry select 2)) max 0;
private _bank = _profile getOrDefault ["bank", 0];
if (_price > _bank) exitWith {false};

_profile set ["bank", _bank - _price];
_owned pushBackUnique _licenseId;
_profile set ["licenses", _owned];
_profiles set [_uid, _profile];
missionNamespace setVariable ["RHD_LifeCore_ServerProfiles", _profiles];
_player setVariable ["RHD_RP_Bank", _profile get "bank", true];
_player setVariable ["RHD_RP_Licenses", _owned, true];
[_player] call RHD_fnc_serverSaveProfile;
true
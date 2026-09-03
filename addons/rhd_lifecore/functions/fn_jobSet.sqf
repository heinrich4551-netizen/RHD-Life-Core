if (!isServer) exitWith {false};
params [["_jobId", "", [""]]];
private _owner = remoteExecutedOwner;
private _player = allPlayers select {owner _x == _owner} param [0, objNull];
if (isNull _player) exitWith {false};
private _cfg = missionNamespace getVariable ["RHD_LifeCore_Config", createHashMap];
if !(_cfg getOrDefault ["jobsEnabled", true]) exitWith {false};
private _jobs = [_cfg getOrDefault ["jobs", ""]] call RHD_fnc_parseList;
private _entry = _jobs select {toLower (_x param [0, ""]) isEqualTo toLower _jobId} param [0, []];
if (count _entry < 1) exitWith {false};

private _uid = getPlayerUID _player;
private _profiles = missionNamespace getVariable ["RHD_LifeCore_ServerProfiles", createHashMap];
private _profile = _profiles getOrDefault [_uid, createHashMap];
if (count _profile == 0) exitWith {false};
_profile set ["job", _entry param [0, "unemployed"]];
_player setVariable ["RHD_RP_Job", _profile get "job", true];
_profiles set [_uid, _profile];
missionNamespace setVariable ["RHD_LifeCore_ServerProfiles", _profiles];
[_player] call RHD_fnc_serverSaveProfile;
true
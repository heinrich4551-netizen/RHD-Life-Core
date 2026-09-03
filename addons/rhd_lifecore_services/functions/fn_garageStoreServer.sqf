if (!isServer) exitWith {false};
params [["_plate", "", [""]]];
if (_plate isEqualTo "") exitWith {false};

private _owner = remoteExecutedOwner;
private _player = allPlayers select {owner _x isEqualTo _owner} param [0, objNull];
if (isNull _player) exitWith {false};

private _vehicle = vehicle _player;
if (_vehicle isEqualTo _player || {driver _vehicle isNotEqualTo _player}) exitWith {false};
if ((getPlateNumber _vehicle) isNotEqualTo _plate) exitWith {false};

private _uid = getPlayerUID _player;
if (_uid isEqualTo "") exitWith {false};
if ((_vehicle getVariable ["RHD_VehicleOwnerUID", ""]) isNotEqualTo _uid) exitWith {false};

private _profiles = missionNamespace getVariable ["RHD_LifeCore_ServerProfiles", createHashMap];
private _profile = _profiles getOrDefault [_uid, createHashMap];
private _vehicles = _profile getOrDefault ["vehicles", []];
private _idx = _vehicles findIf {(_x param [1, ""]) isEqualTo _plate};
if (_idx < 0) exitWith {false};

private _entry = +(_vehicles select _idx);
private _state = _entry param [3, "out"];
if (_state isEqualTo "impounded" || {_state isEqualTo "garage"}) exitWith {false};

if (count _entry < 4) then {_entry set [3, "out"];};
if (count _entry < 5) then {_entry set [4, 1];};
if (count _entry < 6) then {_entry set [5, 0];};
_entry set [3, "garage"];
_entry set [4, fuel _vehicle];
_entry set [5, damage _vehicle];

_vehicles set [_idx, _entry];
_profile set ["vehicles", _vehicles];
_profiles set [_uid, _profile];
missionNamespace setVariable ["RHD_LifeCore_ServerProfiles", _profiles];
_player setVariable ["RHD_RP_Vehicles", _vehicles, true];

deleteVehicle _vehicle;
[_player] call RHD_fnc_serverSaveProfile;
true

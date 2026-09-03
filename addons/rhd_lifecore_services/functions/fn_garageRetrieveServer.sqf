if (!isServer) exitWith {false};
params [["_plate", "", [""]]];
if (_plate isEqualTo "") exitWith {false};

private _owner = remoteExecutedOwner;
private _player = allPlayers select {owner _x isEqualTo _owner} param [0, objNull];
if (isNull _player) exitWith {false};

private _uid = getPlayerUID _player;
if (_uid isEqualTo "") exitWith {false};

private _profiles = missionNamespace getVariable ["RHD_LifeCore_ServerProfiles", createHashMap];
private _profile = _profiles getOrDefault [_uid, createHashMap];
private _vehicles = _profile getOrDefault ["vehicles", []];
private _idx = _vehicles findIf {(_x param [1, ""]) isEqualTo _plate};
if (_idx < 0) exitWith {false};

private _entry = +(_vehicles select _idx);
private _class = _entry param [0, ""];
private _state = _entry param [3, "garage"];
if (_class isEqualTo "") exitWith {false};
if !(_state in ["garage", "stored"]) exitWith {false};

private _cfg = configFile >> "CfgVehicles" >> _class;
if (!isClass _cfg) exitWith {false};

private _spawnPos = getPosATL _player findEmptyPosition [6, 20, _class];
if (count _spawnPos == 0) exitWith {false};

private _vehicle = createVehicle [_class, _spawnPos, [], 0, "NONE"];
_vehicle setDir getDir _player;
_vehicle setPlateNumber _plate;
_vehicle setVariable ["RHD_VehicleOwnerUID", _uid, true];
_vehicle lock 0;

private _fuel = _entry param [4, 1];
private _damage = _entry param [5, 0];
_vehicle setFuel (_fuel max 0 min 1);
_vehicle setDamage (_damage max 0 min 1);

_entry set [3, "out"];
if (count _entry < 4) then {_entry set [3, "out"];};
if (count _entry < 5) then {_entry set [4, fuel _vehicle];};
if (count _entry < 6) then {_entry set [5, damage _vehicle];};
_vehicles set [_idx, _entry];
_profile set ["vehicles", _vehicles];
_profiles set [_uid, _profile];
missionNamespace setVariable ["RHD_LifeCore_ServerProfiles", _profiles];
_player setVariable ["RHD_RP_Vehicles", _vehicles, true];

[_player] call RHD_fnc_serverSaveProfile;
true

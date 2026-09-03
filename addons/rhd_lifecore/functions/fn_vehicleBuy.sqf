if (!isServer) exitWith {false};
params [["_class", "", [""]]];
private _owner = remoteExecutedOwner;
private _player = allPlayers select {owner _x == _owner} param [0, objNull];
if (isNull _player || {!isPlayer _player}) exitWith {false};
private _cfg = missionNamespace getVariable ["RHD_LifeCore_Config", createHashMap];
if !(_cfg getOrDefault ["vehiclesEnabled", true]) exitWith {false};
private _catalog = [_cfg getOrDefault ["vehicleCatalog", ""]] call RHD_fnc_parseList;
private _entry = _catalog select {(_x param [0, ""]) isEqualTo _class} param [0, []];
if (count _entry < 3) exitWith {false};

private _uid = getPlayerUID _player;
private _profiles = missionNamespace getVariable ["RHD_LifeCore_ServerProfiles", createHashMap];
private _profile = _profiles getOrDefault [_uid, createHashMap];
if (count _profile == 0) exitWith {false};
private _licenseList = _profile getOrDefault ["licenses", []];
if !(["driving"] call RHD_fnc_licenseHas) exitWith {false};
private _price = (parseNumber (_entry select 2)) max 0;
private _cash = _profile getOrDefault ["cash", 0];
if (_price > _cash) exitWith {false};

private _vehicle = createVehicle [_class, getPosATL _player, [], 8, "NONE"];
_vehicle setDir getDir _player;
_vehicle setVehicleLock "LOCKED";
_vehicle setVariable ["RHD_VehicleOwnerUID", _uid, true];
private _plate = format ["RHD-%1", floor random 9999];
_vehicle setPlateNumber _plate;

private _vehicles = _profile getOrDefault ["vehicles", []];
_vehicles pushBack [_class, _plate, _price];
_profile set ["cash", _cash - _price];
_profile set ["vehicles", _vehicles];
_profiles set [_uid, _profile];
missionNamespace setVariable ["RHD_LifeCore_ServerProfiles", _profiles];
_player setVariable ["RHD_RP_Cash", _profile get "cash", true];
_player setVariable ["RHD_RP_Vehicles", _vehicles, true];
[_player] call RHD_fnc_serverSaveProfile;
true
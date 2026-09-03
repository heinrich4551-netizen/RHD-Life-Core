if (!isServer) exitWith {false};
params [["_vehicle", objNull, [objNull]]];

private _owner = remoteExecutedOwner;
private _player = allPlayers select {owner _x isEqualTo _owner} param [0, objNull];
if (isNull _player || {isNull _vehicle} || {!alive _vehicle}) exitWith {false};
if (driver _vehicle isNotEqualTo _player) exitWith {false};

private _uid = getPlayerUID _player;
if (_uid isEqualTo "") exitWith {false};

private _profiles = missionNamespace getVariable ["RHD_LifeCore_ServerProfiles", createHashMap];
private _profile = _profiles getOrDefault [_uid, createHashMap];
if (count _profile == 0) exitWith {false};

private _vehicles = _profile getOrDefault ["vehicles", []];
private _plate = getPlateNumber _vehicle;

if (_plate isEqualTo "") then {
    private _attempts = 0;
    private _candidate = "";
    private _usedPlates = [];

    {
        private _owned = _x getOrDefault ["vehicles", []];
        {
            private _ownedPlate = _x param [1, ""];
            if !(_ownedPlate isEqualTo "") then {_usedPlates pushBackUnique _ownedPlate;};
        } forEach _owned;
    } forEach (values _profiles);

    while {_attempts < 100 && {_candidate isEqualTo ""}} do {
        private _test = format ["RHD-%1", 1000 + floor random 9000];
        if !(_test in _usedPlates) then {_candidate = _test;};
        _attempts = _attempts + 1;
    };

    if (_candidate isEqualTo "") exitWith {false};
    _plate = _candidate;
    _vehicle setPlateNumber _plate;
};

private _duplicate = _vehicles findIf {(_x param [1, ""]) isEqualTo _plate};
if (_duplicate >= 0) exitWith {false};

_vehicle setVariable ["RHD_VehicleOwnerUID", _uid, true];

private _price = 0;
private _record = [typeOf _vehicle, _plate, _price, "out", fuel _vehicle, damage _vehicle];
_vehicles pushBack _record;

_profile set ["vehicles", _vehicles];
_profiles set [_uid, _profile];
missionNamespace setVariable ["RHD_LifeCore_ServerProfiles", _profiles];
_player setVariable ["RHD_RP_Vehicles", _vehicles, true];

[_player] call RHD_fnc_serverSaveProfile;
true

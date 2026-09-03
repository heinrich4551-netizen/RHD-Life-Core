if (!isServer) exitWith {false};
private _cfg = missionNamespace getVariable ["RHD_LifeCore_WorldConfig",createHashMap];
private _players = allPlayers select {isPlayer _x};
private _civs = missionNamespace getVariable ["RHD_LifeCore_Civilians",[]];
private _radius = _cfg getOrDefault ["civilianDespawnRadius",2500];

private _newCivs = [];
{
    private _u = _x;
    if (!isNull _u && {alive _u}) then {
        private _near = if (_players isEqualTo []) then {-1} else {_players findIf {alive _x && {_x distance2D _u <= _radius}}};
        if (_near >= 0) then {_newCivs pushBack _u} else {deleteVehicle _u;};
    };
} forEach _civs;
missionNamespace setVariable ["RHD_LifeCore_Civilians",_newCivs,true];

private _vehicles = missionNamespace getVariable ["RHD_LifeCore_AmbientVehicles",[]];
private _keptVehicles = [];
{
    private _v = _x;
    if (!isNull _v) then {
        private _near = if (_players isEqualTo []) then {-1} else {_players findIf {alive _x && {_x distance2D _v <= _radius}}};
        if (_near >= 0) then {_keptVehicles pushBack _v} else {deleteVehicle _v;};
    };
} forEach _vehicles;
missionNamespace setVariable ["RHD_LifeCore_AmbientVehicles",_keptVehicles,true];
true

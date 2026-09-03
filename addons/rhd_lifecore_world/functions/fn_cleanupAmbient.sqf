if (!isServer) exitWith {false};
private _cfg = missionNamespace getVariable ["RHD_LifeCore_WorldConfig",createHashMap];
private _players = allPlayers select {isPlayer _x};
private _civs = missionNamespace getVariable ["RHD_LifeCore_Civilians",[]];
_civs = _civs select {
    private _u = _x;
    if (isNull _u || {!alive _u}) exitWith {false};
    if (_players isEqualTo []) exitWith {true};
    (_players findIf {alive _x && {_x distance2D _u <= (_cfg getOrDefault ["civilianDespawnRadius",2500])}}) > -1
};
{if (isNull _x || {!alive _x}) then {deleteVehicle _x;};} forEach (missionNamespace getVariable ["RHD_LifeCore_Civilians",[]]);
missionNamespace setVariable ["RHD_LifeCore_Civilians",_civs,true];

private _vehicles = missionNamespace getVariable ["RHD_LifeCore_AmbientVehicles",[]];
private _keptVehicles = [];
{
    if (!isNull _x) then {
        if (_players findIf {_x distance2D _player <= (_cfg getOrDefault ["civilianDespawnRadius",2500])} >= 0) then {_keptVehicles pushBack _x} else {deleteVehicle _x;};
    };
} forEach _vehicles;
missionNamespace setVariable ["RHD_LifeCore_AmbientVehicles",_keptVehicles,true];
true

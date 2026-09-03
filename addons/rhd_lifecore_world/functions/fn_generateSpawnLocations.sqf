if (!isServer) exitWith {[]};
private _cfg = missionNamespace getVariable ["RHD_LifeCore_WorldConfig",createHashMap];
private _locations = missionNamespace getVariable ["RHD_LifeCore_Locations",[]];
private _perLocation = (_cfg getOrDefault ["spawnPointsPerLocation",12]) max 0;
private _minDistance = (_cfg getOrDefault ["spawnMinDistance",75]) max 0;
private _maxDistance = (_cfg getOrDefault ["spawnSearchRadius",600]) max _minDistance;
private _spawns = [];

{
    private _location = _x;
    private _center = _location#2;
    for "_i" from 1 to _perLocation do {
        private _pos = [_center,_minDistance,_maxDistance] call RHD_fnc_safeSpawnPos;
        if (_pos isNotEqualTo []) then {
            _spawns pushBack [_pos,_location#0,_location#1];
            if (_cfg getOrDefault ["debugMarkers",false]) then {
                private _m = createMarker [format ["RHD_LC_SPAWN_%1_%2",_forEachIndex,_i],_pos];
                _m setMarkerType "mil_dot";
                _m setMarkerAlpha 0.35;
            };
        };
    };
} forEach _locations;

missionNamespace setVariable ["RHD_LifeCore_SpawnLocations",_spawns,true];
if ((_cfg getOrDefault ["debugMarkers",false])) then {diag_log format ["[RHD-LifeCore] generated %1 civilian spawn locations from %2 named locations",count _spawns,count _locations];};
_spawns

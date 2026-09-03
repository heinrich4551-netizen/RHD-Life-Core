if (!isServer) exitWith {[]};
private _cfg = missionNamespace getVariable ["RHD_LifeCore_WorldConfig",createHashMap];
private _rawTypes = _cfg getOrDefault ["locationTypes","NameCityCapital,NameCity,NameVillage,NameLocal"];
private _types = _rawTypes splitString ",";
_types = _types apply {toLower _x};
_types = _types select {_x != ""};
_types = _types apply {switch (_x) do {case "namecitycapital": {"NameCityCapital"}; case "namecity": {"NameCity"}; case "namevillage": {"NameVillage"}; case "namelocal": {"NameLocal"}; case "name": {"Name"}; default {_x};}};

private _worldCenter = [worldSize / 2, worldSize / 2, 0];
private _searchRadius = worldSize * 1.5;
private _blacklist = (_cfg getOrDefault ["blacklistLocations",""]) splitString ",";
_blacklist = _blacklist apply {toLower (trim _x)};
private _spacing = (_cfg getOrDefault ["locationMinSpacing",250]) max 0;
private _max = (_cfg getOrDefault ["locationMax",0]) max 0;
private _locations = [];

if !(_cfg getOrDefault ["generateLocations",true]) exitWith {
    missionNamespace setVariable ["RHD_LifeCore_Locations",[],true];
    []
};

{
    private _name = text _x;
    private _nameLower = toLower _name;
    private _pos = position _x;
    if !(_nameLower in _blacklist) then {
        if !((surfaceIsWater _pos) || {(_pos distance2D _worldCenter) > _searchRadius}) then {
            private _duplicate = _locations findIf {(_x#2) distance2D _pos < _spacing};
            if (_duplicate isEqualTo -1) then {
                _locations pushBack [_name, type _x, ASLToATL (ATLToASL _pos)];
            };
        };
    };
    if (_max > 0 && {count _locations >= _max}) exitWith {};
} forEach (nearestLocations [_worldCenter,_types,_searchRadius]);

missionNamespace setVariable ["RHD_LifeCore_Locations",_locations,true];

private _debug = _cfg getOrDefault ["debugMarkers",false];
if (_debug) then {
    {deleteMarker _x;} forEach (allMapMarkers select {(_x find "RHD_LC_LOC_") isEqualTo 0 || {(_x find "RHD_LC_SPAWN_") isEqualTo 0}});
    {
        private _m = createMarker [format ["RHD_LC_LOC_%1",_forEachIndex],_x#2];
        _m setMarkerType "hd_dot";
        _m setMarkerText (_x#0);
    } forEach _locations;
};

if (_cfg getOrDefault ["debugMarkers",false]) then {
    diag_log format ["[RHD-LifeCore] generated %1 world locations on %2",count _locations,worldName];
};

_locations

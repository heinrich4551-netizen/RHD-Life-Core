if (!isServer) exitWith {false};
params [['_player',objNull,[objNull]]];
if (isNull _player || {!isPlayer _player}) exitWith {false};
private _uid = getPlayerUID _player;
private _cfg = missionNamespace getVariable ['RHD_LifeCore_Config',createHashMap];
private _fallback = [_player] call RHD_fnc_serverLoadProfile;
if (!(missionNamespace getVariable ['RHD_LifeCore_EXTDB_Enabled',false])) exitWith {_fallback};
private _safeUID = toArray _uid select {_x in (toArray '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-')};
private _uidSafe = toString _safeUID;
private _sql = format ["SELECT uid,name,cash,bank,job,role,licenses_text,vehicles_text,inventory_text FROM profiles WHERE uid='%1' LIMIT 1",_uidSafe];
private _raw = [_sql] call RHD_fnc_extdbQuery;
if (_raw == '') exitWith {_fallback};
private _rows = [];
if ((count _raw) > 1) then { _rows = parseSimpleArray _raw; };
if (_rows isEqualType [] && {count _rows > 0}) then {
    private _row = _rows select 0;
    if (_row isEqualType [] && {count _row >= 9}) then {
        private _profiles = missionNamespace getVariable ['RHD_LifeCore_ServerProfiles',createHashMap];
        private _profile = createHashMapFromArray [['cash',parseNumber (_row select 2)],['bank',parseNumber (_row select 3)],['name',_row select 1],['job',_row select 4],['role',_row select 5],['licenses',parseSimpleArray (_row select 6)],['vehicles',parseSimpleArray (_row select 7)],['inventory',parseSimpleArray (_row select 8)]];
        _profiles set [_uid,_profile];
        missionNamespace setVariable ['RHD_LifeCore_ServerProfiles',_profiles];
        { _x params ['_k','_v']; _player setVariable [_k,_v,true]; } forEach [['RHD_RP_Name',_profile get 'name'],['RHD_RP_Cash',_profile get 'cash'],['RHD_RP_Bank',_profile get 'bank'],['RHD_RP_Job',_profile get 'job'],['RHD_RP_Role',_profile get 'role'],['RHD_RP_Licenses',_profile get 'licenses'],['RHD_RP_Vehicles',_profile get 'vehicles']];
        true
    } else {_fallback};
} else {_fallback};
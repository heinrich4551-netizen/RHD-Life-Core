if (!isServer) exitWith {false};
params [["_player", objNull, [objNull]]];
if (isNull _player || {!isPlayer _player}) exitWith {false};
private _cfg=missionNamespace getVariable ["RHD_LifeCore_Config",createHashMap];
if ((_cfg getOrDefault ["storageAdapter","profilenamespace"]) isEqualTo "extdb3" && {missionNamespace getVariable ["RHD_LifeCore_EXTDB_Enabled",false]}) exitWith {[_player] call RHD_fnc_extdbSaveProfile};
private _uid=getPlayerUID _player; if (_uid isEqualTo "") exitWith {false};
private _profiles=missionNamespace getVariable ["RHD_LifeCore_ServerProfiles",createHashMap]; private _profile=_profiles getOrDefault [_uid,createHashMap]; if (count _profile==0) exitWith {false};
[_uid,[_profile getOrDefault ["cash",0],_profile getOrDefault ["bank",0],_profile getOrDefault ["name",name _player],_profile getOrDefault ["job","unemployed"],_profile getOrDefault ["licenses",[]],_profile getOrDefault ["vehicles",[]],_profile getOrDefault ["role","civilian"],_profile getOrDefault ["inventory",[]]]] call RHD_fnc_profileSet
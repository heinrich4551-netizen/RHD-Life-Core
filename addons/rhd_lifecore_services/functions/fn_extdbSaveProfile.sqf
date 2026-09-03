if (!isServer) exitWith {false};
params [['_player',objNull,[objNull]]];
if (isNull _player || {!isPlayer _player}) exitWith {false};
if (!(missionNamespace getVariable ['RHD_LifeCore_EXTDB_Enabled',false])) exitWith {[_player] call RHD_fnc_serverSaveProfile};
private _uid = getPlayerUID _player;
private _profiles = missionNamespace getVariable ['RHD_LifeCore_ServerProfiles',createHashMap];
private _p = _profiles getOrDefault [_uid,createHashMap];
if (count _p == 0) exitWith {false};
private _esc = {str _this replaceAll ["'","\\'"]};
private _name = [_p getOrDefault ['name',name _player]] call _esc;
private _job = [_p getOrDefault ['job','unemployed']] call _esc;
private _role = [_p getOrDefault ['role','civilian']] call _esc;
private _licenses = [str (_p getOrDefault ['licenses',[]])] call _esc;
private _vehicles = [str (_p getOrDefault ['vehicles',[]])] call _esc;
private _inventory = [str (_p getOrDefault ['inventory',[]])] call _esc;
private _sql = format ["INSERT INTO profiles(uid,name,cash,bank,job,role,licenses_text,vehicles_text,inventory_text) VALUES('%1','%2',%3,%4,'%5','%6','%7','%8','%9') ON DUPLICATE KEY UPDATE name=VALUES(name),cash=VALUES(cash),bank=VALUES(bank),job=VALUES(job),role=VALUES(role),licenses_text=VALUES(licenses_text),vehicles_text=VALUES(vehicles_text),inventory_text=VALUES(inventory_text)",_uid,_name,_p getOrDefault ['cash',0],_p getOrDefault ['bank',0],_job,_role,_licenses,_vehicles,_inventory];
[_sql] call RHD_fnc_extdbQuery;
true
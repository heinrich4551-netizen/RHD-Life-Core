if (!isServer) exitWith {''};
params [['_sql','',['']]];
private _id = missionNamespace getVariable ['RHD_LifeCore_EXTDB_ID',0];
if (_id <= 0) exitWith {''};
private _res = format ['0:%1:%2',_id,_sql] callExtension 'extDB3';
_res
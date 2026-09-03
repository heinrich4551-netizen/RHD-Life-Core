if (!isServer) exitWith {false};
private _cfg = missionNamespace getVariable ['RHD_LifeCore_Config',createHashMap];
private _adapter = _cfg getOrDefault ['storageAdapter','profilenamespace'];
missionNamespace setVariable ['RHD_LifeCore_EXTDB_Enabled',false,true];
if (_adapter != 'extdb3') exitWith {false};
private _db = _cfg getOrDefault ['extdbDatabase','RHDLifeCore'];
private _protocol = _cfg getOrDefault ['extdbProtocol','SQL_RAW'];
private _dbRes = 'extDB3' callExtension format ['9:ADD_DATABASE:%1',_db];
private _protoRes = 'extDB3' callExtension format ['9:ADD_DATABASE_PROTOCOL:%1:%2:TEXT2',_db,_protocol];
private _id = parseNumber _protoRes;
if (_id <= 0) exitWith {diag_log format ['[RHD LifeCore] EXTDB3 unavailable: %1 / %2',_dbRes,_protoRes];false};
missionNamespace setVariable ['RHD_LifeCore_EXTDB_ID',_id,true];
missionNamespace setVariable ['RHD_LifeCore_EXTDB_Enabled',true,true];
diag_log format ['[RHD LifeCore] EXTDB3 enabled. Database=%1 Protocol=%2 ID=%3',_db,_protocol,_id];
true
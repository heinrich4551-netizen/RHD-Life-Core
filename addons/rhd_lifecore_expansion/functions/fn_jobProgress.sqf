params [["_delta",1,[0]]];
if (_delta <= 0) exitWith {false};
private _job = player getVariable ["RHD_RP_Job","unemployed"];
private _xp = player getVariable ["RHD_RP_JobXP",createHashMap];
private _value = _xp getOrDefault [_job,0];
_xp set [_job,_value+_delta];
player setVariable ["RHD_RP_JobXP",_xp,true];
true

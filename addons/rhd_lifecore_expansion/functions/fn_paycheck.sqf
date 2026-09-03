params [["_unit",objNull,[objNull]]];
if (isNull _unit || {!isPlayer _unit}) exitWith {false};
if (!isServer) exitWith {[_unit] remoteExecCall ["RHD_fnc_paycheck",2]; true};
private _job = _unit getVariable ["RHD_RP_Job","unemployed"];
private _cfg = missionNamespace getVariable ["RHD_LifeCore_Config",createHashMap];
private _jobs = _cfg getOrDefault ["jobs",[]];
private _def = _jobs select {(_x param [0,""]) isEqualTo _job};
if (_def isEqualTo []) exitWith {false};
private _pay = (_def select 0) param [2,0];
if (_pay <= 0) exitWith {false};
private _bank = _unit getVariable ["RHD_RP_Bank",0];
_unit setVariable ["RHD_RP_Bank",_bank+_pay,true];
true

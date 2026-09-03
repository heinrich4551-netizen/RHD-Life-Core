params [['_action','',['']],['_value','',['']]];
private _amount = 0; private _target='';
if (_action == 'transfer') then {private _parts=_value splitString '|'; _amount=parseNumber (_parts param [0,'0']); _target=_parts param [1,''];} else {_amount=parseNumber _value;};
if (_amount <= 0) exitWith {hint 'Enter a positive amount.';false};
private _cfg=missionNamespace getVariable ['RHD_LifeCore_Config',createHashMap];
if !(_cfg getOrDefault ['economyEnabled',true]) exitWith {hint 'Banking is disabled.';false};
[_action,_amount,_target] remoteExecCall ['RHD_fnc_serverEconomy',2];
[] spawn {uiSleep 0.4; if (!isNull (uiNamespace getVariable ['RHD_BankDialog',displayNull])) then {[] call RHD_fnc_bankDialog;};};
true
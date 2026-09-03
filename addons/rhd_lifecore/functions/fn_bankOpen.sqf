if (!hasInterface) exitWith {false};
private _cfg = missionNamespace getVariable ["RHD_LifeCore_Config", createHashMap];
if !(_cfg getOrDefault ["bankingEnabled", true]) exitWith {false};

private _nearest = [player, _cfg getOrDefault ["atmClasses", ""]] call RHD_fnc_atmFind;
if (isNull _nearest) exitWith {hint "No RHD ATM nearby."; false};

private _cash = player getVariable ["RHD_RP_Cash", 0];
private _bank = player getVariable ["RHD_RP_Bank", 0];
hint parseText format [
    "<t size='1.3' color='#C9A227'>RHD BANKING</t><br/><br/>Cash: $%1<br/>Bank: $%2<br/><br/><t color='#AFAFAF'>ATM quick actions: use the interact options for $100 deposit/withdraw.</t>",
    _cash, _bank
];
true
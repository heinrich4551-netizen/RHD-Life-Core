disableSerialization;
if (!hasInterface) exitWith {false};
if !(missionNamespace getVariable ["RHD_LifeCore_Enabled", false]) exitWith {
    hint "RHD LifeCore is not active in this mission.";
    false
};

if (dialog) then {closeDialog 0;};
if !(createDialog "RHD_F5MenuDialog") exitWith {false};

private _display = uiNamespace getVariable ["RHD_F5MenuDialog", displayNull];
if (isNull _display) exitWith {false};

private _cfg = missionNamespace getVariable ["RHD_LifeCore_Config", createHashMap];
private _cash = player getVariable ["RHD_RP_Cash", 0];
private _bank = player getVariable ["RHD_RP_Bank", 0];
private _job = player getVariable ["RHD_RP_Job", _cfg getOrDefault ["defaultJob", "unemployed"]];
private _role = player getVariable ["RHD_RP_Role", "civilian"];

(_display displayCtrl 8912) ctrlSetStructuredText parseText format [
    "<t align='center'>Cash: <t color='#C9A227'>$%1</t> &nbsp;&nbsp; Bank: <t color='#C9A227'>$%2</t><br/>Job: %3 &nbsp;&nbsp; Role: %4</t>",
    _cash,
    _bank,
    _job,
    _role
];
true

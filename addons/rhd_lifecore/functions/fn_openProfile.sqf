if (!hasInterface) exitWith {false};
if (dialog) then {closeDialog 0};
if !(createDialog "RHD_ProfileDialog") exitWith {false};
private _display = uiNamespace getVariable ["RHD_ProfileDialog", displayNull];
if (isNull _display) exitWith {false};

private _name = player getVariable ["RHD_RP_Name", profileName];
private _job = player getVariable ["RHD_RP_Job", "unemployed"];
private _role = player getVariable ["RHD_RP_Role", "civilian"];
private _cash = player getVariable ["RHD_RP_Cash", 0];
private _bank = player getVariable ["RHD_RP_Bank", 0];
private _licenses = player getVariable ["RHD_RP_Licenses", []];
private _vehicles = player getVariable ["RHD_RP_Vehicles", []];

private _licenseText = if (count _licenses == 0) then {"None"} else {_licenses joinString ", "};
private _text = format [
    "<t size='1.15'><t align='center'>%1</t></t><br/><br/>\n<t color='#C9A227'>Job:</t> %2<br/>\n<t color='#C9A227'>Role:</t> %3<br/>\n<t color='#C9A227'>Cash:</t> $%4<br/>\n<t color='#C9A227'>Bank:</t> $%5<br/>\n<t color='#C9A227'>Licenses:</t> %6<br/>\n<t color='#C9A227'>Owned Vehicles:</t> %7",
    _name, _job, _role, _cash, _bank, _licenseText, count _vehicles
];
(_display displayCtrl 8841) ctrlSetStructuredText parseText _text;
true
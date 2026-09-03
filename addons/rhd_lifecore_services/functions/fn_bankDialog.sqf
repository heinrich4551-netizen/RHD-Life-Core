params [['_action','open',['']]];
if (!hasInterface) exitWith {false};
if (_action == 'open') then {createDialog 'RHD_BankDialog'; private _d=uiNamespace getVariable ['RHD_BankDialog',displayNull]; if (!isNull _d) then {(_d displayCtrl 8851) ctrlSetStructuredText parseText format ['<t size="1.1">Cash: $%1<br/>Bank: $%2</t>',player getVariable ['RHD_RP_Cash',0],player getVariable ['RHD_RP_Bank',0]];};};
true
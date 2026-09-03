if (!hasInterface || {isNull player}) exitWith {};

private _cash = player getVariable ["RHD_RP_Cash", 0];
private _bank = player getVariable ["RHD_RP_Bank", 0];
private _name = player getVariable ["RHD_RP_Name", profileName];
private _uid = player getVariable ["RHD_RP_UID", getPlayerUID player];

hint parseText format [
    "<t size='1.4' color='#C9A227'>RHD - LifeCore</t><br/><br/><t align='left'>Character: %1<br/>UID: %2<br/><br/>Cash: $%3<br/>Bank: $%4<br/><br/><t color='#AFAFAF'>RP framework active.</t>",
    _name,
    _uid,
    _cash,
    _bank
];

true
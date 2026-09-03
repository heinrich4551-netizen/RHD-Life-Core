if (!hasInterface) exitWith {false};
private _cfg = missionNamespace getVariable ["RHD_LifeCore_Config", createHashMap];
if !(_cfg getOrDefault ["shopsEnabled", true]) exitWith {false};
private _items = [_cfg getOrDefault ["shopCatalog", ""]] call RHD_fnc_parseList;
private _lines = [];
{
    if (count _x >= 4) then {
        _lines pushBack format ["%1  |  buy $%2  |  sell $%3", _x select 1, _x select 2, _x select 3];
    };
} forEach _items;
hint parseText format ["<t size='1.3' color='#C9A227'>RHD SHOP</t><br/><br/>%1<br/><br/><t color='#AFAFAF'>Transactions are server validated. Use RHD_fnc_shopBuy with item id and quantity from UI integrations.</t>", _lines joinString "<br/>"];
true
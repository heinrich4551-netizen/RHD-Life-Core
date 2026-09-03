params [['_index',-1,[0]]];
if (!hasInterface) exitWith {false};
if (_index >= 0) exitWith {[_index] remoteExecCall ['RHD_fnc_shopBuy',2];true};
createDialog 'RHD_ShopDialog'; private _d=uiNamespace getVariable ['RHD_ShopDialog',displayNull]; if (isNull _d) exitWith {false};
private _list=_d displayCtrl 8861; lbClear _list; private _cfg=missionNamespace getVariable ['RHD_LifeCore_Config',createHashMap];
{ _x params ['_id','_display','_buy']; _list lbAdd format ['%1  |  $%2',_display,_buy]; _list lbSetData [(lbSize _list)-1,_id]; } forEach ([_cfg getOrDefault ['shopCatalog','']] call RHD_fnc_parseList); true
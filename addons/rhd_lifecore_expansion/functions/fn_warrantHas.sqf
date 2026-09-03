params [["_uid","",[""]]];
private _list = missionNamespace getVariable ["RHD_RP_Warrants",[]];
_list findIf {(_x param [0,""]) isEqualTo _uid} >= 0

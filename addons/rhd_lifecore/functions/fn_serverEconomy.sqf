if (!isServer) exitWith {false};
private _cfg=missionNamespace getVariable ["RHD_LifeCore_Config",createHashMap];
if (missionNamespace getVariable ["RHD_LifeCore_EconomyPassthrough",false]) exitWith {false};
params [["_action","",[""]],["_amount",0,[0]],["_targetUID","",[""]]];
private _owner=remoteExecutedOwner;
private _player=if (_owner>0) then {allPlayers select {owner _x==_owner} param [0,objNull]} else {objNull};
if (isNull _player || {!isPlayer _player}) exitWith {false};
private _uid=getPlayerUID _player;
private _profiles=missionNamespace getVariable ["RHD_LifeCore_ServerProfiles",createHashMap];
private _profile=_profiles getOrDefault [_uid,createHashMap];
if (count _profile==0) exitWith {false};
_amount=round _amount;
if (_amount<=0) exitWith {false};
private _changed=false;
switch (toLower _action) do {
    case "addcash": {_profile set ["cash",(_profile getOrDefault ["cash",0])+_amount]; _changed=true;};
    case "addbank": {_profile set ["bank",(_profile getOrDefault ["bank",0])+_amount]; _changed=true;};
    case "removecash": {private _cash=_profile getOrDefault ["cash",0]; if (_amount<=_cash) then {_profile set ["cash",_cash-_amount];_changed=true;};};
    case "deposit": {private _cash=_profile getOrDefault ["cash",0]; if (_amount<=_cash) then {_profile set ["cash",_cash-_amount];_profile set ["bank",(_profile getOrDefault ["bank",0])+_amount];_changed=true;};};
    case "withdraw": {private _bank=_profile getOrDefault ["bank",0]; if (_amount<=_bank) then {_profile set ["bank",_bank-_amount];_profile set ["cash",(_profile getOrDefault ["cash",0])+_amount];_changed=true;};};
    case "transfer": {
        if (_targetUID isEqualTo "" || {_targetUID isEqualTo _uid}) exitWith {false};
        private _targetPlayer=allPlayers select {getPlayerUID _x==_targetUID} param [0,objNull];
        if (isNull _targetPlayer) exitWith {false};
        private _bank=_profile getOrDefault ["bank",0];
        private _targetProfile=_profiles getOrDefault [_targetUID,createHashMap];
        if (count _targetProfile>0 && {_amount<=_bank}) then {
            _profile set ["bank",_bank-_amount];
            _targetProfile set ["bank",(_targetProfile getOrDefault ["bank",0])+_amount];
            _profiles set [_targetUID,_targetProfile];
            _targetPlayer setVariable ["RHD_RP_Bank",_targetProfile getOrDefault ["bank",0],true];
            _changed=true;
            [_targetPlayer] call RHD_fnc_serverSaveProfile;
        };
    };
};
if (_changed) then {
    _profiles set [_uid,_profile];
    missionNamespace setVariable ["RHD_LifeCore_ServerProfiles",_profiles];
    _player setVariable ["RHD_RP_Cash",_profile getOrDefault ["cash",0],true];
    _player setVariable ["RHD_RP_Bank",_profile getOrDefault ["bank",0],true];
    [_player] call RHD_fnc_serverSaveProfile;
};
_changed

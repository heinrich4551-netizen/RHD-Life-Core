if (!isServer) exitWith {false};
[] spawn {
    waitUntil {time > 1};
    private _cfg = missionNamespace getVariable ["RHD_LifeCore_Config",createHashMap];
    if !(_cfg getOrDefault ["civilianPopulationEnabled",true]) exitWith {};
    if (missionNamespace getVariable ["RHD_AntistasiNoOverrideAI",false]) exitWith {};
    private _units = [];
    missionNamespace setVariable ["RHD_LifeCore_Civilians",_units,true];
    while {true} do {
        uiSleep (_cfg getOrDefault ["civilianUpdateInterval",30]);
        if (missionNamespace getVariable ["RHD_AntistasiNoOverrideAI",false]) exitWith {};
        private _players = allPlayers select {isPlayer _x && {alive _x}};
        private _count = count _players;
        private _cap = _cfg getOrDefault ["civilianActivePlayerCap",12];
        private _effective = (_count max 1) min _cap;
        private _target = ((_cfg getOrDefault ["civilianBasePopulation",115]) - ((_effective - 1) * (_cfg getOrDefault ["civilianReductionPerPlayer",5]))) max (_cfg getOrDefault ["civilianMinimumPopulation",60]);
        _target = _target min (_cfg getOrDefault ["civilianMaximumPopulation",115]);
        _units = _units select {!isNull _x && {alive _x}};
        {if (!alive _x || {_x distance2D (selectRandom _players) > (_cfg getOrDefault ["civilianDespawnRadius",2500])}) then {deleteVehicle _x;};} forEach _units;
        _units = _units select {!isNull _x};
        if ((count _units) < _target && {_players isNotEqualTo []}) then {
            private _class = selectRandom ["C_Man_1_F","C_Man_1_1_F","C_Man_1_2_F","C_Man_1_3_F","C_Man_1_4_F","C_Man_1_6_F","C_Man_2_F","C_Man_2_1_F","C_Man_2_2_F","C_Man_2_3_F","C_Man_2_4_F","C_Man_3_F"];
            private _anchor = selectRandom _players;
            private _pos = _anchor getPos [250 + random (_cfg getOrDefault ["civilianSpawnRadius",1500]), random 360];
            private _grp = createGroup civilian;
            private _u = _grp createUnit [_class,_pos,[],5,"NONE"];
            _u setBehaviour "CARELESS";
            _u setCombatBehaviour "CARELESS";
            _u setSkill 0.1;
            _u setVariable ["RHD_LifeCore_Civilian",true,true];
            _units pushBack _u;
        };
        missionNamespace setVariable ["RHD_LifeCore_Civilians",_units,true];
    };
};
true

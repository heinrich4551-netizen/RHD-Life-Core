params ["_count"];
if (!isServer || {_count <= 0}) exitWith {0};
private _cfg = missionNamespace getVariable ["RHD_LifeCore_WorldConfig",createHashMap];
private _spawns = missionNamespace getVariable ["RHD_LifeCore_SpawnLocations",[]];
private _classes = (_cfg getOrDefault ["civilianClasses","C_Man_1_F,C_Man_1_1_F,C_Man_1_2_F,C_Man_1_3_F,C_Man_1_4_F,C_Man_1_6_F,C_Man_2_F,C_Man_2_1_F,C_Man_2_2_F,C_Man_2_3_F,C_Man_2_4_F,C_Man_3_F"]) splitString ",";
_classes = _classes select {_x != "" && {isClass (configFile >> "CfgVehicles" >> _x)}};
if (_classes isEqualTo [] || {_spawns isEqualTo []}) exitWith {0};

private _players = allPlayers select {isPlayer _x && {alive _x}};
if (_players isEqualTo []) exitWith {0};

private _eligible = _spawns select {
    private _p = _x#0;
    (_players findIf {_x distance2D _p <= (_cfg getOrDefault ["civilianDespawnRadius",2500])}) > -1
};
if (_eligible isEqualTo []) then {_eligible = _spawns;};

private _created = 0;
private _group = grpNull;
private _groupSize = (_cfg getOrDefault ["civilianGroupSize",4]) max 1;
for "_i" from 1 to _count do {
    if (isNull _group || {count units _group >= _groupSize}) then {_group = createGroup civilian;};
    private _spawn = selectRandom _eligible;
    private _pos = _spawn#0;
    private _class = selectRandom _classes;
    private _unit = _group createUnit [_class,_pos,[],2,"NONE"];
    if (!isNull _unit) then {
        _unit setDir (random 360);
        _unit setBehaviour (_cfg getOrDefault ["civilianBehaviour","CARELESS"]);
        _unit setCombatBehaviour "CARELESS";
        _unit setSkill (_cfg getOrDefault ["civilianSkill",0.10]) max 0 min 1;
        _unit setVariable ["RHD_LifeCore_Civilian",true,true];
        _unit setVariable ["RHD_LifeCore_Location",_spawn#1,true];
        if (_cfg getOrDefault ["dynamicSimulation",true]) then {
            _unit enableDynamicSimulation true;
        };
        _created = _created + 1;
    };
};
_created

/* Returns the configured civilian AI target for the current player count. */
params [["_players", -1, ["", 0]]];
if (_players isEqualType "") then {_players = count (allPlayers select {isPlayer _x});};
private _cfg = missionNamespace getVariable ["RHD_LifeCore_Config", createHashMap];
private _base = _cfg getOrDefault ["civilianBasePopulation", 115];
private _min = _cfg getOrDefault ["civilianMinimumPopulation", 60];
private _reduction = _cfg getOrDefault ["civilianReductionPerPlayer", 5];
private _max = _cfg getOrDefault ["civilianMaximumPopulation", _base];
private _cap = _cfg getOrDefault ["civilianActivePlayerCap", 12];
_players = (_players max 1) min _cap;
private _target = _base - ((_players - 1) * _reduction);
_target = (_target max _min) min _max;
round _target
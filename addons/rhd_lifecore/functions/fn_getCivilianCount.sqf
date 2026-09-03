/*
    RHD LifeCore - Global civilian population target
    Returns the configured civilian AI target for the current player count.

    Formula:
      1 player  = 115
      2 players = 110
      3 players = 105
      ...
      minimum   = 60

    This is intentionally a target value for the population manager. It does
    not spawn units by itself.
*/
params [
    ["_players", -1, ["", 0]]
];

if (_players isEqualType "") then {
    _players = count (allPlayers select {isPlayer _x});
};

_players = _players max 1;
private _target = (120 - (_players * 5)) max 60;
_target

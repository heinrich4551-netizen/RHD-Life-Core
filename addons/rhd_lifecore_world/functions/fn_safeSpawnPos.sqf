params ["_center",["_minDistance",75,[0]],["_maxDistance",600,[0]]];
private _candidate = [];
for "_i" from 1 to 18 do {
    private _p = _center getPos [(_minDistance + random ((_maxDistance max _minDistance) - _minDistance)),random 360];
    _p set [2,0];
    if (!(surfaceIsWater _p) && {count (nearestTerrainObjects [_p,["TREE","SMALL TREE","BUSH","FENCE"],4,true]) == 0} && {count (_p findEmptyPosition [1,5,"C_Man_1_F"]) > 0}) exitWith {
        _candidate = _p;
    };
};
_candidate

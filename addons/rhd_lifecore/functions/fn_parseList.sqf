/*
    Parses comma-separated catalog entries into arrays.
    Example: apple:Apple:10:4,corn:Corn:8:3
    Returns: [["apple","Apple","10","4"], ...]
*/
params [["_text", "", [""]]];
private _result = [];
{
    private _entry = trim _x;
    if (_entry != "") then {
        _result pushBack ((parseSimpleArray (format ["[%1]", str (_entry splitString ":")]) ));
    };
} forEach (_text splitString ",");
_result
/* Parses comma-separated catalog entries into string arrays. */
params [["_text", "", [""]]];
private _result = [];
{
    private _entry = trim _x;
    if (_entry != "") then {
        _result pushBack (_entry splitString ":");
    };
} forEach (_text splitString ",");
_result
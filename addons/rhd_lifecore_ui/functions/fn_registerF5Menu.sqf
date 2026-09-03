if (!hasInterface) exitWith {false};

waitUntil {
    uiSleep 0.25;
    !(isNull findDisplay 46) || {time > 30}
};
if (isNull findDisplay 46) exitWith {false};

waitUntil {
    uiSleep 0.25;
    !(isNil {missionNamespace getVariable "RHD_LifeCore_Config"}) || {time > 30}
};

private _config = missionNamespace getVariable ["RHD_LifeCore_Config", createHashMap];
if !(_config getOrDefault ["f5MenuEnabled", true]) exitWith {false};

if (missionNamespace getVariable ["RHD_LifeCore_F5EH", -1] >= 0) exitWith {true};

private _eh = (findDisplay 46) displayAddEventHandler ["KeyDown", {
    params ["_display", "_key"];
    if (_key isEqualTo 63) then {
        [] spawn RHD_fnc_openF5Menu;
        true
    } else {
        false
    };
}];

missionNamespace setVariable ["RHD_LifeCore_F5EH", _eh];
true

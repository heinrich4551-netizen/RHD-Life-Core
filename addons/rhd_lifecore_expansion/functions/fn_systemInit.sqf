[] spawn {
    waitUntil {time > 1 && {!isNil "RHD_LifeCore_Config"}};
    if (isServer) then {
        private _recipes = createHashMap;
        _recipes set ["refine_iron",[[["iron_ore",2]],[ ["iron",1] ]]];
        _recipes set ["refine_copper",[[["copper_ore",2]],[ ["copper",1] ]]];
        _recipes set ["refine_gold",[[["gold_ore",2]],[ ["gold",1] ]]];
        _recipes set ["refine_oil",[[["oil_sand",2]],[ ["oil",1] ]]];
        _recipes set ["refine_diamond",[[["diamond",2]],[ ["cut_diamond",1] ]]];
        missionNamespace setVariable ["RHD_LifeCore_Recipes",_recipes,true];
        [] spawn {
            while {true} do {
                uiSleep 900;
                {[_x] call RHD_fnc_paycheck;} forEach (allPlayers select {isPlayer _x && {alive _x}});
            };
        };
    };
    if (hasInterface) then {
        player setVariable ["RHD_RP_Inventory",player getVariable ["RHD_RP_Inventory",[]],true];
        player setVariable ["RHD_RP_PhoneMessages",player getVariable ["RHD_RP_PhoneMessages",[]],true];
    };
};
true

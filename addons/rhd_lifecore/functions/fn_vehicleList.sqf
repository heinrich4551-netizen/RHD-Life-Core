if (!hasInterface) exitWith {[]};
private _vehicles = player getVariable ["RHD_RP_Vehicles", []];
if (count _vehicles == 0) then {
    hint "RHD Vehicle Registry: No owned vehicles.";
} else {
    hint parseText format ["<t size='1.2' color='#C9A227'>RHD VEHICLE REGISTRY</t><br/><br/>%1", (_vehicles apply {format ["%1  |  %2  |  $%3", _x select 0, _x select 1, _x select 2]}) joinString "<br/>"];
};
_vehicles
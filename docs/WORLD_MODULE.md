# RHD LifeCore World / Population Modules

The World Controller is RHD LifeCore's map-side population and location layer. It is designed around the same broad behavior used by Antistasi Ultimate: discover world locations, derive usable spawn points, keep runtime spawn pools, and drive AI/ambient systems from those pools. RHD implements this natively instead of importing Antistasi's mission code.

## Module placement

Place **RHD LifeCore - RP Framework** once. This module establishes the RHD runtime and also supplies safe world/population defaults when the World Controller is present in the mod.

Place **RHD LifeCore - Services Configuration** once when banking, shops, garage/impound, persistence, whitelists, EXTDB3, or Antistasi service compatibility is required.

Place **RHD LifeCore - World / Population Controller** once when you want full map/world configuration. Its settings override the core module's world defaults.

The core module plus the World Controller is sufficient for dynamic civilian world population. Services is independent and does not have to be used for civilian spawning.

## World / location generation

**Enable World Controller** — Master switch. Disable it to leave the mission untouched by the RHD world controller.

**Generate Map Locations** — Scans the loaded terrain for named world locations rather than requiring mission authors to hand-place every town.

**Location Types** — Comma-separated Arma location types. Recommended default: `NameCityCapital,NameCity,NameVillage,NameLocal`. Removing a type reduces the number of population anchors.

**Maximum Locations** — Limits how many discovered locations enter the runtime database. `0` means unlimited.

**Location Minimum Spacing** — De-duplicates close location entries. Higher values keep fewer, larger anchors; lower values preserve more small locations.

**Generate Spawn Locations** — Builds safe spawn positions from the generated location database.

**Spawn Points per Location** — Candidate positions generated around each location. More points make the population distribution less repetitive at the cost of startup work.

**Spawn Search Radius** — Maximum search distance from a location center when building safe spawn points.

**Spawn Minimum Distance** — Keeps generated civilians away from the exact location center so that they do not all materialize on the same coordinate.

## Civilian population

**Enable Civilian Population** — Master switch for RHD-managed civilian AI.

**Civilian Population at 1 Player** — Default `115`.

**Civilian Reduction per Additional Player** — Default `5`. Population target follows: `base - ((activePlayers - 1) * reduction)`.

**Civilian Population Minimum** — Default `60`. Population will not fall below this target.

**Civilian Population Maximum** — Default `115`. Prevents accidental oversized populations.

**Population Scaling Player Cap** — Default `12`. Player counts above this do not reduce the target further.

With the defaults the target is: 1 player = 115, 2 = 110, 3 = 105, 4 = 100, 5 = 95, 6 = 90, 7 = 85, 8 = 80, 9 = 75, 10 = 70, 11 = 65, 12+ = 60.

**Civilian Spawn Batch** — Maximum number of units added in a normal population pass. Increase cautiously; larger batches fill the population faster but produce larger server-side bursts.

**Civilian Group Size** — Maximum number of civilians placed in a single created group. Small groups reduce AI bookkeeping and make the population look less like one mass formation.

**Civilian Unit Classes** — Comma-separated unit classes. Only classes that exist in the loaded modset are used.

**Civilian Behaviour** — Initial AI behavior. `CARELESS` is intended for neutral RP population; `SAFE` is appropriate for a more cautious civilian feel.

**Civilian Skill** — AI skill from `0` to `1`. Keep it low for civilian actors.

**Civilian Despawn Distance** — Civilians farther than this distance from every active player are removed and recycled by the population controller.

**World Update Interval** — Seconds between population maintenance passes. Lower values react faster to player movement; higher values reduce script activity.

**Fill Population Immediately** — Performs the initial population fill in small batches after spawn-location generation rather than waiting for the first maintenance interval.

## Ambient civilian vehicles

**Enable Ambient Civilian Vehicles** — Optional lightweight traffic-style vehicle pool.

**Ambient Vehicle Target** — Maximum number of RHD-managed ambient civilian vehicles.

**Ambient Vehicle Classes** — Comma-separated civilian vehicle classes.

**Ambient Vehicle Spawn Batch** — Vehicles created per maintenance pass.

## Performance

**Use Dynamic Simulation** — Enables Arma dynamic simulation for RHD-managed ambient units/vehicles when supported.

**Dynamic Simulation Distance** — Simulation distance used for RHD civilians. This is a performance control, not a hard despawn radius.

## Debugging

**Show Generated Location Markers** — Displays generated location centers and spawn positions. Keep disabled on production servers.

The world controller also publishes `RHD_LifeCore_Locations` and `RHD_LifeCore_SpawnLocations`, which can be inspected by other RHD systems or diagnostics.

## Antistasi Ultimate compatibility

**Antistasi Compatibility Mode** — Enabled by default. When Antistasi Ultimate is detected, RHD does not replace Antistasi's native AI/world population manager.

**Allow RHD to Override Antistasi AI** — Advanced override. Enable only when deliberately running RHD as the controlling AI population layer.

**Allow RHD to Override Antistasi Economy** — Advanced economy override. The default is disabled so RHD does not interfere with Antistasi's economy model.

RHD uses Antistasi Ultimate as a compatibility target and behavioral reference. It does not bundle Antistasi's APL-ND exception assets or copy those protected components.

## How spawn generation differs from a hand-authored mission

A hand-authored mission can place fixed spawn markers. RHD instead discovers named world locations, generates candidate positions around them, validates those positions against terrain/water/empty-position checks, and stores the resulting pool for runtime use. This makes the system map-agnostic and removes the requirement to create hundreds of marker objects manually.

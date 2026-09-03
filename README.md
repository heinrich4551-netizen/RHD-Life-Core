# RHD - LifeCore

**Author:** LT. Toad  
**Purpose:** Drop-in Arma 3 RP framework delivered as configurable 3DEN modules.

RHD LifeCore provides character identity, economy, persistence adapters, jobs/licenses, shops, banking, vehicle ownership, police/EMS role services, dynamic world population, map location discovery, and Antistasi Ultimate compatibility without requiring mission-side framework scripts.

## Modules

### RHD LifeCore - RP Framework
Place once. Initializes the core RP runtime and supplies safe world/population defaults so a mission using the complete RHD mod starts populating the map without hand-authored spawn markers.

### RHD LifeCore - Services Configuration
Place once when using banking, shops, vehicle/garage/impound services, EXTDB3 persistence, role whitelists, or Antistasi service compatibility.

### RHD LifeCore - World / Population Controller
Place once for full map/world configuration. It discovers named locations, generates safe spawn positions, manages dynamic civilian population, can add ambient civilian vehicles, and exposes the advanced Antistasi compatibility controls.

The dedicated World Controller overrides the core module's world defaults, so both the core RP module and World module can be placed without creating duplicate population managers.

## Dynamic civilian population

Default scaling is:

| Active players | Civilian AI target |
|---:|---:|
| 1 | 115 |
| 2 | 110 |
| 3 | 105 |
| 4 | 100 |
| 5 | 95 |
| 6 | 90 |
| 7 | 85 |
| 8 | 80 |
| 9 | 75 |
| 10 | 70 |
| 11 | 65 |
| 12+ | 60 |

The World Controller discovers `NameCityCapital`, `NameCity`, `NameVillage`, and `NameLocal` locations by default, builds a pool of safe spawn positions around them, and uses a batched controller so the population fills without creating 115 units in one engine frame.

## Detailed World Controller configuration

See [docs/WORLD_MODULE.md](docs/WORLD_MODULE.md) for a complete explanation of every Eden attribute, recommended defaults, performance implications, Antistasi behavior, and the spawn/location model.

## Installation

Use the launcher-ready package from the `latest` GitHub release:

`https://github.com/heinrich4551-netizen/RHD-Life-Core/releases/tag/latest`

The package is structured as `@RHD-LifeCore` with its PBOs, signatures, and server key files.

## 3DEN setup

1. Start Eden Editor.
2. Open **Systems / Modules**.
3. Place **RHD LifeCore - RP Framework** once.
4. Place **RHD LifeCore - Services Configuration** once when its services are needed.
5. Place **RHD LifeCore - World / Population Controller** once for advanced map and population control.
6. Save the mission normally.

No mission `init.sqf` or copied RP framework scripts are required.

## Antistasi Ultimate compatibility

RHD targets the same broad world/location/spawn concepts used by Antistasi Ultimate but implements them natively. Antistasi Ultimate remains optional; the RHD mod does not hard-depend on it.

When Antistasi Ultimate is detected, compatibility mode leaves Antistasi's native AI/world population manager alone by default. Advanced Eden attributes can deliberately allow RHD to take over AI or economy behavior when a mission author explicitly wants that architecture.

RHD does not redistribute Antistasi Ultimate's separately licensed APL-ND exception content.

## Third-party research

Public Arma 3 repositories were used as architecture/interoperability references. RHD uses original implementations and does not copy incompatible or restricted repository content wholesale. See [THIRD_PARTY.md](THIRD_PARTY.md).

## Build

The project uses HEMTT through GitHub Actions to compile the addons, sign them, and build the launcher-ready package.

## License

RHD LifeCore source code is released under the MIT License unless a file explicitly states otherwise. Third-party material is only bundled when its redistribution terms permit it and required attribution is retained.

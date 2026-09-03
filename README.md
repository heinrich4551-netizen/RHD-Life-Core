# RHD - LifeCore

**Author:** LT. Toad  
**Purpose:** Drop-in Arma 3 RP framework delivered as a 3DEN module.

RHD LifeCore is designed so mission makers can add the framework without editing `init.sqf`, `description.ext`, or copying framework scripts into their mission.

## Installation

### Recommended: GitHub release package

1. Open the repository: https://github.com/heinrich4551-netizen/RHD-Life-Core
2. Download the latest **RHD-LifeCore release ZIP** from **Releases**.
3. Extract the ZIP. It contains the ready-to-use `@RHD-LifeCore` mod folder.
4. Put `@RHD-LifeCore` in your Arma 3 directory, normally beside the `Arma 3` executable or in your preferred mod directory.
5. Open the **Arma 3 Launcher** → **Mods** → **Local mod** → select `@RHD-LifeCore`.
6. Enable the mod.

The repository also publishes a HEMTT build artifact through GitHub Actions on every build. The release package is the preferred end-user download because it is already packaged for the Arma 3 Launcher.

## 3DEN setup

1. Start Eden Editor.
2. Open **Systems** / **Modules**.
3. Find **RHD - LifeCore**.
4. Place **RHD LifeCore - RP Framework** once anywhere on the map.
5. Select the module and configure its attributes:
   - **Enable Character Identity**
   - **Enable Basic Economy**
   - **Starting Cash**
   - **Starting Bank**
   - **Debug Logging**
6. Save the mission normally.

No mission-side framework files are required.

## Current foundation

- 3DEN-configurable RP framework module.
- Automatic player initialization.
- UID and character-name variables.
- Basic cash and bank variables.
- Reusable SQF API for identity and money.
- Respawn-safe player reinitialization.
- No required external RP framework dependency.
- Designed to coexist with other mission frameworks rather than replace them.

### SQF API

```sqf
// Change character identity
["John", "Smith"] call RHD_fnc_setIdentity;

// Add cash
[250, "cash"] call RHD_fnc_addMoney;

// Add bank funds
[1000, "bank"] call RHD_fnc_addMoney;

// Read cash
["cash"] call RHD_fnc_getMoney;

// Read bank
["bank"] call RHD_fnc_getMoney;
```

## Compatibility strategy

RHD LifeCore is intentionally **mission-agnostic**. It does not assume Antistasi, Exile, Altis Life, ACE, CBA, or another RP framework is present.

Compatibility adapters can be added later for mission-specific systems without making the base module depend on them.

## Public repository research

The architecture is informed by established public Arma 3 projects. In particular, `TMschar/A3RPGFramework` is a public SQF RPG framework under the MIT License, making it a useful reference for reusable RPG architecture. `eisengrind/liveinlife` is another public Arma 3 RP framework, but it is GPL-3.0; its code is therefore not copied into this project. We will prefer original implementations or source code whose license explicitly permits reuse.

## Build system

The project uses **HEMTT**. HEMTT is used to create the release PBO and archive so end users receive a normal `@RHD-LifeCore` Arma 3 mod package.

- Local development: `hemtt build`
- Release package: `hemtt release`
- CI: GitHub Actions automatically runs HEMTT and uploads the release artifact.

## Roadmap

- Character profile UI.
- Server-authoritative economy service.
- Persistent profile storage adapters.
- Jobs and licenses.
- Shops and transactions.
- Banking and ATM interaction.
- Vehicle ownership.
- Police / EMS / civilian role services.
- Optional ACE interaction adapter.
- Optional CBA keybind adapter.
- Optional Antistasi Ultimate compatibility adapter.
- Additional 3DEN modules for RP locations and services.

## License

RHD LifeCore source code is released under the MIT License unless a file explicitly states otherwise. Third-party code/assets will only be incorporated when their license permits redistribution and the required attribution is retained.

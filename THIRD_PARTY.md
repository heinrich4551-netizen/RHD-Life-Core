# RHD - LifeCore: Third-Party References

RHD LifeCore is an original framework. Public Arma 3 repositories were reviewed for architecture and interoperability patterns. Where a useful implementation pattern was adapted, it was rewritten to fit RHD's function namespaces, server-authoritative design, 3DEN configuration, and optional Antistasi compatibility.

## A3RPGFramework
Repository: https://github.com/TMschar/A3RPGFramework
License: MIT for the main codebase, with the repository README excluding specific database functions and image/icon assets from that MIT grant.

RHD uses this project as an architectural reference for separating RP services and persistence boundaries. Its excluded database functions and image/icon assets are not bundled into RHD.

## Antistasi Ultimate
Repository: https://github.com/Antistasi-Ultimate-Community/A3-Antistasi-Ultimate
License: MIT for the main Antistasi Ultimate codebase, subject to the repository's stated exceptions.

RHD uses Antistasi Ultimate as a compatibility target. RHD does not declare Antistasi Ultimate as a hard dependency and does not redistribute its APL-ND exception assets.

## Scarso327 AltisLife-Framework
Repository: https://github.com/Scarso327/AltisLife-Framework
License: MIT License
Copyright: (c) 2023 Jack Farhall

RHD reviewed the vehicle metadata, vehicle store, and registration patterns from this framework. The useful patterns were rewritten rather than imported wholesale so they operate with RHD LifeCore's own profile schema, garage state model, server validation, and PBO/function namespaces. No ULP framework dependency is introduced.

## Redistribution policy

Only original RHD code or third-party material with redistribution terms compatible with the project will be bundled. APL-ND content, proprietary assets, and repository-excluded images/icons are not copied into the RHD PBO.

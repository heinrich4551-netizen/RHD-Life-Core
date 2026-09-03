# RHD LifeCore Services

The service layer is optional and mission-driven through Eden/3DEN module attributes.

- Banking uses server-side transactions and amount/target validation.
- EXTDB3 is selected by the Services module; profileNamespace remains the fallback.
- Garage records use explicit `out`, `garage`, and `impounded` states.
- Police/EMS role elevation requires the configured job and whitelist authorization.
- The Antistasi adapter detects Antistasi missions and can enable economy/AI passthrough so LifeCore does not replace mission-owned systems.

Install `db/rhd_lifecore.sql` on the MySQL/MariaDB host and configure the extDB3 database entry to match the Services module values.
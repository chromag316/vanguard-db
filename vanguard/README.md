# Vanguard world DB fixes

Data fixes on top of cmangos/classic-db. `InstallFullDB.sh` applies them last, after
the achievements module world data, when `VANGUARD="YES"` (see `InstallFullDB.config.vanguard`).

Every file can be run again safely. Keep the numbering: files run in name order.

| File | Fixes |
|---|---|
| `0001_startup_log_fixes.sql` | Non-Classic `spell_group_spell` IDs, leftover waypoints for guid 23120, vendor items duplicated by `npc_vendor_template` |
| `0002_restore_23119_waypoints.sql` | Restores the 23119 patrol from Updates/4827 (removed by mistake on 2026-08-30) |
| `0003_spell_proc_event_higher_ranks.sql` | 39 non-first-rank `spell_proc_event` rows the core ignores |
| `0004_zeliek_enrage_spell_list.sql` | WotLK spells 57376/57377 in Sir Zeliek Enrage's spell list |
| `0005_script_texts_missing_broadcast.sql` | 6 `script_texts` pointing at missing `broadcast_text` rows |
| `0006_sw_auberdine_boat.sql` | The Stormwind - Auberdine boat from Turtle WoW; needs the DBCs from the Vanguard client patch |
| `0007_menethil_boat_north_pier.sql` | Moves the Menethil - Auberdine boat to the northern Auberdine pier (path 968 from the client patch) |

## Applying to an existing server

From the Vanguard repo root, with mangosd stopped and a fresh backup (`server\tools\backup_db.ps1`):

```powershell
Get-ChildItem src\vanguard-db\vanguard\world\*.sql | Sort-Object Name | ForEach-Object {
    server\mysql\bin\mysql.exe -h 127.0.0.1 -u mangos -p classicmangos -e "source $($_.FullName -replace '\\','/')"
}
```

(`server\tools\apply_vanguard_db.ps1` does the same with a single password prompt.)

## Known startup messages that are not data errors

- `creature_conditional_spawn table is empty!`: informational; the table is unused in Classic.
- `ScriptName at_southwind_tower is not assigned` (SD2Errors.log): the core has a newer
  script for AreaTrigger 3146 that upstream classic-db does not assign yet. The DB still uses
  `at_hive_tower`, which works. This clears up when upstream finishes the switch.

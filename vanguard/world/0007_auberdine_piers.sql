-- Vanguard: Auberdine pier assignments with the Stormwind - Auberdine boat (0006).
--   north pier (6594, 760)         Menethil Harbor  - Serenity's Shore (176310), path 968
--   south pier (6409, 822)         Stormwind Harbor - path 967, from 0006
--   west/centre pier (6550, 938)   Rut'theran Village - Moonspray (176244), path 969
-- Paths 968 and 969 come from the Vanguard client patch (devkit/content/sw_harbor/build_patch.py,
-- BOAT_PATHS). Periods are what the core computes for each path (devkit/content/lib/transport.py),
-- scaled like the stock periods: 968 304843 -> 304940, 969 348060 -> 348171.
-- To undo: 176310 data0 = 295, period = 295579; 176244 data0 = 293, period = 316251.
-- Safe to re-run.

UPDATE `gameobject_template` SET `data0` = 968 WHERE `entry` = 176310;
UPDATE `transports` SET `period` = 304940 WHERE `entry` = 176310;

UPDATE `gameobject_template` SET `data0` = 969 WHERE `entry` = 176244;
UPDATE `transports` SET `period` = 348171 WHERE `entry` = 176244;

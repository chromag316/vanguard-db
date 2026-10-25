-- Vanguard: the Stormwind - Auberdine boat, ported from Turtle WoW.
-- Path 967 and display 7087 come from the Vanguard client patch (patch-3.MPQ): the
-- server's dbc folder must have the merged TaxiPath/TaxiPathNode/GameObjectDisplayInfo
-- from it. Without them mangosd logs "transport template missing" and skips the boat.
-- Transports must not have a `gameobject` spawn. Safe to re-run.
--
-- Period: Turtle's DB has 350818 (copied from Ratchet - Booty Bay; Turtle's core ignores the
-- column). Our core uses it, so it must match the path: the core computes 234461 ms for
-- path 967 (devkit/content/lib/transport.py), and stock periods run 0.032% above the
-- computed value on average, so 234536.

DELETE FROM `gameobject_template` WHERE `entry` = 181646;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `faction`, `flags`, `size`, `data0`, `data1`, `data2`)
VALUES (181646, 15, 7087, 'Ship - Auberdine to Stormwind', 0, 40, 1, 967, 30, 1);

DELETE FROM `transports` WHERE `entry` = 181646;
INSERT INTO `transports` (`entry`, `name`, `period`) VALUES (181646, 'Stormwind and Auberdine', 234536);

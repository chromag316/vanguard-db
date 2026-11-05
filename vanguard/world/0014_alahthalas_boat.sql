-- Vanguard: the Alah'Thalas - Stormwind Harbor boat (0.3.0), Turtle WoW's Windrunner on a new route.
-- Turtle's Windrunner (176250) sails Alah'Thalas - Auberdine, but Auberdine's three piers are all
-- taken, so here it goes to the free pier C of Stormwind Harbor instead. Path 970 and display 7087
-- come from the Vanguard client patch (devkit/content/sw_harbor/build_patch.py, BOAT_PATHS): the
-- server's dbc folder must have the merged TaxiPath/TaxiPathNode from it. Transports must not have
-- a `gameobject` spawn. Safe to re-run.
--
-- Period: the core computes 323658 ms for path 970 (devkit/content/lib/transport.py, speed 30,
-- acceleration 1), and stock periods run 0.032% above the computed value, so 323762 (the same
-- method gives 0006's 234589 for path 967).

DELETE FROM `gameobject_template` WHERE `entry` = 176250;
-- data4: the ship bell on arrival and before departure (event 990001, world 0008)
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `faction`, `flags`, `size`, `data0`, `data1`, `data2`, `data4`)
VALUES (176250, 15, 7087, 'Windrunner', 0, 40, 1, 970, 30, 1, 990001);

DELETE FROM `transports` WHERE `entry` = 176250;
INSERT INTO `transports` (`entry`, `name`, `period`) VALUES (176250, 'Alah''Thalas and Stormwind Harbor', 323762);

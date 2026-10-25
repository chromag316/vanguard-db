-- Vanguard: move the Menethil Harbor - Auberdine boat (Serenity's Shore) to the northern
-- Auberdine pier. Its stock pier is used by the Stormwind - Auberdine boat (0006), and the two
-- ships sailed through each other. Path 968 comes from the Vanguard client patch: stock path
-- 295 on the Menethil side, Turtle's Alah'Thalas path 1636 into the northern pier (6550, 938).
-- Period: the core computes 277309 ms for path 968, scaled like the stock periods: 277397.
-- To undo: data0 = 295, period = 295579. Safe to re-run.

UPDATE `gameobject_template` SET `data0` = 968 WHERE `entry` = 176310;
UPDATE `transports` SET `period` = 277397 WHERE `entry` = 176310;

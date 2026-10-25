-- Vanguard: the Menethil Harbor - Auberdine boat (Serenity's Shore, 176310) also calls at
-- Southshore: Auberdine - Menethil Harbor - Southshore - Menethil Harbor - Auberdine.
-- Path 968 (from 0007) now includes the Southshore leg; it comes from the Vanguard client patch,
-- which also carries Turtle's longer Southshore dock. Only the period changes here: the core
-- computes 681928 ms for the new path 968, scaled like the stock periods: 682145 (11.4 min).
-- Needs 0007. To undo: period = 304940 with the previous client patch (path 968 without
-- Southshore). Safe to re-run.

UPDATE `transports` SET `period` = 682145 WHERE `entry` = 176310;

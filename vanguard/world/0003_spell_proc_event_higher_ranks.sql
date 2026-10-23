-- Vanguard: drop spell_proc_event rows for non-first ranks without a ppmRate.
-- SpellMgr skips these on load ("is not first rank ... in chain": "it won't
-- have an effect anyway") and applies the first rank's row to the whole chain,
-- so removing them changes no behaviour. 39 rows, from the 2026-10-23 startup log.
-- Safe to re-run.

DELETE FROM `spell_proc_event` WHERE `ppmRate` = 0 AND `entry` IN (
  905, 945, 325, 8134, 10432, 10431,      -- first rank 324
  12574, 12577, 12575, 12576,             -- first rank 11213
  12812, 12815, 12813, 12814,             -- first rank 12281
  13961, 13964, 13962, 13963,             -- first rank 13960
  14071, 14070,                           -- first rank 13983
  16280, 16277, 16278, 16279,             -- first rank 16257
  19308, 19312, 19309, 19311, 19310,      -- first rank 18137
  20920, 20918, 20915, 20919,             -- first rank 20375
  29446, 29444, 29445, 29447,             -- first rank 29441
  29075, 29076);                          -- first rank 29074

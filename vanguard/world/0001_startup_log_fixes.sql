-- Vanguard: data fixes for warnings in the mangosd startup log (first applied 2026-08-30 as db-fix).
-- All statements are deletes of rows the core ignores or warns about. Safe to re-run.

-- spell_group_spell references 5 spell IDs that do not exist in the Classic
-- spell_template (later-expansion IDs from Updates/4769_core_sync.sql). They
-- were never applied (LookupEntry fails on load either way).
DELETE FROM `spell_group_spell` WHERE (`Id`,`SpellId`) IN
  ((1,27094),  -- Food
   (2,27089),  -- Drink
   (3,28170),  -- Well Fed
   (7,27143),  -- Blessing
   (12,30910)); -- Curse

-- Leftover waypoints for guid 23120, which has MovementType 0; Updates/4827
-- re-created 23119-23124 without a path for it. (23119 does use its path; see 0002.)
DELETE FROM `creature_movement` WHERE `Id` = 23120;

-- npc_vendor rows that duplicate items already provided by the creature's
-- npc_vendor_template ("same item in both npc_vendor and npc_vendor_template",
-- and duplicate vendor slots in game). Items unique to each creature stay.
DELETE FROM `npc_vendor` WHERE `entry` = 3530 AND `item` IN (792,793,794,795,3602,3603);
DELETE FROM `npc_vendor` WHERE `entry` = 3532 AND `item` IN (796,797,798,799,1839,1840);
DELETE FROM `npc_vendor` WHERE `entry` = 3536 AND `item` IN (236,237,238,239,1849,1850);
DELETE FROM `npc_vendor` WHERE `entry` = 6928 AND `item` IN (117,159,1179,1205,1645,1708,2287,3770,3771,4599,8766,8952);

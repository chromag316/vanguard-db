-- Vanguard: data fixes for warnings in the mangosd startup log (first applied 2026-08-30 as db-fix).
-- All statements are deletes of rows the core ignores or warns about. Safe to re-run.
-- Upstream now fixes the rest of the original file: spell_group_spell (Updates/4859) and the
-- npc_vendor duplicates (Updates/4838, which keeps 6928's own list, so do not delete from it).

-- Leftover waypoints for guid 23120, which has MovementType 0; Updates/4827
-- re-created 23119-23124 without a path for it. (23119 does use its path; see 0002.)
DELETE FROM `creature_movement` WHERE `Id` = 23120;

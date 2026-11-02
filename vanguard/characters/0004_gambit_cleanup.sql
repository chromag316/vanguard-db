-- Vanguard 0.2.6: the normal bot AI handles eating, drinking and self buffs (aspects, stances,
-- forms, auras...) again. So the Eat food (4) and Drink (5) gambit actions are gone from the
-- catalog (world vanguard/world/0010_gambit_catalog.sql), and so are the companion passives of
-- 0.2.5 (0003_gambit_passives.sql). This removes gambits that use those actions, from the
-- companions' own lists and the class defaults, and the passive tables. Slot numbers keep their
-- gaps; the engine and the web editor take slots in order. Safe to re-run.

DELETE FROM `vanguard_gambit` WHERE `action_id` IN (4, 5);
DELETE FROM `vanguard_gambit_class_default` WHERE `action_id` IN (4, 5);

DROP TABLE IF EXISTS `vanguard_passive`;
DROP TABLE IF EXISTS `vanguard_passive_class_default`;
DROP TABLE IF EXISTS `vanguard_passive_class_seeded`;

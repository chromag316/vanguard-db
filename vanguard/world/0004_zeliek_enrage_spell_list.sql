-- Vanguard: remove Sir Zeliek Enrage spell-list entries for spells that do not
-- exist in Classic (57376 Holy Bolt, 57377 Condemnation; WotLK Naxxramas IDs).
-- mangosd already skips them ("Invalid creature_spell_list 1606302 spell ...").
-- Mark of Zeliek, Holy Wrath and Berserk stay. Safe to re-run.

DELETE FROM `creature_spell_list` WHERE `Id` = 1606302 AND `SpellId` IN (57376, 57377);

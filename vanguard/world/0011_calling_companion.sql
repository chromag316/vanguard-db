-- Vanguard: spell 90001 "Summoning", which a player casts to summon a companion.
-- A copy of Hearthstone (8690): same 10-second cast (CastingTimeIndex 7), interrupts, animation
-- (SpellVisual 220) and icon. Its effect is a dummy on the caster; when the cast completes, the
-- core script spell_vanguard_calling_companion (game/Spells/Scripts/Scripting/VanguardScripts.cpp)
-- has the playerbots module bring the companion. No cooldown here: the playerbots module keeps
-- a 60-minute cooldown per companion instead, and the Hearthstone category (89) is dropped so
-- the player's own hearthstone is not affected.
-- The client needs the same spell in Spell.dbc, for its name and cast bar: the client patch
-- (devkit/content/sw_harbor/build_patch.py, VANGUARD_SPELLS) adds it.
-- Safe to re-run.

DELETE FROM `spell_template` WHERE `Id` = 90001;
DROP TEMPORARY TABLE IF EXISTS `vanguard_spell_copy`;
CREATE TEMPORARY TABLE `vanguard_spell_copy` AS SELECT * FROM `spell_template` WHERE `Id` = 8690;
UPDATE `vanguard_spell_copy` SET
  `Id` = 90001,
  `SpellName` = 'Summoning',
  `Category` = 0,
  `CategoryRecoveryTime` = 0,
  `RecoveryTime` = 0,
  `Effect1` = 3,                    -- SPELL_EFFECT_DUMMY
  `EffectImplicitTargetA1` = 1,     -- TARGET_UNIT_CASTER
  `EffectImplicitTargetB1` = 0,
  `EffectBasePoints1` = 0,
  `Effect2` = 0,
  `EffectImplicitTargetA2` = 0,
  `EffectBonusCoefficient2` = 0;
INSERT INTO `spell_template` SELECT * FROM `vanguard_spell_copy`;
DROP TEMPORARY TABLE `vanguard_spell_copy`;

DELETE FROM `spell_scripts` WHERE `Id` = 90001;
INSERT INTO `spell_scripts` (`Id`, `ScriptName`) VALUES (90001, 'spell_vanguard_calling_companion');

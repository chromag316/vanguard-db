-- Vanguard: class default gambits (characters DB, so GM edits survive release installs, which
-- replace the world DB). A companion uses its own vanguard_gambit rows only when it has a
-- vanguard_gambit_custom row; otherwise it uses the default of its class, live, so GM edits
-- reach it at once. Written by the mangosd console commands ".gambit default save" and
-- ".gambit save/reset" (the web app sends them over SOAP).
-- Starting defaults are seeded once per class: a class listed in vanguard_gambit_class_seeded
-- is never seeded again, even if a GM emptied its list. Spells are rank 1; the companion casts
-- its highest known rank. Condition and action ids: world vanguard/world/0010_gambit_catalog.sql.
-- Safe to re-run.

CREATE TABLE IF NOT EXISTS `vanguard_gambit_class_default` (
  `class` tinyint unsigned NOT NULL,
  `slot` tinyint unsigned NOT NULL COMMENT '1-12, lower wins',
  `enabled` tinyint unsigned NOT NULL DEFAULT '1',
  `condition_id` int unsigned NOT NULL,
  `condition_param` int unsigned NOT NULL DEFAULT '0',
  `action_id` int unsigned NOT NULL,
  `action_param` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`class`, `slot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Vanguard class default gambits';

CREATE TABLE IF NOT EXISTS `vanguard_gambit_class_seeded` (
  `class` tinyint unsigned NOT NULL,
  PRIMARY KEY (`class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Classes whose starting gambits were seeded';

CREATE TABLE IF NOT EXISTS `vanguard_gambit_custom` (
  `guid` int unsigned NOT NULL COMMENT 'characters.guid of a companion with its own gambits',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Companions that use their own gambits';

-- Lists saved in 0.2.0 belong to their companions
INSERT IGNORE INTO `vanguard_gambit_custom` (`guid`) SELECT DISTINCT `guid` FROM `vanguard_gambit`;

-- Starting defaults: (class, slot, enabled, condition, param, action, param)
-- Conditions: 1 Self, 2 Self HP<X, 3 Self mana<X, 11 Ally HP<X, 12 Ally dead, 14 Ally without
-- aura, 20 leader's target, 22 Foe targeting an ally, 23 Foe casting, 27 Foe without aura.
-- Actions: 1 Cast spell, 2 Attack, 4 Eat food, 5 Drink.
INSERT INTO `vanguard_gambit_class_default` (`class`, `slot`, `enabled`, `condition_id`, `condition_param`, `action_id`, `action_param`)
SELECT v.* FROM (VALUES
  -- Warrior: Taunt, Attack, Rend, Heroic Strike, eat
  ROW(1, 1, 1, 22, 0, 1, 355), ROW(1, 2, 1, 20, 0, 2, 0), ROW(1, 3, 1, 27, 0, 1, 772), ROW(1, 4, 1, 20, 0, 1, 78),
  ROW(1, 5, 1, 2, 50, 4, 0),
  -- Paladin: Holy Light, Redemption, Attack, Seal of Righteousness, Judgement, eat, drink
  ROW(2, 1, 1, 11, 40, 1, 635), ROW(2, 2, 1, 12, 0, 1, 7328), ROW(2, 3, 1, 20, 0, 2, 0), ROW(2, 4, 1, 1, 0, 1, 21084),
  ROW(2, 5, 1, 20, 0, 1, 20271), ROW(2, 6, 1, 2, 50, 4, 0), ROW(2, 7, 1, 3, 30, 5, 0),
  -- Hunter: Serpent Sting, Arcane Shot, Auto Shot, eat, drink
  ROW(3, 1, 1, 27, 0, 1, 1978), ROW(3, 2, 1, 20, 0, 1, 3044), ROW(3, 3, 1, 20, 0, 1, 75), ROW(3, 4, 1, 2, 50, 4, 0),
  ROW(3, 5, 1, 3, 30, 5, 0),
  -- Rogue: Kick, Attack, Sinister Strike, eat
  ROW(4, 1, 1, 23, 0, 1, 1766), ROW(4, 2, 1, 20, 0, 2, 0), ROW(4, 3, 1, 20, 0, 1, 1752), ROW(4, 4, 1, 2, 50, 4, 0),
  -- Priest: Lesser Heal, Resurrection, Power Word: Fortitude, Smite, eat, drink
  ROW(5, 1, 1, 11, 50, 1, 2050), ROW(5, 2, 1, 12, 0, 1, 2006), ROW(5, 3, 1, 14, 0, 1, 1243), ROW(5, 4, 1, 20, 0, 1, 585),
  ROW(5, 5, 1, 2, 50, 4, 0), ROW(5, 6, 1, 3, 30, 5, 0),
  -- Shaman: Healing Wave, Ancestral Spirit, Earth Shock, Lightning Bolt, eat, drink
  ROW(7, 1, 1, 11, 50, 1, 331), ROW(7, 2, 1, 12, 0, 1, 2008), ROW(7, 3, 1, 23, 0, 1, 8042), ROW(7, 4, 1, 20, 0, 1, 403),
  ROW(7, 5, 1, 2, 50, 4, 0), ROW(7, 6, 1, 3, 30, 5, 0),
  -- Mage: Frost Armor, Arcane Intellect, Fireball, eat, drink
  ROW(8, 1, 1, 1, 0, 1, 168), ROW(8, 2, 1, 14, 0, 1, 1459), ROW(8, 3, 1, 20, 0, 1, 133), ROW(8, 4, 1, 2, 50, 4, 0),
  ROW(8, 5, 1, 3, 30, 5, 0),
  -- Warlock: Demon Skin, Corruption, Curse of Agony, Shadow Bolt, eat, drink
  ROW(9, 1, 1, 1, 0, 1, 687), ROW(9, 2, 1, 27, 0, 1, 172), ROW(9, 3, 1, 27, 0, 1, 980), ROW(9, 4, 1, 20, 0, 1, 686),
  ROW(9, 5, 1, 2, 50, 4, 0), ROW(9, 6, 1, 3, 30, 5, 0),
  -- Druid: Healing Touch, Rejuvenation, Mark of the Wild, Moonfire, Wrath, eat, drink
  ROW(11, 1, 1, 11, 50, 1, 5185), ROW(11, 2, 1, 11, 80, 1, 774), ROW(11, 3, 1, 14, 0, 1, 1126), ROW(11, 4, 1, 27, 0, 1, 8921),
  ROW(11, 5, 1, 20, 0, 1, 5176), ROW(11, 6, 1, 2, 50, 4, 0), ROW(11, 7, 1, 3, 30, 5, 0)
) AS v (`class`, `slot`, `enabled`, `condition_id`, `condition_param`, `action_id`, `action_param`)
WHERE v.`class` NOT IN (SELECT `class` FROM `vanguard_gambit_class_seeded`);

INSERT IGNORE INTO `vanguard_gambit_class_seeded` (`class`) VALUES (1), (2), (3), (4), (5), (7), (8), (9), (11);

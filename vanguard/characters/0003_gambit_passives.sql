-- Vanguard: companion passives (characters DB, so GM edits survive release installs, which
-- replace the world DB). Up to 3 slots per companion, besides its 12 gambits: self spells it
-- keeps up (aspects, stances, auras...). The spells a class may pick: world
-- vanguard/world/0012_gambit_passives.sql. Like the gambits, a companion uses its own rows only
-- when it has a vanguard_gambit_custom row, otherwise its class default, live. Written by the
-- mangosd console commands ".gambit passive save" and ".gambit passive default save" (the web
-- app sends them over SOAP). Starting defaults are seeded once per class. Safe to re-run.

CREATE TABLE IF NOT EXISTS `vanguard_passive` (
  `guid` int unsigned NOT NULL COMMENT 'characters.guid',
  `slot` tinyint unsigned NOT NULL COMMENT '1-3, lower wins',
  `spell_id` int unsigned NOT NULL COMMENT 'rank 1',
  PRIMARY KEY (`guid`, `slot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Vanguard companion passives';

CREATE TABLE IF NOT EXISTS `vanguard_passive_class_default` (
  `class` tinyint unsigned NOT NULL,
  `slot` tinyint unsigned NOT NULL COMMENT '1-3, lower wins',
  `spell_id` int unsigned NOT NULL COMMENT 'rank 1',
  PRIMARY KEY (`class`, `slot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Vanguard class default passives';

CREATE TABLE IF NOT EXISTS `vanguard_passive_class_seeded` (
  `class` tinyint unsigned NOT NULL,
  PRIMARY KEY (`class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Classes whose starting passives were seeded';

-- Starting defaults: Warrior Battle Stance, Paladin Devotion Aura, Hunter Aspect of the Hawk,
-- Priest Inner Fire, Shaman Lightning Shield, Mage Frost Armor, Warlock Demon Skin (none for
-- Rogue and Druid).
INSERT INTO `vanguard_passive_class_default` (`class`, `slot`, `spell_id`)
SELECT v.* FROM (VALUES
  ROW(1, 1, 2457), ROW(2, 1, 465), ROW(3, 1, 13165), ROW(5, 1, 588), ROW(7, 1, 324), ROW(8, 1, 168), ROW(9, 1, 687)
) AS v (`class`, `slot`, `spell_id`)
WHERE v.`class` NOT IN (SELECT `class` FROM `vanguard_passive_class_seeded`);

-- Companions with their own lists get their class's default passives, once, so saving
-- gambits in 0.2.0-0.2.4 does not leave them without any.
INSERT IGNORE INTO `vanguard_passive` (`guid`, `slot`, `spell_id`)
SELECT c.`guid`, d.`slot`, d.`spell_id`
FROM `vanguard_gambit_custom` c
JOIN `characters` ch ON ch.`guid` = c.`guid`
JOIN `vanguard_passive_class_default` d ON d.`class` = ch.`class`
WHERE ch.`class` NOT IN (SELECT `class` FROM `vanguard_passive_class_seeded`);

INSERT IGNORE INTO `vanguard_passive_class_seeded` (`class`) VALUES (1), (2), (3), (4), (5), (7), (8), (9), (11);

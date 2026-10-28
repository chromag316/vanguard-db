-- Vanguard: the gambit passive catalog. A companion has up to 3 passive slots besides its 12
-- gambits: self spells it keeps up in and out of combat (aspects, stances, auras, armors...).
-- This table lists what each class may pick. Spells are rank 1; the companion casts its
-- highest known rank, and skips a passive it has not learned yet. A companion may have at most
-- one passive per exclusive_group, because those spells replace each other (two aspects would
-- keep swapping). Read by the playerbots fork (strategy/vanguard/GambitMgr) and the web editor.
-- The table holds only this static data, so it is recreated: safe to re-run.

DROP TABLE IF EXISTS `vanguard_gambit_passive`;
CREATE TABLE `vanguard_gambit_passive` (
  `class` tinyint unsigned NOT NULL,
  `spell_id` int unsigned NOT NULL COMMENT 'rank 1',
  `exclusive_group` varchar(16) NOT NULL COMMENT 'at most one passive per group',
  `sort` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`class`, `spell_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Vanguard gambit passives (per class)';

INSERT INTO `vanguard_gambit_passive` (`class`, `spell_id`, `exclusive_group`, `sort`) VALUES
-- Warrior
(1, 2457,  'stance', 10),   -- Battle Stance
(1, 71,    'stance', 20),   -- Defensive Stance
(1, 2458,  'stance', 30),   -- Berserker Stance
-- Paladin
(2, 465,   'aura', 10),     -- Devotion Aura
(2, 7294,  'aura', 20),     -- Retribution Aura
(2, 19746, 'aura', 30),     -- Concentration Aura
(2, 19876, 'aura', 40),     -- Shadow Resistance Aura
(2, 19888, 'aura', 50),     -- Frost Resistance Aura
(2, 19891, 'aura', 60),     -- Fire Resistance Aura
(2, 20218, 'aura', 70),     -- Sanctity Aura
(2, 21084, 'seal', 110),    -- Seal of Righteousness
(2, 21082, 'seal', 120),    -- Seal of the Crusader
(2, 20375, 'seal', 130),    -- Seal of Command
(2, 20166, 'seal', 140),    -- Seal of Wisdom
(2, 20165, 'seal', 150),    -- Seal of Light
(2, 20164, 'seal', 160),    -- Seal of Justice
(2, 25780, 'fury', 210),    -- Righteous Fury
-- Hunter
(3, 13165, 'aspect', 10),   -- Aspect of the Hawk
(3, 13163, 'aspect', 20),   -- Aspect of the Monkey
(3, 5118,  'aspect', 30),   -- Aspect of the Cheetah
(3, 13159, 'aspect', 40),   -- Aspect of the Pack
(3, 13161, 'aspect', 50),   -- Aspect of the Beast
(3, 20043, 'aspect', 60),   -- Aspect of the Wild
(3, 19506, 'trueshot', 110),-- Trueshot Aura
-- Priest
(5, 588,   'innerfire', 10),-- Inner Fire
(5, 15473, 'form', 20),     -- Shadowform
-- Shaman
(7, 324,   'shield', 10),   -- Lightning Shield
-- Mage
(8, 168,   'armor', 10),    -- Frost Armor
(8, 7302,  'armor', 20),    -- Ice Armor
(8, 6117,  'armor', 30),    -- Mage Armor
-- Warlock
(9, 687,   'armor', 10),    -- Demon Skin
(9, 706,   'armor', 20),    -- Demon Armor
-- Druid
(11, 5487, 'form', 10),     -- Bear Form
(11, 9634, 'form', 20),     -- Dire Bear Form
(11, 768,  'form', 30),     -- Cat Form
(11, 24858,'form', 40),     -- Moonkin Form
(11, 467,  'thorns', 110);  -- Thorns

-- Vanguard: the gambit catalog (milestone 1). A gambit is one slot on a companion bot:
-- "condition -> action", where the condition also names the target (Self, Ally, Foe), as in
-- Final Fantasy XII. The evaluators are C++ in the playerbots fork (strategy/vanguard), keyed
-- by these ids: never renumber a row, only add new ones. These tables give names and the
-- allowed parameter range, for the core's checks and the web editor.
-- param_min = param_max = 0: the condition takes no parameter.
-- learnable is reserved for milestone 2 (gambits learned from trainers, manuals and drops);
-- 0 = every companion knows it. Safe to re-run.

CREATE TABLE IF NOT EXISTS `vanguard_gambit_condition` (
  `id` int unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  `param_min` int unsigned NOT NULL DEFAULT '0',
  `param_max` int unsigned NOT NULL DEFAULT '0',
  `learnable` tinyint unsigned NOT NULL DEFAULT '0',
  `sort` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Vanguard gambit conditions (target + condition)';

CREATE TABLE IF NOT EXISTS `vanguard_gambit_action` (
  `id` int unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  `needs_spell` tinyint unsigned NOT NULL DEFAULT '0',
  `learnable` tinyint unsigned NOT NULL DEFAULT '0',
  `sort` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Vanguard gambit actions';

DELETE FROM `vanguard_gambit_condition`;
INSERT INTO `vanguard_gambit_condition` (`id`, `name`, `description`, `param_min`, `param_max`, `sort`) VALUES
(1,  'Self: any',                    'Always the companion itself.', 0, 0, 10),
(2,  'Self: HP < X%',                'The companion, when its health is below X%.', 1, 99, 20),
(3,  'Self: mana < X%',              'The companion, when its mana is below X%.', 1, 99, 30),
(10, 'Ally: any',                    'The group member with the lowest health, the player included.', 0, 0, 100),
(11, 'Ally: HP < X%',                'The group member with the lowest health, when it is below X%.', 1, 99, 110),
(12, 'Ally: dead',                   'A dead group member.', 0, 0, 120),
(13, 'Ally: has a debuff the action removes', 'A group member with a debuff that the action\'s spell can dispel.', 0, 0, 130),
(20, 'Foe: party leader\'s target',  'The enemy the party leader is targeting.', 0, 0, 200),
(21, 'Foe: targeting self',          'An enemy attacking the companion.', 0, 0, 210),
(22, 'Foe: targeting an ally',       'An enemy attacking another group member.', 0, 0, 220),
(23, 'Foe: casting',                 'An enemy that is casting a spell.', 0, 0, 230),
(24, 'Foe: nearest',                 'The nearest enemy in combat with the group.', 0, 0, 240),
(25, 'Foe: HP < X%',                 'An enemy whose health is below X%.', 1, 99, 250),
(26, 'Foe: HP > X%',                 'An enemy whose health is above X%.', 1, 99, 260),
(27, 'Foe: without the action\'s aura', 'An enemy that does not have the action\'s spell on it yet (for damage over time and debuffs).', 0, 0, 270);

DELETE FROM `vanguard_gambit_action`;
INSERT INTO `vanguard_gambit_action` (`id`, `name`, `description`, `needs_spell`, `sort`) VALUES
(1, 'Cast spell',           'Cast a spell the companion knows on the target, at the highest rank it has.', 1, 10),
(2, 'Attack',               'Attack the target.', 0, 20),
(3, 'Move to party leader', 'Move back to the party leader.', 0, 30);

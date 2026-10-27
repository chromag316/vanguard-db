-- Vanguard: gambit slots of companion bots (characters DB). One row per slot; lower slots win.
-- condition_id / action_id refer to the world DB catalog (vanguard/world/0010_gambit_catalog.sql).
-- action_param is a spell id for "Cast spell"; the bot casts its highest known rank of that
-- spell. Written only by the mangosd console command ".gambit save" (the web app sends it
-- over SOAP). Safe to re-run.

CREATE TABLE IF NOT EXISTS `vanguard_gambit` (
  `guid` int unsigned NOT NULL COMMENT 'characters.guid of the companion',
  `slot` tinyint unsigned NOT NULL COMMENT '1-12, lower wins',
  `enabled` tinyint unsigned NOT NULL DEFAULT '1',
  `condition_id` int unsigned NOT NULL,
  `condition_param` int unsigned NOT NULL DEFAULT '0',
  `action_id` int unsigned NOT NULL,
  `action_param` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`, `slot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Vanguard companion gambits';

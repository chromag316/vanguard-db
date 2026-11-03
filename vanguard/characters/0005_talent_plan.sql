-- Vanguard: talent plan of companion bots (characters DB). One row per talent point, in the
-- order the companion spends them; the rank is implied by how many earlier steps name the same
-- talent. talent_id refers to Talent.dbc. A companion without rows picks its talents
-- automatically (playerbots premade specs). Written only by the mangosd console command
-- ".talentplan save" (the web app sends it over SOAP). Safe to re-run.

CREATE TABLE IF NOT EXISTS `vanguard_talent_plan` (
  `guid` int unsigned NOT NULL COMMENT 'characters.guid of the companion',
  `step` tinyint unsigned NOT NULL COMMENT '1-51, spent in this order',
  `talent_id` int unsigned NOT NULL COMMENT 'Talent.dbc id',
  PRIMARY KEY (`guid`, `step`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Vanguard companion talent plans';

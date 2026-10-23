-- Vanguard: clear broadcast_text_id on script_texts that point at broadcast_text
-- rows missing from this DB (19244, 19263, 21649, 22068-22070). With 0 the
-- core uses content_default, so the lines are still said/emoted.
-- Safe to re-run.

UPDATE `script_texts` SET `broadcast_text_id` = 0
 WHERE `entry` IN (-1000196, -1000197, -1000340, -1000341, -1000342, -1000771)
   AND `broadcast_text_id` IN (19263, 19244, 22068, 22069, 22070, 21649);

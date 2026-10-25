-- Vanguard: ship and zeppelin bells. Needs vanguard-core with transport arrival/departure
-- events (feature/transport-events: Transport::Update fires gameobject_template data4 when a
-- transport docks, data3 when it leaves).
-- Event 990001, on arrival: BoatDockingWarning (sound 5495, unused in stock, audible to
-- about 100 yards) from the ship when it docks, and again 50 s later, 10 s before it leaves.
-- Every stop is 60 s; the Feathermoon ferry's two 30 s frames at the Forgotten Coast count as
-- one stop in the core.
-- All boats and zeppelins; not the Naxxramas necropolis (181056).
-- To undo: data4 = 0 for these entries, and delete event 990001. Safe to re-run.

DELETE FROM `dbscripts_on_event` WHERE `id` = 990001;
INSERT INTO `dbscripts_on_event` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `comments`) VALUES
(990001, 0,     0, 16, 5495, 2, 'Vanguard: ship bell on arrival'),
(990001, 50000, 0, 16, 5495, 2, 'Vanguard: ship bell 10 s before departure');

UPDATE `gameobject_template` SET `data4` = 990001
 WHERE `type` = 15 AND `entry` IN (20808, 164871, 175080, 176231, 176244, 176310, 176495, 177233, 181646);

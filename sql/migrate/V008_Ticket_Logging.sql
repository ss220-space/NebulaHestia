DROP TABLE IF EXISTS `erro_admin_tickets`;
CREATE TABLE `erro_admin_tickets` (
  `id` int(11) AUTO_INCREMENT,
  `assignee` text DEFAULT NULL,
  `ckey` varchar(32) NOT NULL,
  `text` text DEFAULT NULL,
  `status` enum('OPEN','ASSIGNED','CLOSED','SOLVED','TIMED_OUT') NOT NULL,
  `round` varchar(32),
  `inround_id` int(11),
  `open_date` date,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `ckey_whitelist`
--
DROP TABLE IF EXISTS `ckey_whitelist`;
CREATE TABLE IF NOT EXISTS `ckey_whitelist`
(
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`date` DATETIME DEFAULT now() NOT NULL,
	`ckey` VARCHAR(32) NOT NULL,
	`adminwho` VARCHAR(32) NOT NULL,
	`port` INT(5) UNSIGNED NOT NULL,
	`date_start` DATETIME DEFAULT now() NOT NULL,
	`date_end` DATETIME NULL,
	`is_valid` BOOLEAN DEFAULT true NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
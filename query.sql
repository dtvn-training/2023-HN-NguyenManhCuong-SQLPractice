-- Đang ở user root
SELECT * FROM mysql.user; 

-- 1. Show grant of current user:
SHOW GRANTS;

-- 2. Create user cuongnm with password is cuong123
CREATE user `cuongnm`@`localhost` IDENTIFIED BY "cuong123";

-- 3. Grant privileges for cuongnm
GRANT SELECT, CREATE, INSERT, UPDATE, DELETE, DROP, ALTER ON *.* TO `cuongnm`@`localhost`;


# changed to cuongnm
-- 4. Create database named: 'volunteer'
CREATE DATABASE if NOT EXISTS volunteer;

-- 5. Use database volunteer
USE volunteer;

-- 6. Create table named 'user' have some columns below:
CREATE TABLE `user` (
	`id` INT NOT NULL,
	`name` VARCHAR(255) NOT NULL DEFAULT '',
	`email` VARCHAR(255) NOT NULL DEFAULT '',
	`password` VARCHAR(255) NOT NULL DEFAULT '',
	PRIMARY KEY (`id`) USING BTREE
);

-- 7. Create table named 'fanpage' have some columns below and leader_id is a foreign key
CREATE TABLE `fanpage` (
	`id` INT(10) NOT NULL,
	`fanpage_name` VARCHAR(255) NOT NULL DEFAULT '' COLLATE 'utf8mb4_0900_ai_ci',
	`leader_id` INT(10) NOT NULL DEFAULT '0',
	`status` INT(10) NOT NULL DEFAULT '0',
	`create_time` BIGINT(19) NOT NULL DEFAULT '0',
	`subscriber` INT(10) NOT NULL DEFAULT '0',
	PRIMARY KEY (`id`) USING BTREE,
	UNIQUE INDEX `fanpage_name` (`fanpage_name`) USING BTREE,
	INDEX `FK_fanpage_user` (`leader_id`) USING BTREE,
	CONSTRAINT `FK_fanpage_user` FOREIGN KEY (`leader_id`) REFERENCES `user` (`id`)
)
;

-- 8. Fanpage has column 'subscriber', we need a table to store who liked
CREATE TABLE `fanpage_subscriber` (
	`fanpage_id` INT NULL DEFAULT NULL,
	`user_id` INT NULL DEFAULT NULL,
	CONSTRAINT `FK_fanpage_subscriber_fanpage` FOREIGN KEY (`fanpage_id`) REFERENCES `fanpage` (`id`),
	CONSTRAINT `FK_fanpage_subscriber_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
);

-- 9. We have some event:
CREATE TABLE `event` (
	`id` INT(10) NOT NULL,
	`title` VARCHAR(255) NOT NULL,
	`content` TEXT NOT NULL,
	`target` INT(10) NOT NULL DEFAULT '0',
	`fanpage_id` INT(10) NOT NULL,
	`status` INT(10) NOT NULL DEFAULT '0',
	PRIMARY KEY (`id`) USING BTREE,
	INDEX `FK_event_fanpage` (`fanpage_id`) USING BTREE,
	CONSTRAINT `FK_event_fanpage` FOREIGN KEY (`fanpage_id`) REFERENCES `fanpage` (`id`)
)
;

-- 10. We also want to know member in event , and event have member ? 
CREATE TABLE `event_member` (
	`user_id` INT(10) NOT NULL,
	`event_id` INT(10) NOT NULL,
	`task` TEXT NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`status` INT(10) NOT NULL DEFAULT '0',
	INDEX `FK__user` (`user_id`) USING BTREE,
	INDEX `FK__event` (`event_id`) USING BTREE,
	CONSTRAINT `FK__user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
	CONSTRAINT `FK__event` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`)
)
;

-- 11. Finally, We want to know who is donator for an event:
CREATE TABLE `donation` (
	`user_id` INT(10) NOT NULL,
	`event_id` INT(10) NOT NULL,
	`money` INT(10) NOT NULL,
	`message` VARCHAR(255) NOT NULL DEFAULT '' COLLATE 'utf8mb4_0900_ai_ci',
	`time_stamp` BIGINT(19) NOT NULL DEFAULT '0',
	INDEX `FK_donation_user` (`user_id`) USING BTREE,
	INDEX `FK_donation_event` (`event_id`) USING BTREE,
	CONSTRAINT `FK_donation_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
	CONSTRAINT `FK_donation_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`)
)
;










 


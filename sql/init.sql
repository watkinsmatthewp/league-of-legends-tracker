/**
 * Create the schema
 */
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  `username` Text PRIMARY KEY NOT NULL,
  `pw_hash` INTEGER,
  `pw_salt` INTEGER
);
  
DROP TABLE IF EXISTS characters;
CREATE TABLE characters (`name` Text PRIMARY KEY NOT NULL);

DROP TABLE IF EXISTS roles;
CREATE TABLE roles (`name` Text PRIMARY KEY NOT NULL);

DROP TABLE IF EXISTS character_roles;
CREATE TABLE character_roles (
  `character_name` Text NOT NULL,
  `role_name` Text NOT NULL,
  PRIMARY KEY (`character_name`, `role_name`),
  FOREIGN KEY(`character_name`) REFERENCES characters(`name`),
  FOREIGN KEY(`role_name`) REFERENCES roles(`name`)
);

DROP TABLE IF EXISTS rounds;
CREATE TABLE rounds (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `started` TEXT,
  `duration_seconds` INTEGER,
  `game_version` TEXT
);

DROP TABLE IF EXISTS round_teams;
CREATE TABLE round_teams (
  `round_id` INTEGER NOT NULL,
  `team_id` INTEGER NOT NULL,
  `win` INTEGER,
  PRIMARY KEY(`round_id`, `team_id`),
  FOREIGN KEY(`round_id`) REFERENCES rounds(`id`)
);

DROP TABLE IF EXISTS round_participants;
CREATE TABLE round_participants (
  `username` TEXT NOT NULL,
  `round_id` INTEGER NOT NULL,
  `team_id` INTEGER NOT NULL,
  `character_name` TEXT NOT NULL,
  `role_name` TEXT NOT NULL,
  `kills` INTEGER NOT NULL,
  `deaths` INTEGER NOT NULL,
  PRIMARY KEY(`username`, `round_id`),
  FOREIGN KEY(`username`) REFERENCES users(`username`),
  FOREIGN KEY(`round_id`, `team_id`) REFERENCES round_teams(`round_id`, `team_id`),
  FOREIGN KEY(`character_name`, `role_name`) REFERENCES character_roles(`character_name`, `role_name`)
);

/**
 * Create static records
 */
INSERT INTO characters(`name`) 
VALUES ('Jinx'), ('Ahri'), ('Lux');

INSERT INTO roles(`name`)
VALUES ('Top'), ('Jungler'), ('Mid'), ('ADC'), ('Support');

INSERT INTO character_roles(`character_name`, `role_name`)
VALUES ('Jinx', 'Top'), ('Jinx', 'Mid'), ('Ahri', 'Jungler'), ('Ahri', 'Support'), ('Lux', 'ADC');

/**
 * Create dynamic records
 */
INSERT INTO users(`username`, `pw_hash`, `pw_salt`)
VALUES ('admin', 0, 0), ('nathan', 0, 0), ('ariel', 0, 0), ('jim', 0, 0);

INSERT INTO rounds(`started`, `duration_seconds`, `game_version`)
VALUES (strftime('%Y-%m-%dT%H:%M:%S', 'now'), 3600, '1.2.3');

INSERT INTO round_teams(`round_id`, `team_id`, `win`)
VALUES (1, 1, 0), (1, 2, 1);

INSERT INTO round_participants(`username`, `round_id`, `team_id`, `character_name`, `role_name`, `kills`, `deaths`)
VALUES ('nathan', 1, 1, 'Jinx', 'Mid', 4, 1),
  ('ariel', 1, 1, 'Ahri', 'Jungler', 12, 0),
  ('jim', 1, 2, 'Lux', 'ADC', 2, 6);
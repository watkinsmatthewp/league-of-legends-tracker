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
  `duration_minutes` INTEGER,
  `game_version` TEXT,
  `season` TEXT NOT NULL
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
  `team_id` TEXT NOT NULL,
  `character_name` TEXT NOT NULL,
  `role_name` TEXT NOT NULL,
  `kills` INTEGER NOT NULL,
  `deaths` INTEGER NOT NULL,
  `assists` INTEGER NOT NULL,
  `creep_kills` INTEGER NOT NULL,
  PRIMARY KEY(`username`, `round_id`),
  FOREIGN KEY(`username`) REFERENCES users(`username`),
  FOREIGN KEY(`round_id`, `team_id`) REFERENCES round_teams(`round_id`, `team_id`),
  FOREIGN KEY(`character_name`, `role_name`) REFERENCES character_roles(`character_name`, `role_name`)
);

/**
 * Create static records
 */
INSERT INTO characters(`name`) 
VALUES ('Akasha'), ('Alarak'), ('Anthrax'), ('Arges'), ('Artanis'), ('Avenger'), ('Axiom'), ('Balrog'), ('Bio'), 
       ('Boros'), ('Cain'), ('Corona'), ('Cow'), ('Crackling'), ('Cryo'), ('Cyprus'), ('Dakrun'), ('Darpa'), 
       ('Defiler'), ('Dehaka'), ('Drake'), ('Dustin'), ('Egon'), ('Erekul'), ('Fenix'), ('Garamond'), ('Greelus'), 
       ('Grunty'), ('Huntress'), ('Immortal'), ('Ixian'), ('Jackson'), ('Karax'), ('Kerrigan'), ('Khyrak'), 
       ('Kuradel'), ('Leo'), ('Lord Zyrkhan'), ('Lurker'), ('Maar'), ('Marine King'), ('Medic'), ('Mengsk'), ('Micro'), 
       ('Narud'), ('Nova'), ('Null'), ('Overlord'), ('Penthos'), ('Psionic'), ('Pyro'), ('Queen'), ('Rancor'), 
       ('Ravager'), ('Raynor'), ('Roach'), ('Rob'), ('Rory'), ('Shadow'), ('Starscream'), ('Stukov'), ('Summers'), 
       ('Tassadar'), ('Tosh'), ('Toxi'), ('Tychus'), ('Unix'), ('Vega'), ('Vergil'), ('Viler'), ('Viron'), ('Vorazun'), 
       ('Vorpal'), ('Vulkan'), ('Warfield'), ('Yig'), ('Zeratul');

INSERT INTO roles(`name`)
VALUES ('AA Melee'), ('AA Ranged'), ('Bruiser Melee'), ('Bruiser Ranged'), ('Spell Damage'), ('Support'), ('Tank');

INSERT INTO character_roles(`character_name`, `role_name`)
VALUES ('Akasha', 'AA Melee'), ('Akasha', 'AA Ranged'), ('Akasha', 'Bruiser Melee'), ('Akasha', 'Bruiser Ranged'), ('Akasha', 'Spell Damage'), ('Akasha', 'Support'), 
       ('Akasha', 'Tank'), ('Akasha', 'Brusier Ranged'), ('Alarak', 'AA Melee'), ('Alarak', 'AA Ranged'), ('Alarak', 'Bruiser Melee'), ('Alarak', 'Bruiser Ranged'), 
       ('Alarak', 'Spell Damage'), ('Alarak', 'Support'), ('Alarak', 'Tank'), ('Alarak', 'Brusier Ranged'), ('Anthrax', 'AA Melee'), ('Anthrax', 'AA Ranged'), ('Anthrax', 'Bruiser Melee'), 
       ('Anthrax', 'Bruiser Ranged'), ('Anthrax', 'Spell Damage'), ('Anthrax', 'Support'), ('Anthrax', 'Tank'), ('Anthrax', 'Brusier Ranged'), ('Arges', 'AA Melee'), 
       ('Arges', 'AA Ranged'), ('Arges', 'Bruiser Melee'), ('Arges', 'Bruiser Ranged'), ('Arges', 'Spell Damage'), ('Arges', 'Support'), ('Arges', 'Tank'), ('Arges', 'Brusier Ranged'), 
       ('Artanis', 'AA Melee'), ('Artanis', 'AA Ranged'), ('Artanis', 'Bruiser Melee'), ('Artanis', 'Bruiser Ranged'), ('Artanis', 'Spell Damage'), ('Artanis', 'Support'), ('Artanis', 'Tank'), 
       ('Artanis', 'Brusier Ranged'), ('Avenger', 'AA Melee'), ('Avenger', 'AA Ranged'), ('Avenger', 'Bruiser Melee'), ('Avenger', 'Bruiser Ranged'), ('Avenger', 'Spell Damage'), ('Avenger', 'Support'), 
       ('Avenger', 'Tank'), ('Avenger', 'Brusier Ranged'), ('Axiom', 'AA Melee'), ('Axiom', 'AA Ranged'), ('Axiom', 'Bruiser Melee'), ('Axiom', 'Bruiser Ranged'), ('Axiom', 'Spell Damage'), 
       ('Axiom', 'Support'), ('Axiom', 'Tank'), ('Axiom', 'Brusier Ranged'), ('Balrog', 'AA Melee'), ('Balrog', 'AA Ranged'), ('Balrog', 'Bruiser Melee'), ('Balrog', 'Bruiser Ranged'), 
       ('Balrog', 'Spell Damage'), ('Balrog', 'Support'), ('Balrog', 'Tank'), ('Balrog', 'Brusier Ranged'), ('Bio', 'AA Melee'), ('Bio', 'AA Ranged'), ('Bio', 'Bruiser Melee'), 
       ('Bio', 'Bruiser Ranged'), ('Bio', 'Spell Damage'), ('Bio', 'Support'), ('Bio', 'Tank'), ('Bio', 'Brusier Ranged'), ('Boros', 'AA Melee'), ('Boros', 'AA Ranged'), 
       ('Boros', 'Bruiser Melee'), ('Boros', 'Bruiser Ranged'), ('Boros', 'Spell Damage'), ('Boros', 'Support'), ('Boros', 'Tank'), ('Boros', 'Brusier Ranged'), ('Cain', 'AA Melee'), 
       ('Cain', 'AA Ranged'), ('Cain', 'Bruiser Melee'), ('Cain', 'Bruiser Ranged'), ('Cain', 'Spell Damage'), ('Cain', 'Support'), ('Cain', 'Tank'), ('Cain', 'Brusier Ranged'), ('Corona', 'AA Melee'), 
       ('Corona', 'AA Ranged'), ('Corona', 'Bruiser Melee'), ('Corona', 'Bruiser Ranged'), ('Corona', 'Spell Damage'), ('Corona', 'Support'), ('Corona', 'Tank'), ('Corona', 'Brusier Ranged'), 
       ('Cow', 'AA Melee'), ('Cow', 'AA Ranged'), ('Cow', 'Bruiser Melee'), ('Cow', 'Bruiser Ranged'), ('Cow', 'Spell Damage'), ('Cow', 'Support'), ('Cow', 'Tank'), ('Cow', 'Brusier Ranged'), 
       ('Crackling', 'AA Melee'), ('Crackling', 'AA Ranged'), ('Crackling', 'Bruiser Melee'), ('Crackling', 'Bruiser Ranged'), ('Crackling', 'Spell Damage'), ('Crackling', 'Support'), ('Crackling', 'Tank'), 
       ('Crackling', 'Brusier Ranged'), ('Cryo', 'AA Melee'), ('Cryo', 'AA Ranged'), ('Cryo', 'Bruiser Melee'), ('Cryo', 'Bruiser Ranged'), ('Cryo', 'Spell Damage'), ('Cryo', 'Support'), ('Cryo', 'Tank'), 
       ('Cryo', 'Brusier Ranged'), ('Cyprus', 'AA Melee'), ('Cyprus', 'AA Ranged'), ('Cyprus', 'Bruiser Melee'), ('Cyprus', 'Bruiser Ranged'), ('Cyprus', 'Spell Damage'), ('Cyprus', 'Support'), ('Cyprus', 'Tank'), 
       ('Cyprus', 'Brusier Ranged'), ('Dakrun', 'AA Melee'), ('Dakrun', 'AA Ranged'), ('Dakrun', 'Bruiser Melee'), ('Dakrun', 'Bruiser Ranged'), ('Dakrun', 'Spell Damage'), ('Dakrun', 'Support'), ('Dakrun', 'Tank'), 
       ('Dakrun', 'Brusier Ranged'), ('Darpa', 'AA Melee'), ('Darpa', 'AA Ranged'), ('Darpa', 'Bruiser Melee'), ('Darpa', 'Bruiser Ranged'), ('Darpa', 'Spell Damage'), ('Darpa', 'Support'), ('Darpa', 'Tank'), 
       ('Darpa', 'Brusier Ranged'), ('Defiler', 'AA Melee'), ('Defiler', 'AA Ranged'), ('Defiler', 'Bruiser Melee'), ('Defiler', 'Bruiser Ranged'), ('Defiler', 'Spell Damage'), ('Defiler', 'Support'), 
       ('Defiler', 'Tank'), ('Defiler', 'Brusier Ranged'), ('Dehaka', 'AA Melee'), ('Dehaka', 'AA Ranged'), ('Dehaka', 'Bruiser Melee'), ('Dehaka', 'Bruiser Ranged'), ('Dehaka', 'Spell Damage'), 
       ('Dehaka', 'Support'), ('Dehaka', 'Tank'), ('Dehaka', 'Brusier Ranged'), ('Drake', 'AA Melee'), ('Drake', 'AA Ranged'), ('Drake', 'Bruiser Melee'), ('Drake', 'Bruiser Ranged'), ('Drake', 'Spell Damage'), 
       ('Drake', 'Support'), ('Drake', 'Tank'), ('Drake', 'Brusier Ranged'), ('Dustin', 'AA Melee'), ('Dustin', 'AA Ranged'), ('Dustin', 'Bruiser Melee'), ('Dustin', 'Bruiser Ranged'), ('Dustin', 'Spell Damage'), 
       ('Dustin', 'Support'), ('Dustin', 'Tank'), ('Dustin', 'Brusier Ranged'), ('Egon', 'AA Melee'), ('Egon', 'AA Ranged'), ('Egon', 'Bruiser Melee'), ('Egon', 'Bruiser Ranged'), ('Egon', 'Spell Damage'), 
       ('Egon', 'Support'), ('Egon', 'Tank'), ('Egon', 'Brusier Ranged'), ('Erekul', 'AA Melee'), ('Erekul', 'AA Ranged'), ('Erekul', 'Bruiser Melee'), ('Erekul', 'Bruiser Ranged'), ('Erekul', 'Spell Damage'), 
       ('Erekul', 'Support'), ('Erekul', 'Tank'), ('Erekul', 'Brusier Ranged'), ('Fenix', 'AA Melee'), ('Fenix', 'AA Ranged'), ('Fenix', 'Bruiser Melee'), ('Fenix', 'Bruiser Ranged'), ('Fenix', 'Spell Damage'), 
       ('Fenix', 'Support'), ('Fenix', 'Tank'), ('Fenix', 'Brusier Ranged'), ('Garamond', 'AA Melee'), ('Garamond', 'AA Ranged'), ('Garamond', 'Bruiser Melee'), ('Garamond', 'Bruiser Ranged'), 
       ('Garamond', 'Spell Damage'), ('Garamond', 'Support'), ('Garamond', 'Tank'), ('Garamond', 'Brusier Ranged'), ('Greelus', 'AA Melee'), ('Greelus', 'AA Ranged'), ('Greelus', 'Bruiser Melee'), 
       ('Greelus', 'Bruiser Ranged'), ('Greelus', 'Spell Damage'), ('Greelus', 'Support'), ('Greelus', 'Tank'), ('Greelus', 'Brusier Ranged'), ('Grunty', 'AA Melee'), ('Grunty', 'AA Ranged'), 
       ('Grunty', 'Bruiser Melee'), ('Grunty', 'Bruiser Ranged'), ('Grunty', 'Spell Damage'), ('Grunty', 'Support'), ('Grunty', 'Tank'), ('Grunty', 'Brusier Ranged'), ('Huntress', 'AA Melee'), 
       ('Huntress', 'AA Ranged'), ('Huntress', 'Bruiser Melee'), ('Huntress', 'Bruiser Ranged'), ('Huntress', 'Spell Damage'), ('Huntress', 'Support'), ('Huntress', 'Tank'), ('Huntress', 'Brusier Ranged'), 
       ('Immortal', 'AA Melee'), ('Immortal', 'AA Ranged'), ('Immortal', 'Bruiser Melee'), ('Immortal', 'Bruiser Ranged'), ('Immortal', 'Spell Damage'), ('Immortal', 'Support'), ('Immortal', 'Tank'), 
       ('Immortal', 'Brusier Ranged'), ('Ixian', 'AA Melee'), ('Ixian', 'AA Ranged'), ('Ixian', 'Bruiser Melee'), ('Ixian', 'Bruiser Ranged'), ('Ixian', 'Spell Damage'), ('Ixian', 'Support'), ('Ixian', 'Tank'), 
       ('Ixian', 'Brusier Ranged'), ('Jackson', 'AA Melee'), ('Jackson', 'AA Ranged'), ('Jackson', 'Bruiser Melee'), ('Jackson', 'Bruiser Ranged'), ('Jackson', 'Spell Damage'), ('Jackson', 'Support'), 
       ('Jackson', 'Tank'), ('Jackson', 'Brusier Ranged'), ('Karax', 'AA Melee'), ('Karax', 'AA Ranged'), ('Karax', 'Bruiser Melee'), ('Karax', 'Bruiser Ranged'), ('Karax', 'Spell Damage'), ('Karax', 'Support'), 
       ('Karax', 'Tank'), ('Karax', 'Brusier Ranged'), ('Kerrigan', 'AA Melee'), ('Kerrigan', 'AA Ranged'), ('Kerrigan', 'Bruiser Melee'), ('Kerrigan', 'Bruiser Ranged'), ('Kerrigan', 'Spell Damage'), 
       ('Kerrigan', 'Support'), ('Kerrigan', 'Tank'), ('Kerrigan', 'Brusier Ranged'), ('Khyrak', 'AA Melee'), ('Khyrak', 'AA Ranged'), ('Khyrak', 'Bruiser Melee'), ('Khyrak', 'Bruiser Ranged'), 
       ('Khyrak', 'Spell Damage'), ('Khyrak', 'Support'), ('Khyrak', 'Tank'), ('Khyrak', 'Brusier Ranged'), ('Kuradel', 'AA Melee'), ('Kuradel', 'AA Ranged'), ('Kuradel', 'Bruiser Melee'), 
       ('Kuradel', 'Bruiser Ranged'), ('Kuradel', 'Spell Damage'), ('Kuradel', 'Support'), ('Kuradel', 'Tank'), ('Kuradel', 'Brusier Ranged'), ('Leo', 'AA Melee'), ('Leo', 'AA Ranged'), ('Leo', 'Bruiser Melee'), 
       ('Leo', 'Bruiser Ranged'), ('Leo', 'Spell Damage'), ('Leo', 'Support'), ('Leo', 'Tank'), ('Leo', 'Brusier Ranged'), ('Lord Zyrkhan', 'AA Melee'), ('Lord Zyrkhan', 'AA Ranged'), ('Lord Zyrkhan', 'Bruiser Melee'), 
       ('Lord Zyrkhan', 'Bruiser Ranged'), ('Lord Zyrkhan', 'Spell Damage'), ('Lord Zyrkhan', 'Support'), ('Lord Zyrkhan', 'Tank'), ('Lord Zyrkhan', 'Brusier Ranged'), ('Lurker', 'AA Melee'), ('Lurker', 'AA Ranged'), 
       ('Lurker', 'Bruiser Melee'), ('Lurker', 'Bruiser Ranged'), ('Lurker', 'Spell Damage'), ('Lurker', 'Support'), ('Lurker', 'Tank'), ('Lurker', 'Brusier Ranged'), ('Maar', 'AA Melee'), ('Maar', 'AA Ranged'), 
       ('Maar', 'Bruiser Melee'), ('Maar', 'Bruiser Ranged'), ('Maar', 'Spell Damage'), ('Maar', 'Support'), ('Maar', 'Tank'), ('Maar', 'Brusier Ranged'), ('Marine King', 'AA Melee'), ('Marine King', 'AA Ranged'), 
       ('Marine King', 'Bruiser Melee'), ('Marine King', 'Bruiser Ranged'), ('Marine King', 'Spell Damage'), ('Marine King', 'Support'), ('Marine King', 'Tank'), ('Marine King', 'Brusier Ranged'), 
       ('Medic', 'AA Melee'), ('Medic', 'AA Ranged'), ('Medic', 'Bruiser Melee'), ('Medic', 'Bruiser Ranged'), ('Medic', 'Spell Damage'), ('Medic', 'Support'), ('Medic', 'Tank'), ('Medic', 'Brusier Ranged'), 
       ('Mengsk', 'AA Melee'), ('Mengsk', 'AA Ranged'), ('Mengsk', 'Bruiser Melee'), ('Mengsk', 'Bruiser Ranged'), ('Mengsk', 'Spell Damage'), ('Mengsk', 'Support'), ('Mengsk', 'Tank'), ('Mengsk', 'Brusier Ranged'), 
       ('Micro', 'AA Melee'), ('Micro', 'AA Ranged'), ('Micro', 'Bruiser Melee'), ('Micro', 'Bruiser Ranged'), ('Micro', 'Spell Damage'), ('Micro', 'Support'), ('Micro', 'Tank'), ('Micro', 'Brusier Ranged'), 
       ('Narud', 'AA Melee'), ('Narud', 'AA Ranged'), ('Narud', 'Bruiser Melee'), ('Narud', 'Bruiser Ranged'), ('Narud', 'Spell Damage'), ('Narud', 'Support'), ('Narud', 'Tank'), ('Narud', 'Brusier Ranged'), 
       ('Nova', 'AA Melee'), ('Nova', 'AA Ranged'), ('Nova', 'Bruiser Melee'), ('Nova', 'Bruiser Ranged'), ('Nova', 'Spell Damage'), ('Nova', 'Support'), ('Nova', 'Tank'), ('Nova', 'Brusier Ranged'), 
       ('Null', 'AA Melee'), ('Null', 'AA Ranged'), ('Null', 'Bruiser Melee'), ('Null', 'Bruiser Ranged'), ('Null', 'Spell Damage'), ('Null', 'Support'), ('Null', 'Tank'), ('Null', 'Brusier Ranged'), 
       ('Overlord', 'AA Melee'), ('Overlord', 'AA Ranged'), ('Overlord', 'Bruiser Melee'), ('Overlord', 'Bruiser Ranged'), ('Overlord', 'Spell Damage'), ('Overlord', 'Support'), ('Overlord', 'Tank'), 
       ('Overlord', 'Brusier Ranged'), ('Penthos', 'AA Melee'), ('Penthos', 'AA Ranged'), ('Penthos', 'Bruiser Melee'), ('Penthos', 'Bruiser Ranged'), ('Penthos', 'Spell Damage'), ('Penthos', 'Support'), 
       ('Penthos', 'Tank'), ('Penthos', 'Brusier Ranged'), ('Psionic', 'AA Melee'), ('Psionic', 'AA Ranged'), ('Psionic', 'Bruiser Melee'), ('Psionic', 'Bruiser Ranged'), ('Psionic', 'Spell Damage'), 
       ('Psionic', 'Support'), ('Psionic', 'Tank'), ('Psionic', 'Brusier Ranged'), ('Pyro', 'AA Melee'), ('Pyro', 'AA Ranged'), ('Pyro', 'Bruiser Melee'), ('Pyro', 'Bruiser Ranged'), ('Pyro', 'Spell Damage'), 
       ('Pyro', 'Support'), ('Pyro', 'Tank'), ('Pyro', 'Brusier Ranged'), ('Queen', 'AA Melee'), ('Queen', 'AA Ranged'), ('Queen', 'Bruiser Melee'), ('Queen', 'Bruiser Ranged'), ('Queen', 'Spell Damage'), 
       ('Queen', 'Support'), ('Queen', 'Tank'), ('Queen', 'Brusier Ranged'), ('Rancor', 'AA Melee'), ('Rancor', 'AA Ranged'), ('Rancor', 'Bruiser Melee'), ('Rancor', 'Bruiser Ranged'), ('Rancor', 'Spell Damage'), 
       ('Rancor', 'Support'), ('Rancor', 'Tank'), ('Rancor', 'Brusier Ranged'), ('Ravager', 'AA Melee'), ('Ravager', 'AA Ranged'), ('Ravager', 'Bruiser Melee'), ('Ravager', 'Bruiser Ranged'), 
       ('Ravager', 'Spell Damage'), ('Ravager', 'Support'), ('Ravager', 'Tank'), ('Ravager', 'Brusier Ranged'), ('Raynor', 'AA Melee'), ('Raynor', 'AA Ranged'), ('Raynor', 'Bruiser Melee'), 
       ('Raynor', 'Bruiser Ranged'), ('Raynor', 'Spell Damage'), ('Raynor', 'Support'), ('Raynor', 'Tank'), ('Raynor', 'Brusier Ranged'), ('Roach', 'AA Melee'), ('Roach', 'AA Ranged'), ('Roach', 'Bruiser Melee'), 
       ('Roach', 'Bruiser Ranged'), ('Roach', 'Spell Damage'), ('Roach', 'Support'), ('Roach', 'Tank'), ('Roach', 'Brusier Ranged'), ('Rob', 'AA Melee'), ('Rob', 'AA Ranged'), ('Rob', 'Bruiser Melee'), 
       ('Rob', 'Bruiser Ranged'), ('Rob', 'Spell Damage'), ('Rob', 'Support'), ('Rob', 'Tank'), ('Rob', 'Brusier Ranged'), ('Rory', 'AA Melee'), ('Rory', 'AA Ranged'), ('Rory', 'Bruiser Melee'), 
       ('Rory', 'Bruiser Ranged'), ('Rory', 'Spell Damage'), ('Rory', 'Support'), ('Rory', 'Tank'), ('Rory', 'Brusier Ranged'), ('Shadow', 'AA Melee'), ('Shadow', 'AA Ranged'), ('Shadow', 'Bruiser Melee'), 
       ('Shadow', 'Bruiser Ranged'), ('Shadow', 'Spell Damage'), ('Shadow', 'Support'), ('Shadow', 'Tank'), ('Shadow', 'Brusier Ranged'), ('Starscream', 'AA Melee'), ('Starscream', 'AA Ranged'), 
       ('Starscream', 'Bruiser Melee'), ('Starscream', 'Bruiser Ranged'), ('Starscream', 'Spell Damage'), ('Starscream', 'Support'), ('Starscream', 'Tank'), ('Starscream', 'Brusier Ranged'), 
       ('Stukov', 'AA Melee'), ('Stukov', 'AA Ranged'), ('Stukov', 'Bruiser Melee'), ('Stukov', 'Bruiser Ranged'), ('Stukov', 'Spell Damage'), ('Stukov', 'Support'), ('Stukov', 'Tank'), ('Stukov', 'Brusier Ranged'), 
       ('Summers', 'AA Melee'), ('Summers', 'AA Ranged'), ('Summers', 'Bruiser Melee'), ('Summers', 'Bruiser Ranged'), ('Summers', 'Spell Damage'), ('Summers', 'Support'), ('Summers', 'Tank'), 
       ('Summers', 'Brusier Ranged'), ('Tassadar', 'AA Melee'), ('Tassadar', 'AA Ranged'), ('Tassadar', 'Bruiser Melee'), ('Tassadar', 'Bruiser Ranged'), ('Tassadar', 'Spell Damage'), ('Tassadar', 'Support'), 
       ('Tassadar', 'Tank'), ('Tassadar', 'Brusier Ranged'), ('Tosh', 'AA Melee'), ('Tosh', 'AA Ranged'), ('Tosh', 'Bruiser Melee'), ('Tosh', 'Bruiser Ranged'), ('Tosh', 'Spell Damage'), ('Tosh', 'Support'), 
       ('Tosh', 'Tank'), ('Tosh', 'Brusier Ranged'), ('Toxi', 'AA Melee'), ('Toxi', 'AA Ranged'), ('Toxi', 'Bruiser Melee'), ('Toxi', 'Bruiser Ranged'), ('Toxi', 'Spell Damage'), ('Toxi', 'Support'), 
       ('Toxi', 'Tank'), ('Toxi', 'Brusier Ranged'), ('Tychus', 'AA Melee'), ('Tychus', 'AA Ranged'), ('Tychus', 'Bruiser Melee'), ('Tychus', 'Bruiser Ranged'), ('Tychus', 'Spell Damage'), ('Tychus', 'Support'), 
       ('Tychus', 'Tank'), ('Tychus', 'Brusier Ranged'), ('Unix', 'AA Melee'), ('Unix', 'AA Ranged'), ('Unix', 'Bruiser Melee'), ('Unix', 'Bruiser Ranged'), ('Unix', 'Spell Damage'), ('Unix', 'Support'), 
       ('Unix', 'Tank'), ('Unix', 'Brusier Ranged'), ('Vega', 'AA Melee'), ('Vega', 'AA Ranged'), ('Vega', 'Bruiser Melee'), ('Vega', 'Bruiser Ranged'), ('Vega', 'Spell Damage'), ('Vega', 'Support'), ('Vega', 'Tank'), 
       ('Vega', 'Brusier Ranged'), ('Vergil', 'AA Melee'), ('Vergil', 'AA Ranged'), ('Vergil', 'Bruiser Melee'), ('Vergil', 'Bruiser Ranged'), ('Vergil', 'Spell Damage'), ('Vergil', 'Support'), ('Vergil', 'Tank'), 
       ('Vergil', 'Brusier Ranged'), ('Viler', 'AA Melee'), ('Viler', 'AA Ranged'), ('Viler', 'Bruiser Melee'), ('Viler', 'Bruiser Ranged'), ('Viler', 'Spell Damage'), ('Viler', 'Support'), ('Viler', 'Tank'), 
       ('Viler', 'Brusier Ranged'), ('Viron', 'AA Melee'), ('Viron', 'AA Ranged'), ('Viron', 'Bruiser Melee'), ('Viron', 'Bruiser Ranged'), ('Viron', 'Spell Damage'), ('Viron', 'Support'), ('Viron', 'Tank'), 
       ('Viron', 'Brusier Ranged'), ('Vorazun', 'AA Melee'), ('Vorazun', 'AA Ranged'), ('Vorazun', 'Bruiser Melee'), ('Vorazun', 'Bruiser Ranged'), ('Vorazun', 'Spell Damage'), ('Vorazun', 'Support'), 
       ('Vorazun', 'Tank'), ('Vorazun', 'Brusier Ranged'), ('Vorpal', 'AA Melee'), ('Vorpal', 'AA Ranged'), ('Vorpal', 'Bruiser Melee'), ('Vorpal', 'Bruiser Ranged'), ('Vorpal', 'Spell Damage'), ('Vorpal', 'Support'), 
       ('Vorpal', 'Tank'), ('Vorpal', 'Brusier Ranged'), ('Vulkan', 'AA Melee'), ('Vulkan', 'AA Ranged'), ('Vulkan', 'Bruiser Melee'), ('Vulkan', 'Bruiser Ranged'), ('Vulkan', 'Spell Damage'), ('Vulkan', 'Support'), 
       ('Vulkan', 'Tank'), ('Vulkan', 'Brusier Ranged'), ('Warfield', 'AA Melee'), ('Warfield', 'AA Ranged'), ('Warfield', 'Bruiser Melee'), ('Warfield', 'Bruiser Ranged'), ('Warfield', 'Spell Damage'), 
       ('Warfield', 'Support'), ('Warfield', 'Tank'), ('Warfield', 'Brusier Ranged'), ('Yig', 'AA Melee'), ('Yig', 'AA Ranged'), ('Yig', 'Bruiser Melee'), ('Yig', 'Bruiser Ranged'), ('Yig', 'Spell Damage'), 
       ('Yig', 'Support'), ('Yig', 'Tank'), ('Yig', 'Brusier Ranged'), ('Zeratul', 'AA Melee'), ('Zeratul', 'AA Ranged'), ('Zeratul', 'Bruiser Melee'), ('Zeratul', 'Bruiser Ranged'), ('Zeratul', 'Spell Damage'), 
       ('Zeratul', 'Support'), ('Zeratul', 'Tank'), ('Zeratul', 'Brusier Ranged');

/**
 * Create dynamic records
 */
INSERT INTO users(`username`, `pw_hash`, `pw_salt`)
VALUES ('admin', 0, 0), ('nathan', 0, 0), ('ariel', 0, 0), ('jim', 0, 0); 
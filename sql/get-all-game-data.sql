SELECT p.round_id
, r.started as `round_started`
, r.duration_seconds as `round_duration`
, p.team_id
, t.win AS `team_win`
, p.username
, p.character_name
, p.role_name
, p.kills
, p.deaths
FROM round_participants p
JOIN rounds r ON p.round_id = r.id
JOIN round_teams t ON p.round_id = t.round_id and p.team_id = t.team_id
ORDER BY p.round_id ASC, p.team_id asc, p.username ASC;
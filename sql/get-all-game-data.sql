SELECT p.round_id
, r.started as `round_started`
, r.duration_minutes `round_duration`
, r.game_version
, r.season
, p.team_id
, t.win AS `team_win`
, p.username
, p.character_name
, p.role_name
, p.kills
, p.deaths
, p.assists
, p.creep_kills
FROM round_participants p
JOIN rounds r ON p.round_id = r.id
JOIN round_teams t ON p.round_id = t.round_id and p.team_id = t.team_id
WHERE r.id in (SELECT id FROM rounds ORDER BY started DESC LIMIT ?)
ORDER BY p.round_id DESC, p.team_id asc, p.username ASC;
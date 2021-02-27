const fs = require("fs");
const sqlite3 = require("sqlite3").verbose();
const dbFile = "./.data/sqlite.db";
const db = new sqlite3.Database(dbFile);

exports.init = async function() {
  return await dbRunAll(await readSqlScript("init"));
};

exports.getAllGameData = async function() {
  const rounds = {};
  
  const rows = await dbGetAll(await readSqlScript("get-all-game-data"));  
  for (const row of rows) {
    const round = rounds[row.round_id] = rounds[row.round_id] || {
      id: row.round_id,
      started: row.round_started,
      duration: row.round_duration,
      game_version: row.game_version,
      season: row.season,
      teams: {}
    };
    const team = round.teams[row.team_id] = round.teams[row.team_id] || {
      id: row.team_id,
      win: row.team_win == 1,
      players: []
    };
    team.players.push({
      username: row.username,
      character_name: row.character_name,
      role: row.role_name,
      kills: row.kills,
      deaths: row.deaths
    });
  }
  
  return rounds;
};

exports.getAllGameDataCsv = async function() {
  const rows = await dbGetAll(await readSqlScript("get-all-game-data"));
  return objsToCsv(rows);
}

exports.updateAllGameDataCsv = async function(csv) { 
  // Read the CSV as objects
  let rows = csvToObjects(csv);
  for (const row of rows) {
    row.round_id = parseInt(row.round_id);
    row.round_duration = parseInt(row.round_duration);
    row.team_win = parseInt(row.team_win);
    row.kills = parseInt(row.kills);
    row.deaths = parseInt(row.deaths);
  }
  
  // Sort for insertion order
  rows = rows.sort(function (a, b) {
    if (a.round_id !== b.round_id) {
      return a.round_id - b.round_id;
    }
    if (a.team_id !== b.team_id) {
      return a.team_id < b.team_id ? -1 : 1;
    }
    return a.username < b.username ? -1 : 1; 
  });
   
  const createRoundSQL = await readSqlScript('create-round');
  const createRoundTeamSQL = await readSqlScript('create-round-team');
  const createRoundParticipantSQL = await readSqlScript('create-round-participant');    
  
  db.serialize(async () => {    
    let previousRoundID = null;
    let previousTeamID = null;
    
    await dbRunAll(await readSqlScript("init"));
    for (const row of rows) {
      if (row.round_id !== previousRoundID) {
        console.log(`Creating new round ${row.round_id}`);
        await dbRun(createRoundSQL, [row.round_id, row.round_started, row.round_duration, row.game_version, row.season]);
        previousTeamID = null;
      }
      if (row.team_id !== previousTeamID) {
        // Create the round team
        console.log(`Creating new team ${row.team_id} for round ${row.round_id}`);
        await dbRun(createRoundTeamSQL, [row.round_id, row.team_id, row.team_win]);
      }
      
      // Create the round participant
      // INSERT INTO round_participants(`character_name`, `username`, `round_id`, `team_id`, `role_name`, `kills`, `deaths`, `assists`, `creep_kills`)
      await dbRun(createRoundParticipantSQL, [row.character_name, row.username, row.round_id, row.team_id, row.role_name, row.kills, row.deaths, row.assists, row.creep_kills]);
      
      previousRoundID = row.round_id;    
      previousTeamID = row.team_id;
    }
  });
}

// region Private helpers

async function readSqlScript(fileName) {
  return new Promise((resolve, reject) => {
    fs.readFile(`./sql/${fileName}.sql`, (err, buff) => {
      if (err) {
        reject(err);
      } else {
        resolve(buff.toString());
      }
    });
  });
}

async function dbRunAll(sqlBatch) {
  for (const statement of sqlBatch.split(";")) {
    if (statement && statement.trim().length > 0) {
      await dbRun(statement + ';');
    }
  }
}

async function dbRun(sql, parameters) {
  return new Promise((resolve, reject) => {
    console.log(sql);
    db.run(sql, parameters || [], function(err) {
      if (err) {
        reject(err);
      } else {
        resolve();
      }
    });
  });
}

async function dbGetAll(sql) {
  return new Promise((resolve, reject) => {
    db.all(sql, (err, rows) => {
      if (err) {
        reject(err);
      } else {
        resolve(rows);
      }
    });
  });
}

function objsToCsv(array) {
  const keys = Object.keys(array[0]);
  let csv = keys.join(',');
  
  for (const item of array) {
    let row = '';
    for (const key of keys) {
      if (row.length > 0) {
        row += ',';
      }
      row += item[key];
    }
    csv += ('\n' + row);
  }
  
  return csv;
}

function csvToObjects(csvWithHeaderRow) {
  const csvRows = csvWithHeaderRow.split('\n');
  const keys = csvRows[0].split(',');
  
  const objs = [];
  for (let i = 1; i < csvRows.length; i++) {
    const obj = {};
    const cells = csvRows[i].split(',');
    for (let i = 0; i < keys.length; i++) {
      obj[keys[i]] = cells[i];
    }
    objs.push(obj);
  }
  
  return objs;
}

// endregion
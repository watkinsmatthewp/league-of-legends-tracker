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
      await dbRun(statement);
    }
  }
}

async function dbRun(sql) {
  return new Promise((resolve, reject) => {
    console.log(`Executing ` + sql);
    db.run(sql, [], function(err) {
      if (err) {
        reject(err);
      } else {
        resolve();
      }
    });
  });
}

async function dbGetAll(sql) {
  console.log(`Querying ` + sql);
  return new Promise((resolve, reject) => {
    db.all(sql, (err, rows) => {
      if (err) {
        reject(err);
      } else {
        console.log(rows);
        resolve(rows);
      }
    });
  });
}

// endregion
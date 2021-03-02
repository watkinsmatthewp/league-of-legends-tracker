const express = require("express");
const bodyParser = require("body-parser");
const multer  = require('multer');
const storage = multer.memoryStorage();
const upload = multer({ storage: storage });
const lolDAL = require("./aos-dal.js");

const app = express();
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(express.static("public"));
app.set('json spaces', 2);

// Define endpoints
app.get("/", handleIndexRequest);
app.get("/init", handleInitRequest);
app.get("/all-game-data.json", handleGetEverythingRequest);
app.get("/all-game-data.csv", handleGetEverythingCsvRequest);
app.post("/all-game-data.csv", upload.single("dbFile"), handlePostEverythingCsvRequest);

// Start listening to requests
var listener = app.listen(process.env.PORT, async function() {
  console.log("Your app is listening on port " + listener.address().port);
});

// region endpoint handlers

async function handleIndexRequest(request, response) {
  response.sendFile(__dirname + "/views/index.html");
}

async function handleInitRequest(request, response) {
  try {
    await lolDAL.init();
    response.redirect("/");
  } catch (err) {
    console.error(err);
    response.send(err);
  }
}

async function handleGetEverythingRequest(request, response) {
  try {
    response.json(await lolDAL.getAllGameData());
  } catch (err) {
    console.error(err);
    response.send(err);
  }
}

async function handleGetEverythingCsvRequest(request, response) {
  try {
    const csv = await lolDAL.getAllGameDataCsv();
    response.setHeader('Content-Disposition', 'attachment;filename=export.csv');
    response.setHeader('Content-Type', 'text/csv');
    response.send(csv);
  } catch (err) {
    console.error(err);
    response.send(err);
  }
}

async function handlePostEverythingCsvRequest(request, response) {
  try {
    const csv = Buffer.from(request.file.buffer).toString("utf-8");
    await lolDAL.updateAllGameDataCsv(csv);
    response.redirect("/");
  } catch (err) {
    console.error(err);
    response.send(err);
  }
}

// endregion

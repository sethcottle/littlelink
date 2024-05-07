const express = require("express");
const path = require("path");

const app = express();
const port = 8000;

// app.use(express.static(path.join(__dirname, 'public')));

app.use("/css", express.static("css"));
app.use("/images", express.static("images"));
app.use("/fonts", express.static("fonts"));

app.get("/", (req, res) => {
    res.sendFile(path.join(__dirname, "index.html"));
});

app.get("/privacy", (req, res) => {
    res.sendFile(path.join(__dirname, "privacy.html"));
});

app.listen(port, () => {
    console.log(`Example app listening on port ${port}`);
});

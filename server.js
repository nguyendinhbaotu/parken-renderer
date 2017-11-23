'use strict';

const express = require('express');
const child_process = require('child_process');
const fs = require('fs-extra');

// Constants
const PORT = 8080;
const HOST = '0.0.0.0';

// App
const app = express();

app.use(function (err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: err
  });
});

app.get('/', (req, res) => {
  res.send('Hello world. updated\n');
});

app.get('/step2stl', (req, res) => {
  const command = '/usr/src/app/execute.sh';
  const createdFile = '/usr/src/app/data';
  if (fs.existsSync(command)) {
    console.log('Found file');

    child_process.exec(command);

    fs.readFile(createdFile, (err, data) => {
      if (err) throw err;
      console.log(data.toString())
      res.send(data.toString());
    });

  } else {
    console.log('Not found');
    res.send('Not executed\n');
  }

});


app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
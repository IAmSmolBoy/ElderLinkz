var express = require('express');
var router = express.Router();

var { patients, credentials } = require("../globals")

// Data for sensors
data = {}

router.get('/ping', function (req, res, next) {
    res.send({ message: 'pong' });
});

router.get('/patients', function (req, res, next) {
    // console.log(Object.values(patients))

    res.send({ patients: Object.values(patients) });
});

router.get('/patient', function (req, res, next) {
    const patient = patients[req.query.name]

    for (const [ name, val ] of data.entries()) {
        patient[name] = val
    }

    res.send(patient);
});

router.get('/data', function (req, res, next) {
    res.send(data);
});

router.post('/data', function (req, res, next) {
    // console.log(req.body)

    data = {
        ...data,
        ...req.body
    }

    res.send({ message: "success" })
});

router.post('/login', function (req, res, next) {
    console.log(req.body)
    if (credentials.some((credential) => credential.name === req.body.name && credential.password.includes(req.body.password))) {
        res.send({ message: "Success" })
    }
    else {
        res.send({ error: "Username or password is incorect" })
    }
});

module.exports = router;

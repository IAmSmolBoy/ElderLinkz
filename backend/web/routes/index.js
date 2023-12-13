var express = require('express');
var router = express.Router();

// Patient Data
var patients = {
    "rui dong": {
      name: "Rui Dong",
      ic: "S0123456C",
      race: "Chinese",
      emergencyContact: "+6567773777",
      gender: "Male",
      dateOfBirth: new Date("1940-12-07T00:00:00+0800"),
      age: 60,
      ward: 1,
    },
    "robby": {
      name: "Robby",
      ic: "S1234567C",
      race: "Chinese",
      emergencyContact: "+6567773777",
      gender: "Male",
      dateOfBirth: new Date("1940-12-07T00:00:00+0800"),
      age: 61,
      ward: 1,
    },
    "hong rui": {
      name: "Hong Rui",
      ic: "S2345678C",
      race: "Chinese",
      emergencyContact: "+6567773777",
      gender: "Male",
      dateOfBirth: new Date("1940-12-07T00:00:00+0800"),
      age: 62,
      ward: 1,
    },
    "xing xiao": {
      name: "Xing Xiao",
      ic: "S3456789C",
      race: "Chinese",
      emergencyContact: "+6567773777",
      gender: "Female",
      dateOfBirth: new Date("1940-12-07T00:00:00+0800"),
      age: 63,
      ward: 2,
    },
    "raphael": {
      name: "Raphael",
      ic: "S4567890C",
      race: "Chinese",
      emergencyContact: "+6567773777",
      gender: "Male",
      dateOfBirth: new Date("1940-12-07T00:00:00+0800"),
      age: 64,
      ward: 2,
    },
    "jan gabriel": {
      name: "Jan Gabriel",
      ic: "S5678901C",
      race: "Filipino",
      emergencyContact: "+6567773777",
      gender: "Male",
      dateOfBirth: new Date("1940-12-07T00:00:00+0800"),
      age: 65,
      ward: 3,
    },
    "frederick": {
      name: "Frederick",
      ic: "S6789012C",
      race: "Filipino",
      emergencyContact: "+6567773777",
      gender: "Male",
      dateOfBirth: new Date("1940-12-07T00:00:00+0800"),
      age: 66,
      ward: 3,
    },
}

data = {}

// Login Credentials
const credentials = [
    { name: "robby", password: "poop" },
    { name: "rui dong", password: "poop" },
    { name: "hong rui", password: "poop" },
    { name: "frederick", password: "poop" },
]

/* GET home page. */
router.get('/', function (req, res, next) {
    res.render('index', { title: 'Express' });
});

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

    data = req.body

    res.send({ message: "success" })
});

router.post('/login', function (req, res, next) {
    console.log(req.body)
    if (credentials.some((credential) => credential.name === req.body.name && credential.password === req.body.password)) {
        res.send({ message: "Success" })
    }
    else {
        res.send({ error: "Username or password is incorect" })
    }
});

module.exports = router;

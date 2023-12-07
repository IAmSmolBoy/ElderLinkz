var express = require('express');
var router = express.Router();

// Patient Data
var data = {}

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

router.get('/data', function (req, res, next) {
    res.send(data);
});

router.post('/login', function (req, res, next) {
    console.log(req.body)
    if (credentials.some((credential) => credential.name === req.body.name && credential.password === req.body.password)) {
        res.send({ message: "Success" })
    }
    else {
        res.send({ message: "Username or password is incorect" })
    }
});

router.post('/data', function (req, res, next) {
    console.log(req.body)

    data = req.body

    res.send({ message: "success" })
});

module.exports = router;

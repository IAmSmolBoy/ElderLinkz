var express = require('express');
var router = express.Router();

var data = {}

/* GET home page. */
router.get('/', function (req, res, next) {
    res.render('index', { title: 'Express' });
});

router.get('/ping', function (req, res, next) {
    res.send({ msg: 'pong' });
});

router.get('/data', function (req, res, next) {
    res.send(data);
});

router.post('/data', function (req, res, next) {
    console.log(req.body)

    data = req.body

    res.send({ msg: "success" })
});

module.exports = router;

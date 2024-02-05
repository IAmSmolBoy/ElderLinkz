var express = require('express');
var router = express.Router();

router.get('/', function (req, res, next) {
    res.render('index', { title: 'Express' });
});

router.get('/ping', function (req, res, next) {
    res.send({ message: 'pong' });
});

module.exports = router;
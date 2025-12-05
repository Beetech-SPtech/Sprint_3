var express = require("express");


var router = express.Router();


var dashboardColmeia2Controller = require('../controllers/dashboardColmeia2Controller');


router.get('/media15colmeia2', function(req, res){
    dashboardColmeia2Controller.media15colmeia2(req, res);
});

router.get('/menor15colmeia2', function(req, res){
    dashboardColmeia2Controller.menor15colmeia2(req, res);
});




router.get('/maior15colmeia2', function(req, res){
    dashboardColmeia2Controller.maior15colmeia2(req, res);
});

module.exports = router;

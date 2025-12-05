var express = require("express");
var router = express.Router();

var dashboardColmeia1Controller = require('../controllers/dashboardColmeia1Controller');

router.get('/media15colmeia1', function(req, res){
    dashboardColmeia1Controller.media15colmeia1(req, res);
    
});

router.get('/menor15colmeia1', function(req, res){
    dashboardColmeia1Controller.menor15colmeia1(req, res);
});



router.get('/maior15colmeia1', function(req, res){
    dashboardColmeia1Controller.maior15colmeia1(req, res);
});
router.get('/grafico15colmeia1', function(req, res){
    dashboardColmeia1Controller.grafico15colmeia1(req, res);
});


module.exports = router;

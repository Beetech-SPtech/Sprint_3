var express = require("express");
var router = express.Router();

var dashboardGeralController = require('../controllers/dashboardGeralController')

router.get('/buscarTemperaturaAtualColmeia2', function(req,res){
    dashboardGeralController.buscarTemperaturaAtualColmeia2(req,res);
})



module.exports = router;
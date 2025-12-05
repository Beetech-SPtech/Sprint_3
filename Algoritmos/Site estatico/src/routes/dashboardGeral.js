var express = require("express");
var router = express.Router();

var dashboardGeralController = require('../controllers/dashboardGeralController')

router.get('/buscarTemperaturaAtualColmeia1', function(req,res){
    dashboardGeralController.buscarTemperaturaAtualColmeia1(req,res);
})
router.get('/buscarTemperaturaAtualColmeia2', function(req,res){
    dashboardGeralController.buscarTemperaturaAtualColmeia2(req,res);
})
router.get('/buscarTemperaturaAtualColmeia3', function(req,res){
    dashboardGeralController.buscarTemperaturaAtualColmeia3(req,res);
})
router.get('/buscarTemperaturaAtualColmeia4', function(req,res){
    dashboardGeralController.buscarTemperaturaAtualColmeia4(req,res);
})



module.exports = router;
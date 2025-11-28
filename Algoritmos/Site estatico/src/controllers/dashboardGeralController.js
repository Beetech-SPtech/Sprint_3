    var dashboardGeralModel = require("../models/dashboardGeralModel");

    function buscarTemperaturaAtualColmeia2(req,res){
        dashboardGeralModel.buscarTemperaturaAtualColmeia2()
        .then(function(resultado){
            res.status(200).json(resultado)
        })
            .catch(function(erro){
                res.status(500).json(erro.sqlMessage)
            })
    }

    module.exports = {
        buscarTemperaturaAtualColmeia2
    }
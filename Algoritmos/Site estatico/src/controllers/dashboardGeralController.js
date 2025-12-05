    var dashboardGeralModel = require("../models/dashboardGeralModel");

    function buscarTemperaturaAtualColmeia1(req,res){
        dashboardGeralModel.buscarTemperaturaAtualColmeia1()
        .then(function(resultado){
            res.status(200).json(resultado)
        })
            .catch(function(erro){
                res.status(500).json(erro.sqlMessage)
            })
    }
    function buscarTemperaturaAtualColmeia2(req,res){
        dashboardGeralModel.buscarTemperaturaAtualColmeia2()
        .then(function(resultado){
            res.status(200).json(resultado)
        })
            .catch(function(erro){
                res.status(500).json(erro.sqlMessage)
            })
    }
    function buscarTemperaturaAtualColmeia3(req,res){
        dashboardGeralModel.buscarTemperaturaAtualColmeia3()
        .then(function(resultado){
            res.status(200).json(resultado)
        })
            .catch(function(erro){
                res.status(500).json(erro.sqlMessage)
            })
    }
    function buscarTemperaturaAtualColmeia4(req,res){
        dashboardGeralModel.buscarTemperaturaAtualColmeia4()
        .then(function(resultado){
            res.status(200).json(resultado)
        })
            .catch(function(erro){
                res.status(500).json(erro.sqlMessage)
            })
    }
 

    module.exports = {
        buscarTemperaturaAtualColmeia1,
        buscarTemperaturaAtualColmeia2,
        buscarTemperaturaAtualColmeia3,
        buscarTemperaturaAtualColmeia4
    }
var dashboardColmeia2Model = require("../models/dashboardColmeia2Model");

function media15colmeia2(req, res){
    dashboardColmeia2Model.media15colmeia2()
    .then(function(resultado){
        res.status(200).json(resultado);
    })
    .catch(function(erro){
        res.status(500).json(erro.sqlMessage);
    });
}

function menor15colmeia2(req, res){
    dashboardColmeia2Model.menor15colmeia2()
    .then(function(resultado){
        res.status(200).json(resultado);
    })
    .catch(function(erro){
        res.status(500).json(erro.sqlMessage);
    });
}

function maior15colmeia2(req, res){
    dashboardColmeia2Model.maior15colmeia2()
    .then(function(resultado){
        res.status(200).json(resultado);
    })
    .catch(function(erro){
        res.status(500).json(erro.sqlMessage);
    });
}

module.exports = {
    media15colmeia2,
    menor15colmeia2,
    maior15colmeia2
}

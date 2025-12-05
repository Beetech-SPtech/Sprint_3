var dashboardColmeia1Model = require("../models/dashboardColmeia1Model");

function media15colmeia1(req, res) {
    dashboardColmeia1Model.media15colmeia1()
        .then(function (resultado) {
            res.status(200).json(resultado);
        })
        .catch(function (erro) {
            res.status(500).json(erro.sqlMessage);
        });
}

function menor15colmeia1(req, res) {
    dashboardColmeia1Model.menor15colmeia1()
        .then(function (resultado) {
            res.status(200).json(resultado);
        })
        .catch(function (erro) {
            res.status(500).json(erro.sqlMessage);
        });
}

function maior15colmeia1(req, res) {
    dashboardColmeia1Model.maior15colmeia1()
        .then(function (resultado) {
            res.status(200).json(resultado);
        })
        .catch(function (erro) {
            res.status(500).json(erro.sqlMessage);
        });
}
function grafico15colmeia1(req, res) {
    dashboardColmeia1Model.grafico15colmeia1()
        .then(function(resultado){
            res.status(200).json(resultado);
        })
        .catch(function(erro){
            res.status(500).json(erro.sqlMessage);
        });
}


module.exports = {
    grafico15colmeia1,
    media15colmeia1,
    menor15colmeia1,
    maior15colmeia1
};

// const { buscarTemperaturaAtualColmeia2 } = require("../controllers/dashboardGeralController");
var database = require("../database/config");


function buscarTemperaturaAtualColmeia2(){
    var instrucaoSql = `select valorTemp from registroSensor order by dtTemp desc limit 1;`
    console.log("executando instrução; ", instrucaoSql)
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarTemperaturaAtualColmeia2
}
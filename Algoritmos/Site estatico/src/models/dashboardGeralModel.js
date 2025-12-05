// const { buscarTemperaturaAtualColmeia2 } = require("../controllers/dashboardGeralController");
var database = require("../database/config");


function buscarTemperaturaAtualColmeia1(){
    var instrucaoSql = `select valorTemp from registroSensor where fkSensores = 1 order by dtTemp desc limit 1;`
    console.log("executando instrução; ", instrucaoSql)
    return database.executar(instrucaoSql);
}

function buscarTemperaturaAtualColmeia2(){
    var instrucaoSql = `select valorTemp from registroSensor where fkSensores = 2 order by dtTemp desc limit 1;`
    console.log("executando instrução; ", instrucaoSql)
    return database.executar(instrucaoSql);
}

function buscarTemperaturaAtualColmeia3(){
    var instrucaoSql = `select valorTemp from registroSensor where fkSensores = 3 order by dtTemp desc limit 1;`
    console.log("executando instrução; ", instrucaoSql)
    return database.executar(instrucaoSql);
}

function buscarTemperaturaAtualColmeia4(){
    var instrucaoSql = `select valorTemp from registroSensor where fkSensores = 4 order by dtTemp desc limit 1;`
    console.log("executando instrução; ", instrucaoSql)
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarTemperaturaAtualColmeia1,
    buscarTemperaturaAtualColmeia2,
    buscarTemperaturaAtualColmeia3,
    buscarTemperaturaAtualColmeia4
    
}
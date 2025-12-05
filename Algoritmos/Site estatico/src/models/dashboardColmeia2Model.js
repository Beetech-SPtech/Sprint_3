var database = require("../database/config");

function media15colmeia2(){
    var instrucaoSql = `
        SELECT temperaturaMedia 
        FROM minuto_minuto 
        WHERE numeroSensor = 2;
    `;
    return database.executar(instrucaoSql);
}

function menor15colmeia2(){
    var instrucaoSql = `
        SELECT menorTemp15min 
        FROM menor_15 
        WHERE numeroSensor = 2;
    `;
    return database.executar(instrucaoSql);
}

function maior15colmeia2(){
    var instrucaoSql = `
        SELECT maiorTemp15min 
        FROM maior_15 
        WHERE numeroSensor = 2;
    `;
    return database.executar(instrucaoSql);
}

module.exports = {
    media15colmeia2,
    menor15colmeia2,
    maior15colmeia2
}

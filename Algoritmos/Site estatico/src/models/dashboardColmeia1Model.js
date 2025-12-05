var database = require("../database/config");

function media15colmeia1(){
    var instrucaoSql = `SELECT temperaturaMedia FROM minuto_minuto WHERE numeroSensor = 1;`;
    console.log("Executando SQL: ", instrucaoSql);
    return database.executar(instrucaoSql);
}

function menor15colmeia1(){
    var instrucaoSql = `SELECT menorTemp15min FROM menor_15 WHERE numeroSensor = 1;`;
    console.log("Executando SQL: ", instrucaoSql);
    return database.executar(instrucaoSql);
}

function maior15colmeia1(){
    var instrucaoSql = `SELECT maiorTemp15min FROM maior_15 WHERE numeroSensor = 1;`;
    console.log("Executando SQL: ", instrucaoSql);
    return database.executar(instrucaoSql);
}

function grafico15colmeia1() {
    var instrucaoSql = `
        SELECT minuto, temperatura 
        FROM grafico_15min
        WHERE colmeia = 1;
    `;
    console.log("Executando SQL: ", instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    media15colmeia1,
    menor15colmeia1,
    maior15colmeia1,
    grafico15colmeia1
};

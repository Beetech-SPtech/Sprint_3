/*
DAVI VITAL DO PRADO VICENTE PEREIRA - RA: 01252033
JORGE LUIZ CARDOSO DE SIQUEIRA - RA: 01252082
LEONARDO TOMAS FEITOSA DA SILVA - RA: 01252013
MARCOS LOPIS PEREIRA - RA: 01252034
TIAGO DA SILVA SANTOS - RA: 01252133
WAGNER REIS SILVA BRONSTEIN - RA: 01252090
*/

DROP DATABASE IF EXISTS Beetech;
CREATE DATABASE Beetech;
USE Beetech;

/* --------------------- EMPRESA --------------------- */
CREATE TABLE empresa (
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    responsavel VARCHAR(40),
    nomeEmpresa VARCHAR(150),
    cnpj CHAR(18) UNIQUE,
    telFixo CHAR (13) UNIQUE,
    telCelular CHAR(14) UNIQUE,
    email VARCHAR (45)
);

INSERT INTO empresa (responsavel, nomeEmpresa, cnpj, telFixo, telCelular, email) VALUES
('Jorge Weasley', 'Beemovie', '00.000.000/0001-00', '(11)1111-1111', '(11)91111-1111','Jorge.Wealey@outlook.com'),
('Harry Plotter', 'BeeQueen','11.111.111/0001-00', '(11)2222-2222', '(11)92222-2222','PlotterChad@gmail.com'),
('Hermione Granja', 'BeeToBee', '22.222.222/0001-00', '(11)4242-5640', '(11)94002-8922', 'Granger.Hermione@Yahoo.com');


/* --------------------- USUARIOS --------------------- */
CREATE TABLE usuarios (
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50),
    email VARCHAR(70),
    senha VARCHAR(60),
    cpf CHAR(11),
    dtCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    nivelUser CHAR(3),
    fkEmpresa INT,
	FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
	CHECK(nivelUser IN ('SUP', 'PDR'))
);

INSERT INTO usuarios (nome, email, dtCadastro, nivelUser, fkEmpresa, senha)
VALUES ('Gandalf','GandalfMago@hotmail.com', DEFAULT, 'SUP', 1,'1234');


/* --------------------- COLMEIA --------------------- */
CREATE TABLE colmeia (
	idColmeia INT,
    fkEmpresa INT,
	PRIMARY KEY (idColmeia, fkEmpresa),
	FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

INSERT INTO colmeia (idColmeia, fkEmpresa) VALUES
(1,1),(2,1),(3,1);


/* --------------------- SENSORES --------------------- */
CREATE TABLE sensores (
    idSensores INT PRIMARY KEY AUTO_INCREMENT,
    numeroSensor INT,
    descricao VARCHAR(100),
    statusSensor VARCHAR(40),
    fkEmpresa INT,
    fkColmeia INT,
    FOREIGN KEY (fkEmpresa)
        REFERENCES empresa (idEmpresa),
    FOREIGN KEY (fkColmeia , fkEmpresa)
        REFERENCES colmeia (idColmeia , fkEmpresa),
    CHECK (statusSensor IN ('Ativo' , 'Inativo'))
);

INSERT INTO sensores (idSensores, numeroSensor, descricao, statusSensor, fkColmeia, fkEmpresa) VALUES 
(1, 1, 'Ninho', 'Ativo',   1, 1),
(2, 1, 'Ninho2', 'Ativo',  2, 1),
(3, 2, 'Ninho3', 'Ativo',  3, 1);


/* --------------------- REGISTRO SENSOR --------------------- */
CREATE TABLE registroSensor(
	idRegistroSensor INT PRIMARY KEY AUTO_INCREMENT,
	valorTemp DECIMAL(5,2),
    dtTemp DATETIME DEFAULT CURRENT_TIMESTAMP,
    fkSensores INT,
	FOREIGN KEY (fkSensores) REFERENCES sensores(idSensores)
);

INSERT INTO registroSensor (valorTemp, fkSensores) VALUES
(35.50, 1),
(36.20, 2),
(10.25, 3);


/* --------------------- VIEWS DO SISTEMA --------------------- */

/* TOTAL DE COLMEIAS */
CREATE VIEW total_colmeias AS
SELECT COUNT(*) AS totalColmeias FROM colmeia;


/* COLMEIAS EM ALERTA */
CREATE VIEW colmeias_alerta AS
SELECT COUNT(DISTINCT c.idColmeia) AS colmeiasAlerta
FROM colmeia c
JOIN sensores s ON s.fkColmeia = c.idColmeia
JOIN registroSensor r ON r.fkSensores = s.idSensores
WHERE r.valorTemp < 30 OR r.valorTemp > 39;


/* PREOCUPANTES */
CREATE VIEW colmeias_preocupantes AS
SELECT COUNT(DISTINCT c.idColmeia) AS colmeiasPreocupante
FROM colmeia c
JOIN sensores s ON s.fkColmeia = c.idColmeia
JOIN registroSensor r ON r.fkSensores = s.idSensores
WHERE (r.valorTemp >= 30 AND r.valorTemp < 33)
   OR (r.valorTemp > 36 AND r.valorTemp <= 39);


/* IDEAL */
CREATE VIEW colmeias_ideal AS
SELECT COUNT(DISTINCT c.idColmeia) AS colmeiasIdeal
FROM colmeia c
JOIN sensores s ON s.fkColmeia = c.idColmeia
JOIN registroSensor r ON r.fkSensores = s.idSensores
WHERE r.valorTemp BETWEEN 33 AND 36;


/* STATUS DE CADA COLMEIA */
CREATE VIEW status_colmeias AS
SELECT 
    c.idColmeia,
    r.valorTemp,
    CASE
        WHEN r.valorTemp < 30 OR r.valorTemp > 39 THEN 'ALERTA'
        WHEN (r.valorTemp >= 30 AND r.valorTemp < 33)
          OR (r.valorTemp > 36 AND r.valorTemp <= 39) THEN 'PREOCUPANTE'
        WHEN r.valorTemp BETWEEN 33 AND 36 THEN 'IDEAL'
    END AS statusColmeia
FROM colmeia c
JOIN sensores s ON s.fkColmeia = c.idColmeia
JOIN registroSensor r ON r.fkSensores = s.idSensores;


/* 15 MIN – MÉDIA */
CREATE VIEW media_15 AS
SELECT 
    s.fkColmeia AS colmeia,
    ROUND(AVG(r.valorTemp),1) AS media15min
FROM registroSensor r
JOIN sensores s ON r.fkSensores = s.idSensores
WHERE r.dtTemp >= NOW() - INTERVAL 15 MINUTE
GROUP BY s.fkColmeia;


/* 15 MIN – MENOR */
CREATE VIEW menor_15 AS
SELECT 
    s.fkColmeia AS colmeia,
    MIN(r.valorTemp) AS menorTemp15min
FROM registroSensor r
JOIN sensores s ON r.fkSensores = s.idSensores
WHERE r.dtTemp >= NOW() - INTERVAL 15 MINUTE
GROUP BY s.fkColmeia;


/* 15 MIN – MAIOR */
CREATE VIEW maior_15 AS
SELECT 
    s.fkColmeia AS colmeia,
    MAX(r.valorTemp) AS maiorTemp15min
FROM registroSensor r
JOIN sensores s ON r.fkSensores = s.idSensores
WHERE r.dtTemp >= NOW() - INTERVAL 15 MINUTE
GROUP BY s.fkColmeia;


/* 15 MIN – ALERTAS */
CREATE VIEW total_15 AS
SELECT 
    s.fkColmeia AS colmeia,
    COUNT(*) AS totalAlertas15min
FROM registroSensor r
JOIN sensores s ON r.fkSensores = s.idSensores
WHERE (r.valorTemp < 30 OR r.valorTemp > 39)
  AND r.dtTemp >= NOW() - INTERVAL 15 MINUTE
GROUP BY s.fkColmeia;


/* -------- VIEW DO GRÁFICO -------- */
CREATE VIEW grafico_15min AS
SELECT 
    s.fkColmeia AS colmeia,
    DATE_FORMAT(r.dtTemp, '%H:%i') AS minuto,
    ROUND(AVG(r.valorTemp), 1) AS temperatura
FROM registroSensor r
JOIN sensores s 
    ON r.fkSensores = s.idSensores
WHERE r.dtTemp >= NOW() - INTERVAL 15 MINUTE
GROUP BY 
    s.fkColmeia,
    DATE_FORMAT(r.dtTemp, '%Y-%m-%d %H:%i')
ORDER BY MIN(r.dtTemp);


/* TESTE PARA COLMEIA 1 */
SELECT * FROM grafico_15min WHERE colmeia = 1;

CREATE VIEW alerta_semana_especifica AS
    SELECT 
        s.numeroSensor,
        DAYNAME(r.dtTemp) AS diaSemana,
        COUNT(*) AS totalAlertas
    FROM
        registroSensor r
            JOIN
        sensores s ON r.fkSensores = s.idSensores
    WHERE
        (r.valorTemp < 30 OR r.valorTemp > 39)
    GROUP BY s.numeroSensor , DAYNAME(r.dtTemp)
    ORDER BY s.numeroSensor;

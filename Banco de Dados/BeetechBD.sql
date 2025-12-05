/*
DAVI VITAL DO PRADO VICENTE PEREIRA - RA: 01252033
JORGE LUIZ CARDOSO DE SIQUEIRA - RA: 01252082
LEONARDO TOMAS FEITOSA DA SILVA - RA: 01252013
MARCOS LOPIS PEREIRA - RA: 01252034
TIAGO DA SILVA SANTOS - RA: 01252133
WAGNER REIS SILVA BRONSTEIN - RA: 01252090
*/


create database Beetech;
use Beetech;

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

select * from empresa;

CREATE TABLE usuarios (
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50),
    email VARCHAR(70),
    senha VARCHAR(60),
    cpf CHAR(11),
    dtCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    nivelUser CHAR(3),
    fkEmpresa INT,
		CONSTRAINT fkDaEmpresa
			FOREIGN KEY (fkEmpresa)
				REFERENCES empresa(idEmpresa),
		CONSTRAINT chk_nivel check(nivelUser in('SUP', 'ADM'))
);

INSERT INTO usuarios (nome, email,dtCadastro, nivelUser, fkEmpresa) VALUES
('Gandalf','GandalfMago@hotmail.com', default, 'SUP', 1),
('Bilbo', 'BilboHobbit@sptech.school', default, 'SUP', 2),
('Aragorn', 'AragornBrabo@icloud.com', default, 'ADM',3);

select * from usuarios;

CREATE TABLE colmeia (
	idColmeia INT,
    fkEmpresa INT,
		CONSTRAINT fkDaColmeiaEmpresa
			FOREIGN KEY (fkEmpresa)
				REFERENCES empresa(idEmpresa),
	PRIMARY KEY (idColmeia, fkEmpresa)
); 

INSERT INTO colmeia (idColmeia, fkEmpresa) VALUES
(1,1),
(2,1),
(3,1);

select * from colmeia;

CREATE TABLE sensores (
    idSensores INT PRIMARY KEY auto_increment,
    numeroSensor INT,
    descricao VARCHAR(100),
    statusSensor VARCHAR(40),
    fkEmpresa INT, 
        CONSTRAINT fkDaCOmeiaEmpresa
            FOREIGN KEY (fkEmpresa)
                REFERENCES empresa(idEmpresa),
    fkColmeia INT,
        CONSTRAINT fkDaColmeia
            FOREIGN KEY (fkColmeia, fkEmpresa)
                REFERENCES colmeia(idColmeia, fkEMpresa),
        CONSTRAINT checkStatusSensor check(statusSensor in('Ativo', 'Inativo'))
);

INSERT INTO sensores (idSensores, numeroSensor, descricao, statusSensor, fkColmeia, fkEmpresa) VALUES 
(1, 1, 'Ninho', 'Ativo', 1, 1),
(2, 1, 'Ninho2', 'Ativo', 2, 1),
(3, 2, 'Ninho4', 'Inativo', 3, 1);

select * from sensores;

CREATE TABLE registroSensor(
	idREgistroSensor INT PRIMARY KEY AUTO_INCREMENT,
	valorTemp DECIMAL,
    dtTemp DATETIME DEFAULT CURRENT_TIMESTAMP,
    fkSensores INT,
		CONSTRAINT fkDoSensor
			FOREIGN KEY (fkSensores)
				REFERENCES sensores(idSensores)
);

INSERT INTO registroSensor (valorTemp, dtTemp, fkSensores) VALUES
(35.50, default, 1),
(36.20, default, 2),
(10.25, default, 3);

select * from registroSensor;

CREATE TABLE contato (
	idContato INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    sobrenome VARCHAR(45),
    email VARCHAR(45),
    telCelular CHAR(14),
    empresa VARCHAR(100),
    cnpj CHAR(18),
    cargo VARCHAR(40),
    comentario VARCHAR(500)
);

/*TOTAL DE COLMEIAS REGISTRADAS*/
CREATE VIEW total_colmeias AS SELECT COUNT(*) AS totalColmeias
FROM colmeia;

select * from total_colmeias;

/*COLMEIAS EM ALERTA*/
CREATE VIEW colmeias_alerta AS SELECT COUNT(DISTINCT c.idColmeia) AS colmeiasAlerta
FROM colmeia c
JOIN sensores s ON s.fkColmeia = c.idColmeia
JOIN registroSensor r ON r.fkSensores = s.idSensores
WHERE r.valorTemp < 30
   OR r.valorTemp > 39;
   
select * from colmeias_alerta;

/*COLMEIAS PREOCUPANTES*/
CREATE VIEW colmeias_preocupantes AS SELECT COUNT(DISTINCT c.idColmeia) AS colmeiasPreocupante
FROM colmeia c
JOIN sensores s ON s.fkColmeia = c.idColmeia
JOIN registroSensor r ON r.fkSensores = s.idSensores
WHERE 
(
    r.valorTemp >= 30 AND r.valorTemp < 33
    OR
    r.valorTemp > 36 AND r.valorTemp <= 39
);

select * from colmeias_preocupantes;

/*COLMEIAS EM ESTADO IDEAL*/

CREATE VIEW colmeias_ideal AS SELECT COUNT(DISTINCT c.idColmeia) AS colmeiasIdeal
FROM colmeia c
JOIN sensores s ON s.fkColmeia = c.idColmeia
JOIN registroSensor r ON r.fkSensores = s.idSensores
WHERE r.valorTemp BETWEEN 33 AND 36;

select * from colmeias_ideal;

/*ALERTAS DA SEMANA*/

CREATE VIEW alertas_semana AS SELECT 
  DAYNAME(r.dtTemp) AS dia,
  COUNT(*) AS totalAlertas
FROM registroSensor r
JOIN sensores s ON r.fkSensores = s.idSensores
WHERE 
  (r.valorTemp < 30 OR r.valorTemp > 39)
  AND r.dtTemp >= CURDATE() - INTERVAL 7 DAY
GROUP BY dia
ORDER BY r.dtTemp;

select * from alertas_semana;

/*STATUS DE CADA COLMEIA*/

CREATE VIEW status_colmeias AS SELECT 
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

select * from status_colmeias;

/*ÚLTIMO REGISTRO DE CADA COLMEIA*/

CREATE VIEW ultimo_registro AS SELECT 
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
JOIN registroSensor r ON r.fkSensores = s.idSensores
WHERE r.dtTemp = (
    SELECT MAX(r2.dtTemp)
    FROM registroSensor r2
    WHERE r2.fkSensores = s.idSensores
);

select * from ultimo_registro;

select * from registroSensor
where data >= now() - interval 15 minute;

/* ESPECIFICA */

CREATE VIEW temp_atual AS 
SELECT 
    s.numeroSensor AS numeroSensor,
    r.valorTemp AS temperaturaAtual
FROM registroSensor r
JOIN sensores s 
  ON r.fkSensores = s.idSensores
WHERE r.dtTemp >= NOW() - INTERVAL 15 MINUTE
ORDER BY r.dtTemp DESC;


CREATE VIEW media_15 AS 
SELECT 
    s.numeroSensor AS numeroSensor,
    ROUND(AVG(r.valorTemp), 1) AS media15min
FROM registroSensor r
JOIN sensores s 
  ON r.fkSensores = s.idSensores
WHERE r.dtTemp >= NOW() - INTERVAL 15 MINUTE
GROUP BY s.numeroSensor;


CREATE VIEW menor_15 AS 
SELECT 
    s.numeroSensor AS numeroSensor,
    MIN(r.valorTemp) AS menorTemp15min
FROM registroSensor r
JOIN sensores s 
  ON r.fkSensores = s.idSensores
WHERE r.dtTemp >= NOW() - INTERVAL 15 MINUTE
GROUP BY s.numeroSensor;


CREATE VIEW maior_15 AS 
SELECT 
    s.numeroSensor AS numeroSensor,
    MAX(r.valorTemp) AS maiorTemp15min
FROM registroSensor r
JOIN sensores s 
  ON r.fkSensores = s.idSensores
WHERE r.dtTemp >= NOW() - INTERVAL 15 MINUTE
GROUP BY s.numeroSensor;


CREATE VIEW total_15 as SELECT 
    s.numeroSensor AS numeroSensor,
    COUNT(*) AS totalAlertas15min
FROM registroSensor r
JOIN sensores s 
  ON r.fkSensores = s.idSensores
WHERE (r.valorTemp < 30 OR r.valorTemp > 39)
  AND r.dtTemp >= NOW() - INTERVAL 15 MINUTE
GROUP BY s.numeroSensor;

CREATE VIEW minuto_minuto AS
SELECT 
    s.numeroSensor AS numeroSensor,
    DATE_FORMAT(r.dtTemp, '%H:%i') AS minuto,
    ROUND(AVG(r.valorTemp), 1) AS temperaturaMedia
FROM registroSensor r
JOIN sensores s 
  ON r.fkSensores = s.idSensores
WHERE r.dtTemp >= NOW() - INTERVAL 15 MINUTE
GROUP BY 
    s.numeroSensor,
    DATE_FORMAT(r.dtTemp, '%Y-%m-%d %H:%i');

CREATE VIEW alerta_semana_especifica as SELECT 
    s.numeroSensor,
    DAYNAME(r.dtTemp) AS diaSemana,
    COUNT(*) AS totalAlertas
FROM registroSensor r
JOIN sensores s ON r.fkSensores = s.idSensores
WHERE 
    (r.valorTemp < 30 OR r.valorTemp > 39)
GROUP BY s.numeroSensor, DAYNAME(r.dtTemp)
ORDER BY s.numeroSensor;


-- Criação do banco de dados

CREATE DATABASE VazaNada;
USE VazaNada;
DROP DATABASE VazaNada;

-- Começo

CREATE TABLE Empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
razao_social VARCHAR(150) NOT NULL,
nome VARCHAR(255) NOT NULL,
responsavel VARCHAR(80) NOT NULL,
telefone CHAR(11) NOT NULL
);

-- Solução

CREATE TABLE Unidade (
idUnidade INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(255) NOT NULL,
logradouro VARCHAR(100) NOT NULL,
numero VARCHAR(10) NOT NULL,
bairro VARCHAR(100) NOT NULL,
estado VARCHAR(100) NOT NULL,
cep CHAR(8) NOT NULL,
fkEmpresa INT NOT NULL,
CONSTRAINT fkEmpresaUnidade 
	FOREIGN KEY (fkEmpresa) 
		REFERENCES empresa (idEmpresa)
);

CREATE TABLE Setor (
idSetor INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(60) NOT NULL,
descrição VARCHAR(100) NOT NULL,
fkUnidade INT NOT NULL,
CONSTRAINT fkSetorUnidade 
	FOREIGN KEY (fkUnidade) 
		REFERENCES empresa (idEmpresa)
);

CREATE TABLE Sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
dtInstalação DATETIME NOT NULL,
dtÚltimaManutenção DATETIME NOT NULL,
fkSetor INT NOT NULL, 
CONSTRAINT fkSensorSetor 
	FOREIGN KEY (fkSetor) 
		REFERENCES Setor (idSetor)
);

CREATE TABLE Medição (
idMedição INT PRIMARY KEY AUTO_INCREMENT,
qtdGásVazado FLOAT NOT NULL,
dtComeçoVazamento DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
fkSensor INT NOT NULL, 
CONSTRAINT fkMediçãoSensor 
	FOREIGN KEY (fkSensor) 
		REFERENCES Sensor (idSensor)
);

-- Site

CREATE TABLE Usuario (
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
email VARCHAR(255) NOT NULL,
senha VARCHAR(255) NOT NULL,
fkEmpresa INT NOT NULL, 
CONSTRAINT fkUsuarioEmpresa 
	FOREIGN KEY (fkEmpresa) 
		REFERENCES Empresa (idEmpresa)
);

CREATE TABLE Login (
idLogin INT PRIMARY KEY AUTO_INCREMENT,
dtHrAcesso DATETIME,
dtHrSaída DATETIME,
fkUsuario INT,
CONSTRAINT fkLoginUsuario
	FOREIGN KEY (fkUsuario)
		REFERENCES Usuario (idUsuario)
);

-- Exemplificação de inserts

INSERT INTO Empresa (razao_social, nome, responsavel, telefone) VALUES
		('Petróleo Brasileiro S.A.', 'Petrobras', 'João da Silva', '11987654321'),
		('Transportadora Associada de Gás S.A.', 'TAG', 'Maria Oliveira', '11976543210'),
		('Nova Transportadora do Sudeste S.A.', 'NTS', 'Carlos Pereira', '11965432109'),
		('Companhia de Gás do Estado de São Paulo', 'GAS-SP', 'Ana Souza', '11954321098'),
		('Companhia Paranaense de Gás', 'Pontal', 'Lucas Santos', '11943210987');
       
INSERT INTO Unidade (nome, logradouro, numero, bairro, estado, cep, fkEmpresa) VALUES

		-- Unidades da Petrobas
		('Unidade Petrobras São Paulo', 'Av. Paulista', '1578', 'Bela Vista', 'São Paulo', '01310-200', 1),
		('Unidade Petrobras Belo Horizonte', 'Av. Afonso Pena', '1234', 'Centro', 'Minas Gerais', '30130-001', 1),
		('Unidade Petrobras Salvador', 'Rua Miguel Calmon', '678', 'Centro', 'Bahia', '40010-030', 1),
		
		-- Unidades da TAG
		('Unidade TAG Campinas', 'Rua dos Trabalhadores', '45', 'Jardim do Lago', 'São Paulo', '13040-450', 2),
		('Unidade TAG São José dos Campos', 'Rua Barão do Rio Branco', '432', 'Centro', 'São Paulo', '12210-000', 2),
		('Unidade TAG Ribeirão Preto', 'Av. Presidente Vargas', '999', 'Jardim Califórnia', 'São Paulo', '14010-000', 2),

		-- Unidades da NTS
		('Unidade NTS Rio de Janeiro', 'Rua da Assembleia', '100', 'Centro', 'Rio de Janeiro', '20011-000', 3),
		('Unidade NTS São Paulo', 'Rua do Rócio', '1010', 'Vila Olímpia', 'São Paulo', '04552-000', 3),
		('Unidade NTS Vitória', 'Av. Beira Mar', '400', 'Praia do Canto', 'Espírito Santo', '29055-000', 3),
		
		-- Unidades da GAS-SP 
		('Unidade GAS-SP Santos', 'Av. Ana Costa', '55', 'Gonzaga', 'São Paulo', '11060-002', 4),
		('Unidade GAS-SP Campinas', 'Rua Benjamin Constant', '789', 'Centro', 'São Paulo', '13015-000', 4),
		('Unidade GAS-SP Sorocaba', 'Av. Itavuvu', '234', 'Jardim Maria do Carmo', 'São Paulo', '18030-000', 4),

		-- Unidades da Pontal
		('Unidade Pontal Londrina', 'Av. Higienópolis', '456', 'Centro', 'Paraná', '86010-000', 5),
		('Unidade Pontal Maringá', 'Rua Joubert de Carvalho', '10', 'Centro', 'Paraná', '87010-000', 5),
		('Unidade Pontal Curitiba', 'Rua da Paz', '321', 'Centro', 'Paraná', '80010-000', 5);
       
INSERT INTO Setor (nome, descrição, fkUnidade) VALUES 

	-- Setores da Petrobás 
	
	   ('Setor Alfa', 'Setor responsável pela distribuição entre MG e ES', 1),
	   ('Setor Beta', 'Setor responsável pela distribuição entre MG e RJ', 1),
       ('Setor Gama', 'Setor responsável pela distribuição entre MG e SP', 1),
       ('Setor Delta', 'Setor responsável pela distribuição entre MG e GO', 1),
       ('Setor Ômega', 'Setor responsável pela distribuição entre MG e BA', 1),

	   ('Setor Alfa', 'Setor responsável pela distribuição entre SP e RJ', 2),
	   ('Setor Beta', 'Setor responsável pela distribuição entre SP e MS', 2),
	   ('Setor Gama', 'Setor responsável pela distribuição entre SP e PR', 2),
       ('Setor Delta', 'Setor responsável pela distribuição entre SP e GO', 2),

	   ('Setor Alfa', 'Setor responsável pela distribuição entre AM e RR', 3),
	   ('Setor Beta', 'Setor responsável pela distribuição entre AM e RO', 3),
       ('Setor Gama', 'Setor responsável pela distribuição entre AM e AC', 3),


	-- Setores da TAG 
	
	   ('Setor Alfa', 'Setor responsável pela distribuição entre PI e MA', 4),
	   ('Setor Beta', 'Setor responsável pela distribuição entre PI e CE', 4),
       ('Setor Gama', 'Setor responsável pela distribuição entre PI e BA', 4),
       ('Setor Delta', 'Setor responsável pela distribuição entre PI e TO', 4),
       ('Setor Ômega', 'Setor responsável pela distribuição entre PI e PE', 4),

	   ('Setor Alfa', 'Setor responsável pela distribuição entre PA e TO', 5),
	   ('Setor Beta', 'Setor responsável pela distribuição entre PA e MT', 5),
	   ('Setor Gama', 'Setor responsável pela distribuição entre PA e AM', 5),
       ('Setor Delta', 'Setor responsável pela distribuição entre PA e AP', 5),

	   ('Setor Alfa', 'Setor responsável pela distribuição entre MT e MS', 6),
	   ('Setor Beta', 'Setor responsável pela distribuição entre MT e GO', 6),
       ('Setor Gama', 'Setor responsável pela distribuição entre MT e RO', 6),

	-- Setores da NTS 

	   ('Setor Alfa', 'Setor responsável pela distribuição entre PA e MA', 7),
	   ('Setor Beta', 'Setor responsável pela distribuição entre PA e MT', 7),
       ('Setor Gama', 'Setor responsável pela distribuição entre PA e AM', 7),
       ('Setor Delta', 'Setor responsável pela distribuição entre PA e RR', 7),
       ('Setor Ômega', 'Setor responsável pela distribuição entre PA e AP', 7),

	   ('Setor Alfa', 'Setor responsável pela distribuição entre MT e TO', 8),
	   ('Setor Beta', 'Setor responsável pela distribuição entre MT e PA', 8),
	   ('Setor Gama', 'Setor responsável pela distribuição entre MT e MS', 8),
       ('Setor Delta', 'Setor responsável pela distribuição entre MT e PA', 8),

	   ('Setor Alfa', 'Setor responsável pela distribuição entre MG e ES', 9),
	   ('Setor Beta', 'Setor responsável pela distribuição entre MG e SP', 9),
       ('Setor Gama', 'Setor responsável pela distribuição entre MG e RJ', 9),

	-- Setores da Gas-SP

	   ('Setor Alfa', 'Setor responsável pela distribuição entre AM e RR', 10),
	   ('Setor Beta', 'Setor responsável pela distribuição entre AM e AC', 10),
       ('Setor Gama', 'Setor responsável pela distribuição entre AM e RO', 10),
       ('Setor Delta', 'Setor responsável pela distribuição entre AM e MT', 10),
       ('Setor Ômega', 'Setor responsável pela distribuição entre AM e PA', 10),

	   ('Setor Alfa', 'Setor responsável pela distribuição entre MS e MT', 11),
	   ('Setor Beta', 'Setor responsável pela distribuição entre MS e GO', 11),
	   ('Setor Gama', 'Setor responsável pela distribuição entre MS e MG', 11),
       ('Setor Delta', 'Setor responsável pela distribuição entre MS e SP', 11),

	   ('Setor Alfa', 'Setor responsável pela distribuição entre PB e RN', 12),
	   ('Setor Beta', 'Setor responsável pela distribuição entre PB e PE', 12),
       ('Setor Gama', 'Setor responsável pela distribuição entre PB e CE', 12),

	   
	-- Setores da Pontal 

	   ('Setor Alfa', 'Setor responsável pela distribuição entre BA e TO', 13),
	   ('Setor Beta', 'Setor responsável pela distribuição entre BA e PI', 13),
       ('Setor Gama', 'Setor responsável pela distribuição entre BA e MG', 13),
       ('Setor Delta', 'Setor responsável pela distribuição entre BA e ES', 13),
       ('Setor Ômega', 'Setor responsável pela distribuição entre BA e SE', 13),

	   ('Setor Alfa', 'Setor responsável pela distribuição entre BA e GO', 14),
	   ('Setor Beta', 'Setor responsável pela distribuição entre BA e TO', 14),
	   ('Setor Gama', 'Setor responsável pela distribuição entre BA e MA', 14),
       ('Setor Delta', 'Setor responsável pela distribuição entre BA e PE', 14),

	   ('Setor Alfa', 'Setor responsável pela distribuição entre MG e RJ', 15),
	   ('Setor Beta', 'Setor responsável pela distribuição entre MG e SP', 15),
       ('Setor Gama', 'Setor responsável pela distribuição entre MG e ES', 15);

       
INSERT INTO Sensor (nome, dtInstalação, dtÚltimaManutenção, fkSetor) VALUES 
	   ('Sensor de Gás A', '2024-01-10 08:00:00', '2024-01-15 09:30:00', 1),
       ('Sensor de Gás B', '2023-01-10 10:00:00', '2024-02-10 11:00:00', 1),
       ('Sensor de Gás C', '2024-01-10 14:00:00', '2024-03-01 15:30:00', 1),
       ('Sensor de Gás D', '2023-01-10 09:00:00', '2024-04-05 10:45:00', 1),
       ('Sensor de Gás E', '2024-01-10 07:30:00', '2024-05-12 08:00:00', 1),

	   ('Sensor de Gás A', '2024-01-10 08:00:00', '2024-06-15 09:30:00', 2),
       ('Sensor de Gás B', '2023-12-01 10:00:00', '2024-07-10 11:00:00', 2),
       ('Sensor de Gás C', '2024-02-05 14:00:00', '2024-08-01 15:30:00', 2),
       ('Sensor de Gás D', '2023-11-20 09:00:00', '2024-07-05 10:45:00', 2),
       ('Sensor de Gás E', '2024-03-10 07:30:00', '2024-09-12 08:00:00', 2),

	   ('Sensor de Gás A', '2024-01-10 08:00:00', '2024-01-15 09:30:00', 3),
       ('Sensor de Gás B', '2023-12-01 10:00:00', '2024-02-10 11:00:00', 3),
       ('Sensor de Gás C', '2024-02-05 14:00:00', '2024-03-01 15:30:00', 3),
       ('Sensor de Gás D', '2023-11-20 09:00:00', '2024-04-05 10:45:00', 3),
       ('Sensor de Gás E', '2024-03-10 07:30:00', '2024-05-12 08:00:00', 3),

	   ('Sensor de Gás A', '2024-01-10 08:00:00', '2024-06-15 09:30:00', 4),
       ('Sensor de Gás B', '2023-12-01 10:00:00', '2024-07-10 11:00:00', 4),
       ('Sensor de Gás C', '2024-02-05 14:00:00', '2024-08-01 15:30:00', 4),
       ('Sensor de Gás D', '2023-11-20 09:00:00', '2024-07-05 10:45:00', 4),
       ('Sensor de Gás E', '2024-03-10 07:30:00', '2024-09-12 08:00:00', 4),

	   ('Sensor de Gás A', '2024-01-10 08:00:00', '2024-01-15 09:30:00', 5),
       ('Sensor de Gás B', '2023-12-01 10:00:00', '2024-02-10 11:00:00', 5),
       ('Sensor de Gás C', '2024-02-05 14:00:00', '2024-03-01 15:30:00', 5),
       ('Sensor de Gás D', '2023-11-20 09:00:00', '2024-04-05 10:45:00', 5),
       ('Sensor de Gás E', '2024-03-10 07:30:00', '2024-05-12 08:00:00', 5),

	   ('Sensor de Gás A', '2024-01-10 08:00:00', '2024-01-15 09:30:00', 6),
       ('Sensor de Gás B', '2023-01-10 10:00:00', '2024-02-10 11:00:00', 6),
       ('Sensor de Gás C', '2024-01-10 14:00:00', '2024-03-01 15:30:00', 6),
       ('Sensor de Gás D', '2023-01-10 09:00:00', '2024-04-05 10:45:00', 6),
       ('Sensor de Gás E', '2024-01-10 07:30:00', '2024-05-12 08:00:00', 6),

	   ('Sensor de Gás A', '2024-01-10 08:00:00', '2024-01-15 09:30:00', 7),
       ('Sensor de Gás B', '2023-01-10 10:00:00', '2024-02-10 11:00:00', 7),
       ('Sensor de Gás C', '2024-01-10 14:00:00', '2024-03-01 15:30:00', 7),
       ('Sensor de Gás D', '2023-01-10 09:00:00', '2024-04-05 10:45:00', 7),
       ('Sensor de Gás E', '2024-01-10 07:30:00', '2024-05-12 08:00:00', 7),

	   ('Sensor de Gás A', '2024-01-10 08:00:00', '2024-01-15 09:30:00', 8),
       ('Sensor de Gás B', '2023-01-10 10:00:00', '2024-02-10 11:00:00', 8),
       ('Sensor de Gás C', '2024-01-10 14:00:00', '2024-03-01 15:30:00', 8),
       ('Sensor de Gás D', '2023-01-10 09:00:00', '2024-04-05 10:45:00', 8),
       ('Sensor de Gás E', '2024-01-10 07:30:00', '2024-05-12 08:00:00', 8),

	   ('Sensor de Gás A', '2024-01-10 08:00:00', '2024-01-15 09:30:00', 9),
       ('Sensor de Gás B', '2023-01-10 10:00:00', '2024-02-10 11:00:00', 9),
       ('Sensor de Gás C', '2024-01-10 14:00:00', '2024-03-01 15:30:00', 9),
       ('Sensor de Gás D', '2023-01-10 09:00:00', '2024-04-05 10:45:00', 9),
       ('Sensor de Gás E', '2024-01-10 07:30:00', '2024-05-12 08:00:00', 9),

	   ('Sensor de Gás A', '2024-01-10 08:00:00', '2024-01-15 09:30:00', 10),
       ('Sensor de Gás B', '2023-01-10 10:00:00', '2024-02-10 11:00:00', 10),
       ('Sensor de Gás C', '2024-01-10 14:00:00', '2024-03-01 15:30:00', 10),
       ('Sensor de Gás D', '2023-01-10 09:00:00', '2024-04-05 10:45:00', 10),
       ('Sensor de Gás E', '2024-01-10 07:30:00', '2024-05-12 08:00:00', 10),

	   ('Sensor de Gás A', '2024-01-10 08:00:00', '2024-01-15 09:30:00', 11),
       ('Sensor de Gás B', '2023-01-10 10:00:00', '2024-02-10 11:00:00', 11),
       ('Sensor de Gás C', '2024-01-10 14:00:00', '2024-03-01 15:30:00', 11),
       ('Sensor de Gás D', '2023-01-10 09:00:00', '2024-04-05 10:45:00', 11),
       ('Sensor de Gás E', '2024-01-10 07:30:00', '2024-05-12 08:00:00', 11),
	   
	   ('Sensor de Gás A', '2024-01-10 08:00:00', '2024-01-15 09:30:00', 12),
       ('Sensor de Gás B', '2023-01-10 10:00:00', '2024-02-10 11:00:00', 12),
       ('Sensor de Gás C', '2024-01-10 14:00:00', '2024-03-01 15:30:00', 12),
       ('Sensor de Gás D', '2023-01-10 09:00:00', '2024-04-05 10:45:00', 12),
       ('Sensor de Gás E', '2024-01-10 07:30:00', '2024-05-12 08:00:00', 12),
	   
	   ('Sensor de Gás A', '2024-01-10 08:00:00', '2024-01-15 09:30:00', 13),
       ('Sensor de Gás B', '2023-01-10 10:00:00', '2024-02-10 11:00:00', 13),
       ('Sensor de Gás C', '2024-01-10 14:00:00', '2024-03-01 15:30:00', 13),
       ('Sensor de Gás D', '2023-01-10 09:00:00', '2024-04-05 10:45:00', 13),
       ('Sensor de Gás E', '2024-01-10 07:30:00', '2024-05-12 08:00:00', 13),

	   ('Sensor de Gás A', '2024-01-10 08:00:00', '2024-01-15 09:30:00', 14),
       ('Sensor de Gás B', '2023-01-10 10:00:00', '2024-02-10 11:00:00', 14),
       ('Sensor de Gás C', '2024-01-10 14:00:00', '2024-03-01 15:30:00', 14),
       ('Sensor de Gás D', '2023-01-10 09:00:00', '2024-04-05 10:45:00', 14),
       ('Sensor de Gás E', '2024-01-10 07:30:00', '2024-05-12 08:00:00', 14);
       
INSERT INTO Medição (qtdGásVazado, dtComeçoVazamento, fkSensor) VALUES
	   (20, '2024-09-15 13:00:00', 1),
       (35, '2024-09-16 10:30:00', 6),
       (10, '2024-09-17 16:45:00', 11),
       (50, '2024-09-18 09:00:00', 16),
       (40, '2024-09-19 11:15:00', 21);
       
       
INSERT INTO Usuario (nome, email, senha, fkEmpresa) VALUES 
	   ('João Silva', 'joao.silva@empresa.com', 'senhaSegura123', 1),
       ('Maria Souza', 'maria.souza@empresa.com', 'senhaForte456', 2),
       ('Pedro Lima', 'pedro.lima@empresa.com', 'senhaResistente789', 3),
       ('Ana Costa', 'ana.costa@empresa.com', 'senhaComplexa321', 4),
       ('Carlos Mendes', 'carlos.mendes@empresa.com', 'senhaDifícil654', 5);
       

INSERT INTO Login (dtHrAcesso, dtHrSaída, fkUsuario) VALUES 
	   ('2024-10-01 09:00:00', '2024-10-01 09:30:00', 1),
       ('2024-10-02 10:00:00', '2024-10-02 10:30:00', 2),
       ('2024-10-03 10:15:00', '2024-10-03 11:15:00', 3),
       ('2024-10-04 12:45:00', '2024-10-04 13:45:00', 4),
       ('2024-10-05 18:30:00', '2024-10-05 19:00:00', 5);
       
-- Exemplos de Select's

SELECT * FROM empresa
	JOIN unidade 
		ON fkempresa = idEmpresa;
       
SELECT empresa.nome AS Empresa, 
	responsavel AS dono, 
		telefone AS contato, 
			concat ('Endereço:' , Logradouro , ' - ', numero ,' - ', bairro ,' - ', estado,' - ' , cep) 
				AS Endereço FROM  Empresa 
					JOIN Unidade ON fkempresa = idEmpresa;
       
SELECT * FROM Setor 
	JOIN Sensor 
		ON fkSetor = idSetor;
       
SELECT Setor.nome AS Setor, 
	Descrição AS Descrição, 
		sensor.nome AS Sensor, 
			dtInstalação AS 'Data de Instalação', 
				ifnull(dtÚltimaManutenção , 'Sem manutenção') AS 'Ultima manutenção'
					FROM Setor JOIN Sensor 
						ON fkSetor = idSetor;
       
SELECT * FROM Sensor 
	JOIN Medição 
		ON fkSensor = idSensor; 
       
SELECT Sensor.nome AS Nome, 
	qtdGásvazado AS 'Gás Vazado', 
		dtComeçoVazamento AS 'Data começo do vazamento' 
			FROM Sensor 
				JOIN Medição 
					ON fksensor =  idSensor;  
                    
SELECT * FROM Login 
	JOIN Usuario 
		ON fkUsuario = idUsuario;

SELECT Usuario.nome AS Nome, 
	dtHracesso AS Acesso, 
		dtHrSaída AS Saída 
			FROM Usuario 
				JOIN Login ON fkUsuario = idUsuario;
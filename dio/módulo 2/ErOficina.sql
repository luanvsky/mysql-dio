     CREATE TABLE Clientes (
         ID_Cliente INT PRIMARY KEY,
         Nome VARCHAR(100),
         Telefone VARCHAR(15),
         Endereço VARCHAR(255)
     );

     CREATE TABLE Veículos (
         ID_Veículo INT PRIMARY KEY,
         Placa VARCHAR(10),
         Modelo VARCHAR(50),
         Ano INT,
         ID_Cliente INT,
         FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente)
     );

     CREATE TABLE Serviços (
         ID_Serviço INT PRIMARY KEY,
         Descrição VARCHAR(255),
         Preço DECIMAL(10, 2)
     );

     CREATE TABLE Funcionários (
         ID_Funcionário INT PRIMARY KEY,
         Nome VARCHAR(100),
         Função VARCHAR(50),
         Salário DECIMAL(10, 2)
     );

     CREATE TABLE Peças (
         ID_Peça INT PRIMARY KEY,
         Descrição VARCHAR(255),
         Quantidade INT,
         Preço DECIMAL(10, 2)
     );

     CREATE TABLE Ordens_de_Serviço (
         ID_Ordem INT PRIMARY KEY,
         ID_Cliente INT,
         ID_Veículo INT,
         ID_Funcionário INT,
         Data DATE,
         Status VARCHAR(50),
         FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente),
         FOREIGN KEY (ID_Veículo) REFERENCES Veículos(ID_Veículo),
         FOREIGN KEY (ID_Funcionário) REFERENCES Funcionários(ID_Funcionário)
     );

     CREATE TABLE Peças_Ordem (
         ID_Ordem INT,
         ID_Peça INT,
         Quantidade INT,
         FOREIGN KEY (ID_Ordem) REFERENCES Ordens_de_Serviço(ID_Ordem),
         FOREIGN KEY (ID_Peça) REFERENCES Peças(ID_Peça),
         PRIMARY KEY (ID_Ordem, ID_Peça)
     );

     CREATE TABLE Serviços_Ordem (
         ID_Ordem INT,
         ID_Serviço INT,
         Preço DECIMAL(10, 2),
         FOREIGN KEY (ID_Ordem) REFERENCES Ordens_de_Serviço(ID_Ordem),
         FOREIGN KEY (ID_Serviço) REFERENCES Serviços(ID_Serviço),
         PRIMARY KEY (ID_Ordem, ID_Serviço)
     );
     
     
     -- Inserindo dados na tabela Clientes
INSERT INTO Clientes (ID_Cliente, Nome, Telefone, Endereço)
VALUES (1, 'João Silva', '1234-5678', 'Rua A, 123'),
       (2, 'Maria Oliveira', '9876-5432', 'Rua B, 456'),
       (3, 'Carlos Santos', '1111-2222', 'Rua C, 789');

-- Inserindo dados na tabela Veículos
INSERT INTO Veículos (ID_Veículo, Placa, Modelo, Ano, ID_Cliente)
VALUES (1, 'ABC-1234', 'Ford Ka', 2019, 1),
       (2, 'DEF-5678', 'Chevrolet Onix', 2018, 2),
       (3, 'GHI-9101', 'Renault Sandero', 2020, 3);

-- Inserindo dados na tabela Serviços
INSERT INTO Serviços (ID_Serviço, Descrição, Preço)
VALUES (1, 'Troca de Óleo', 150.00),
       (2, 'Alinhamento e Balanceamento', 200.00),
       (3, 'Revisão Completa', 500.00);

-- Inserindo dados na tabela Funcionários
INSERT INTO Funcionários (ID_Funcionário, Nome, Função, Salário)
VALUES (1, 'Paulo Souza', 'Mecânico', 3000.00),
       (2, 'Ana Lima', 'Eletricista', 3500.00),
       (3, 'Roberto Faria', 'Auxiliar', 2000.00);

-- Inserindo dados na tabela Peças
INSERT INTO Peças (ID_Peça, Descrição, Quantidade, Preço)
VALUES (1, 'Filtro de Óleo', 50, 30.00),
       (2, 'Pastilha de Freio', 100, 120.00),
       (3, 'Velas de Ignição', 75, 45.00);

-- Inserindo dados na tabela Ordens de Serviço
INSERT INTO Ordens_de_Serviço (ID_Ordem, ID_Cliente, ID_Veículo, ID_Funcionário, Data, Status)
VALUES (1, 1, 1, 1, '2024-01-15', 'Concluído'),
       (2, 2, 2, 2, '2024-02-20', 'Em andamento'),
       (3, 3, 3, 3, '2024-03-10', 'Pendente');

-- Inserindo dados na tabela Peças_Ordem
INSERT INTO Peças_Ordem (ID_Ordem, ID_Peça, Quantidade)
VALUES (1, 1, 2),
       (2, 2, 4),
       (3, 3, 1);

-- Inserindo dados na tabela Serviços_Ordem
INSERT INTO Serviços_Ordem (ID_Ordem, ID_Serviço, Preço)
VALUES (1, 1, 150.00),
       (2, 2, 200.00),
       (3, 3, 500.00);
       
       
SELECT c.Nome AS Cliente, v.Modelo AS Veículo, o.Status AS Status_Ordem
FROM Clientes c
JOIN Veículos v ON c.ID_Cliente = v.ID_Cliente
JOIN Ordens_de_Serviço o ON v.ID_Veículo = o.ID_Veículo;


SELECT o.ID_Ordem, s.Descrição AS Serviço, p.Descrição AS Peça
FROM Ordens_de_Serviço o
JOIN Serviços_Ordem so ON o.ID_Ordem = so.ID_Ordem
JOIN Serviços s ON so.ID_Serviço = s.ID_Serviço
JOIN Peças_Ordem po ON o.ID_Ordem = po.ID_Ordem
JOIN Peças p ON po.ID_Peça = p.ID_Peça
WHERE o.ID_Ordem = 1;


SELECT f.Nome AS Funcionário, c.Nome AS Cliente, o.ID_Ordem, o.Status
FROM Funcionários f
JOIN Ordens_de_Serviço o ON f.ID_Funcionário = o.ID_Funcionário
JOIN Clientes c ON o.ID_Cliente = c.ID_Cliente;


SELECT c.Nome AS Cliente, s.Descrição AS Serviço, so.Preço
FROM Clientes c
JOIN Ordens_de_Serviço o ON c.ID_Cliente = o.ID_Cliente
JOIN Serviços_Ordem so ON o.ID_Ordem = so.ID_Ordem
JOIN Serviços s ON so.ID_Serviço = s.ID_Serviço;



SELECT o.ID_Ordem, c.Nome AS Cliente, v.Modelo AS Veículo, f.Nome AS Funcionário, SUM(po.Quantidade) AS Total_Peças
FROM Ordens_de_Serviço o
JOIN Clientes c ON o.ID_Cliente = c.ID_Cliente
JOIN Veículos v ON o.ID_Veículo = v.ID_Veículo
JOIN Funcionários f ON o.ID_Funcionário = f.ID_Funcionário
JOIN Peças_Ordem po ON o.ID_Ordem = po.ID_Ordem
GROUP BY o.ID_Ordem, c.Nome, v.Modelo, f.Nome;


SELECT * FROM Clientes;
-- Utiliza a cláusula SELECT para recuperar todos os registros da tabela Clientes.

-- Filtros com WHERE Statement:
SELECT * FROM Veículos WHERE Ano > 2015;
-- Aplica a cláusula WHERE para filtrar veículos fabricados após o ano de 2015.

-- Criação de Atributos Derivados:
SELECT Nome, Salário * 12 AS Salário_Anual FROM Funcionários;
-- Cria um atributo derivado Salário_Anual multiplicando o salário mensal por 12.

-- Ordenação dos Dados com ORDER BY:
SELECT * FROM Clientes ORDER BY Nome;
-- Ordena os registros da tabela Clientes por nome em ordem alfabética.

-- Filtros aos Grupos com HAVING Statement:
SELECT ID_Cliente, COUNT(*) as Total_Ordens
FROM Ordens_de_Serviço
GROUP BY ID_Cliente
HAVING COUNT(*) > 5;


SELECT c.Nome AS Cliente, v.Modelo AS Veículo, o.Status AS Status_Ordem
FROM Clientes c
JOIN Veículos v ON c.ID_Cliente = v.ID_Cliente
JOIN Ordens_de_Serviço o ON v.ID_Veículo = o.ID_Veículo;

-- Obtêm a descrição dos serviços e as peças utilizadas em uma ordem de serviço específica.
SELECT o.ID_Ordem, s.Descrição AS Serviço, p.Descrição AS Peça
FROM Ordens_de_Serviço o
JOIN Serviços_Ordem so ON o.ID_Ordem = so.ID_Ordem
JOIN Serviços s ON so.ID_Serviço = s.ID_Serviço
JOIN Peças_Ordem po ON o.ID_Ordem = po.ID_Ordem
JOIN Peças p ON po.ID_Peça = p.ID_Peça
WHERE o.ID_Ordem = 1;

-- Mostra os funcionários junto com as ordens de serviço que eles realizaram e o cliente correspondente
SELECT f.Nome AS Funcionário, c.Nome AS Cliente, o.ID_Ordem, o.Status
FROM Funcionários f
JOIN Ordens_de_Serviço o ON f.ID_Funcionário = o.ID_Funcionário
JOIN Clientes c ON o.ID_Cliente = c.ID_Cliente;

-- Lista os clientes e os preços dos serviços que eles contrataram:
SELECT c.Nome AS Cliente, s.Descrição AS Serviço, so.Preço
FROM Clientes c
JOIN Ordens_de_Serviço o ON c.ID_Cliente = o.ID_Cliente
JOIN Serviços_Ordem so ON o.ID_Ordem = so.ID_Ordem
JOIN Serviços s ON so.ID_Serviço = s.ID_Serviço;

-- Obtêm um resumo das ordens de serviço, incluindo o cliente, o veículo, o funcionário responsável e o total de peças usadas
SELECT o.ID_Ordem, c.Nome AS Cliente, v.Modelo AS Veículo, f.Nome AS Funcionário, SUM(po.Quantidade) AS Total_Peças
FROM Ordens_de_Serviço o
JOIN Clientes c ON o.ID_Cliente = c.ID_Cliente
JOIN Veículos v ON o.ID_Veículo = v.ID_Veículo
JOIN Funcionários f ON o.ID_Funcionário = f.ID_Funcionário
JOIN Peças_Ordem po ON o.ID_Ordem = po.ID_Ordem
GROUP BY o.ID_Ordem, c.Nome, v.Modelo, f.Nome;



SELECT c.Nome AS Cliente, v.Modelo AS Veículo, o.Status AS Status_Ordem
FROM Clientes c
JOIN Veículos v ON c.ID_Cliente = v.ID_Cliente
JOIN Ordens_de_Serviço o ON v.ID_Veículo = o.ID_Veículo;


SELECT o.ID_Ordem, s.Descrição AS Serviço, p.Descrição AS Peça
FROM Ordens_de_Serviço o
JOIN Serviços_Ordem so ON o.ID_Ordem = so.ID_Ordem
JOIN Serviços s ON so.ID_Serviço = s.ID_Serviço
JOIN Peças_Ordem po ON o.ID_Ordem = po.ID_Ordem
JOIN Peças p ON po.ID_Peça = p.ID_Peça
WHERE o.ID_Ordem = 1;


SELECT f.Nome AS Funcionário, c.Nome AS Cliente, o.ID_Ordem, o.Status
FROM Funcionários f
JOIN Ordens_de_Serviço o ON f.ID_Funcionário = o.ID_Funcionário
JOIN Clientes c ON o.ID_Cliente = c.ID_Cliente;


SELECT c.Nome AS Cliente, s.Descrição AS Serviço, so.Preço
FROM Clientes c
JOIN Ordens_de_Serviço o ON c.ID_Cliente = o.ID_Cliente
JOIN Serviços_Ordem so ON o.ID_Ordem = so.ID_Ordem
JOIN Serviços s ON so.ID_Serviço = s.ID_Serviço;

SELECT o.ID_Ordem, c.Nome AS Cliente, v.Modelo AS Veículo, f.Nome AS Funcionário, SUM(po.Quantidade) AS Total_Peças
FROM Ordens_de_Serviço o
JOIN Clientes c ON o.ID_Cliente = c.ID_Cliente
JOIN Veículos v ON o.ID_Veículo = v.ID_Veículo
JOIN Funcionários f ON o.ID_Funcionário = f.ID_Funcionário
JOIN Peças_Ordem po ON o.ID_Ordem = po.ID_Ordem
GROUP BY o.ID_Ordem, c.Nome, v.Modelo, f.Nome;

       
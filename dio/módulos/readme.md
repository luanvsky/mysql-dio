# 🗃️ Diagrama Entidade-Relacionamento (DER) - DICOF

## 📚 Visão Geral

Este repositório contém um modelo detalhado do **Diagrama Entidade-Relacionamento (DER)** da DICOF, apresentando suas principais entidades, relacionamentos e a estrutura do banco de dados.

## 📌 Entidades e Relacionamentos

A estrutura da DICOF é modelada com as seguintes entidades:

- **Setores**: Representam as áreas da DICOF (ex.: Conformidade, Contabilidade).
- **Pessoas**: Funcionários da DICOF, incluindo coordenadores e servidores.
- **Projetos**: Projetos desenvolvidos pela DICOF.
- **Documentos**: Documentos gerados nos processos da DICOF.
- **Etapas**: Diferentes fases de um processo.
- **Sistemas**: Sistemas utilizados nos processos.

### 🔗 Relacionamentos

- Um **setor** pode ter muitos servidores, mas um servidor pertence a apenas um setor.
- Um **projeto** pode pertencer a um único setor, mas um setor pode ter vários projetos.
- Um **documento** pertence a um único projeto, mas um projeto pode ter vários documentos.
- Uma **etapa** está associada a um único documento, e um documento pode passar por várias etapas.
- Um **projeto** pode utilizar vários sistemas.

---

## 💾 Implementação do Banco de Dados

Aqui estão os comandos SQL para a criação das tabelas e definição das chaves primárias e estrangeiras.

### 📌 Criação das Tabelas

```sql
-- Criando a tabela Setores
CREATE TABLE Setores (
    id_setor INT PRIMARY KEY,
    nome_setor VARCHAR(100),
    coordenador INT,
    FOREIGN KEY (coordenador) REFERENCES Pessoas(id_pessoa)
);

-- Criando a tabela Pessoas
CREATE TABLE Pessoas (
    id_pessoa INT PRIMARY KEY,
    nome VARCHAR(100),
    cargo VARCHAR(50),
    setor INT,
    FOREIGN KEY (setor) REFERENCES Setores(id_setor)
);

-- Criando a tabela Projetos
CREATE TABLE Projetos (
    id_projeto INT PRIMARY KEY,
    nome_projeto VARCHAR(100),
    setor INT,
    FOREIGN KEY (setor) REFERENCES Setores(id_setor)
);

-- Criando a tabela Documentos
CREATE TABLE Documentos (
    id_documento INT PRIMARY KEY,
    nome_documento VARCHAR(100),
    tipo_documento VARCHAR(50),
    projeto INT,
    FOREIGN KEY (projeto) REFERENCES Projetos(id_projeto)
);

-- Criando a tabela Etapas
CREATE TABLE Etapas (
    id_etapa INT PRIMARY KEY,
    nome_etapa VARCHAR(100),
    tempo_estimado INT,
    tempo_real INT,
    documento INT,
    FOREIGN KEY (documento) REFERENCES Documentos(id_documento)
);

-- Criando a tabela Sistemas
CREATE TABLE Sistemas (
    id_sistema INT PRIMARY KEY,
    nome_sistema VARCHAR(100),
    descricao VARCHAR(255)
);
```

✍️ Inserção de Dados

```sql
-- Inserindo dados na tabela Setores
INSERT INTO Setores (id_setor, nome_setor, coordenador) VALUES 
(1, 'Conformidade', 1),
(2, 'Contabilidade', 2);

-- Inserindo dados na tabela Pessoas
INSERT INTO Pessoas (id_pessoa, nome, cargo, setor) VALUES 
(1, 'João Silva', 'Coordenador', 1),
(2, 'Maria Souza', 'Servidor', 2);

-- Inserindo dados na tabela Projetos
INSERT INTO Projetos (id_projeto, nome_projeto, setor) VALUES 
(1, 'Projeto A', 1),
(2, 'Projeto B', 2);

-- Inserindo dados na tabela Documentos
INSERT INTO Documentos (id_documento, nome_documento, tipo_documento, projeto) VALUES 
(1, 'Documento A', 'Nota Fiscal', 1),
(2, 'Documento B', 'Relatório', 2);

-- Inserindo dados na tabela Etapas
INSERT INTO Etapas (id_etapa, nome_etapa, tempo_estimado, tempo_real, documento) VALUES 
(1, 'Criação', 5, 4, 1),
(2, 'Aprovação', 3, 3, 2);

-- Inserindo dados na tabela Sistemas
INSERT INTO Sistemas (id_sistema, nome_sistema, descricao) VALUES 
(1, 'Sistema A', 'Descrição do Sistema A'),
(2, 'Sistema B', 'Descrição do Sistema B');
```


🔍 Consultas SQL para Análises
📌 Projetos e Coordenadores Responsáveis

```sql

SELECT Projetos.nome_projeto AS Projeto, Pessoas.nome AS Coordenador
FROM Projetos
JOIN Setores ON Projetos.setor = Setores.id_setor
JOIN Pessoas ON Setores.coordenador = Pessoas.id_pessoa;
```

📌 Documentos e Seus Projetos
```sql

SELECT Documentos.nome_documento AS Documento, Projetos.nome_projeto AS Projeto
FROM Documentos
JOIN Projetos ON Documentos.projeto = Projetos.id_projeto;
```

📌 Contagem de Documentos por Setor
```sql

SELECT Setores.nome_setor AS Setor, COUNT(Documentos.id_documento) AS Numero_Documentos
FROM Documentos
JOIN Projetos ON Documentos.projeto = Projetos.id_projeto
JOIN Setores ON Projetos.setor = Setores.id_setor
GROUP BY Setores.nome_setor;
```
📌 Tempo Médio Real Gasto por Etapa

```sql
SELECT nome_etapa AS Etapa, AVG(tempo_real) AS Tempo_Medio_Real
FROM Etapas
GROUP BY nome_etapa;
```

📌 Coordenadores e Número de Projetos Sob Sua Responsabilidade
```sql

SELECT Pessoas.nome AS Coordenador, COUNT(Projetos.id_projeto) AS Numero_Projetos
FROM Pessoas
JOIN Setores ON Pessoas.id_pessoa = Setores.coordenador
JOIN Projetos ON Setores.id_setor = Projetos.setor
GROUP BY Pessoas.nome;

```
🎯 Benefícios Deste Modelo
Flexibilidade: Permite modelar diversos processos e cenários.
Detalhamento: Captura informações detalhadas, como tempo gasto em cada etapa e recursos utilizados.
Otimização de Processos: Facilita a identificação de gargalos e melhorias operacionais.
Gestão de Recursos: Auxilia no controle eficiente dos processos e documentos.































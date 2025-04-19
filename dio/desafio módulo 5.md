# ⚙️ Personalizando o Banco de Dados com Índices, Procedures, Views e Gatilhos! 🚀

## Descrição do Projeto

Este projeto visa aprimorar a performance e a segurança de bancos de dados MySQL através da implementação de índices estratégicos, stored procedures para manipulação de dados, views para personalização de acesso e triggers para automatização de tarefas.

## Parte 1 – Criando Índices em Banco de Dados 🔍

Este módulo foca na otimização de consultas no banco de dados `company` através da criação de índices.

### Consultas a serem otimizadas:

1.  Qual o departamento com maior número de pessoas?
2.  Quais são os departamentos por cidade?
3.  Relação de empregados por departamento

### Criação dos Índices:

```sql
ALTER TABLE employee ADD INDEX idx_dno (Dno);
ALTER TABLE dept_locations ADD INDEX idx_dnumber (Dnumber);
-- Considerações sobre o índice da chave primária `Dnumber` na tabela `departament`.

-- Queries para responder às perguntas (para referência):

SELECT d.Dname, COUNT(e.Ssn) AS NumeroDeEmpregados
FROM departament d
JOIN employee e ON d.Dnumber = e.Dno
GROUP BY d.Dname
ORDER BY NumeroDeEmpregados DESC
LIMIT 1;

SELECT d.Dname AS Departamento, dl.Dlocation AS Cidade
FROM departament d
JOIN dept_locations dl ON d.Dnumber = dl.Dnumber
ORDER BY d.Dname, dl.Dlocation;

SELECT d.Dname AS Departamento, e.Fname, e.Lname
FROM departament d
JOIN employee e ON d.Dnumber = e.Dno
ORDER BY d.Dname, e.Lname, e.Fname;
````


## Justificativa dos Índices:
`idx_dno` em employee: Otimiza consultas que filtram ou agrupam empregados por departamento.
`idx_dnumber` em dept_locations: Acelera a junção com a tabela departament para consultas baseadas em localização.
A chave primária Dnumber em departament já possui um índice eficiente.

## Parte 2 - Utilização de Procedures para Manipulação de Dados ✍️
Criação de uma stored procedure para inserir, remover e atualizar dados em bancos de dados (universidade e e-commerce).
````sql

Script SQL da Stored Procedure:

-- Seleciona o banco de dados para a procedure (você pode escolher um ou criar a procedure sem um banco padrão)
-- USE universidade;
DELIMITER //

CREATE PROCEDURE ManipulaDados (
    IN controle INT,
    IN tabela VARCHAR(50),
    IN id_val INT,
    IN nome_val VARCHAR(255),
    IN curso_preco_val VARCHAR(255) -- Usaremos para curso em universidade e preço em e-commerce
)
BEGIN
    CASE controle
        WHEN 1 THEN
            -- Exemplo de SELECT (para demonstração)
            IF tabela = 'alunos' THEN
                SELECT id, nome, curso FROM universidade.alunos WHERE id = id_val;
            ELSEIF tabela = 'produtos' THEN
                SELECT id, nome, preco FROM e_commerce.produtos WHERE id = id_val;
            ELSE
                SELECT 'Tabela não suportada para SELECT.';
            END IF;

        WHEN 2 THEN
            -- Exemplo de UPDATE
            IF tabela = 'alunos' THEN
                UPDATE universidade.alunos SET nome = nome_val, curso = curso_preco_val WHERE id = id_val;
                SELECT ROW_COUNT() AS linhas_afetadas;
            ELSEIF tabela = 'produtos' THEN
                UPDATE e_commerce.produtos SET nome = nome_val, preco = curso_preco_val WHERE id = id_val;
                SELECT ROW_COUNT() AS linhas_afetadas;
            ELSE
                SELECT 'Tabela não suportada para UPDATE.';
            END IF;

        WHEN 3 THEN
            -- Exemplo de DELETE
            IF tabela = 'alunos' THEN
                DELETE FROM universidade.alunos WHERE id = id_val;
                SELECT ROW_COUNT() AS linhas_afetadas;
            ELSEIF tabela = 'produtos' THEN
                DELETE FROM e_commerce.produtos WHERE id = id_val;
                SELECT ROW_COUNT() AS linhas_afetadas;
            ELSE
                SELECT 'Tabela não suportada para DELETE.';
            END IF;

        ELSE
            SELECT 'Opção de controle inválida.';
    END CASE;
END //

DELIMITER ;

-- Para atualizar um aluno no banco de dados 'universidade':
CALL ManipulaDados(2, 'alunos', 1, 'Nome Atualizado', 'Curso Atualizado');

-- Para deletar um produto no banco de dados 'e-commerce':
CALL ManipulaDados(3, 'produtos', 5, NULL, NULL);

-- Para tentar selecionar um aluno:
CALL ManipulaDados(1, 'alunos', 1, NULL, NULL);

-- Para tentar uma operação em uma tabela não suportada:
CALL ManipulaDados(2, 'outra_tabela', 1, 'Valor', 'Outro Valor');
````


## Parte 3 – Personalizando acessos com views 👓
Criação de views para diferentes cenários no banco de dados company e definição de permissões de acesso.
Criação das Views:

````sql
CREATE VIEW vw_empregados_por_departamento_localidade AS
SELECT
    d.Dname AS Departamento,
    dl.Dlocation AS Localidade,
    COUNT(e.Ssn) AS NumeroDeEmpregados
FROM departament d
JOIN dept_locations dl ON d.Dnumber = dl.Dnumber
LEFT JOIN employee e ON d.Dnumber = e.Dno
GROUP BY d.Dname, dl.Dlocation
ORDER BY d.Dname, dl.Dlocation;

CREATE VIEW vw_departamentos_gerentes AS
SELECT
    d.Dname AS Departamento,
    e.Fname AS GerenteNome,
    e.Lname AS GerenteSobrenome
FROM departament d
JOIN employee e ON d.Mgr_ssn = e.Ssn;

CREATE VIEW vw_projetos_mais_empregados AS
SELECT
    p.Pname AS Projeto,
    COUNT(wo.Essn) AS NumeroDeEmpregados
FROM project p
LEFT JOIN works_on wo ON p.Pnumber = wo.Pno
GROUP BY p.Pname
ORDER BY NumeroDeEmpregados DESC;

CREATE VIEW vw_empregados_com_dependentes_gerentes AS
SELECT
    e.Fname AS EmpregadoNome,
    e.Lname AS EmpregadoSobrenome,
    (SELECT COUNT(*) FROM dependent dep WHERE dep.Essn = e.Ssn) AS NumeroDeDependentes,
    CASE
        WHEN e.Ssn IN (SELECT Mgr_ssn FROM departament) THEN 'Sim'
        ELSE 'Não'
    END AS EhGerente
FROM employee e
WHERE EXISTS (SELECT 1 FROM dependent dep WHERE dep.Essn = e.Ssn)
ORDER BY e.Lname, e.Fname;

-- Criação do usuário gerente 💼
CREATE USER 'gerente'@'localhost' IDENTIFIED BY 'senha_gerente';
GRANT SELECT ON company.vw_empregados_por_departamento_localidade TO 'gerente'@'localhost';
GRANT SELECT ON company.vw_departamentos_gerentes TO 'gerente'@'localhost';
GRANT SELECT ON company.employee TO 'gerente'@'localhost';
GRANT SELECT ON company.departament TO 'gerente'@'localhost';

-- Criação do usuário employee 🧑‍💻
CREATE USER 'employee'@'localhost' IDENTIFIED BY 'senha_employee';
GRANT SELECT ON company.employee TO 'employee'@'localhost';
REVOKE SELECT ON company.departament FROM 'employee'@'localhost';
REVOKE SELECT ON company.vw_empregados_por_departamento_localidade FROM 'employee'@'localhost';
REVOKE SELECT ON company.vw_departamentos_gerentes FROM 'employee'@'localhost';

FLUSH PRIVILEGES;
````


## Parte 4 – Criando gatilhos para cenário de e-commerce 🛒
Implementação de triggers para o banco de dados ecommerce.

Triggers de remoção: before delete em usuarios 👋

````sql
-- Certifique-se de estar no banco de dados correto
-- USE ecommerce;

DELIMITER //

CREATE TRIGGER before_delete_usuario
BEFORE DELETE ON usuarios
FOR EACH ROW
BEGIN
    INSERT INTO historico_remocao_usuarios (id_usuario, nome_usuario, email_usuario, data_exclusao)
    VALUES (OLD.id_usuario, OLD.nome_usuario, OLD.email_usuario, NOW());
END //

DELIMITER ;

-- Triggers de atualização: before update em colaboradores 💰
-- Certifique-se de estar no banco de dados correto
-- USE ecommerce;

DELIMITER //

CREATE TRIGGER before_update_salario_colaborador
BEFORE UPDATE ON colaboradores
FOR EACH ROW
BEGIN
    IF NEW.salario_base <> OLD.salario_base THEN
        SET NEW.data_atualizacao_salario = NOW();
    END IF;
END //

DELIMITER ;
````
# 🎉 Desafio Concluído! 🏆


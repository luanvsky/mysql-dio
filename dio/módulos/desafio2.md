# ⚙️ Personalizando o Banco de Dados com Views e Gatilhos! 🚀

## Parte 1 – Personalizando acessos com views 👓

Nesta etapa incrível, criamos views super úteis para o banco de dados `company`! 🏢 Olha só que maravilha:

**1. 📊 Número de empregados por departamento e localidade:**

```sql
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

````

**2. 🏢 Lista de departamentos e seus gerentes 👑:

```sql

CREATE VIEW vw_departamentos_gerentes AS
SELECT
    d.Dname AS Departamento,
    e.Fname AS GerenteNome,
    e.Lname AS GerenteSobrenome
FROM departament d
JOIN employee e ON d.Mgr_ssn = e.Ssn;
````

**3. 🏆 Projetos com maior número de empregados (por ordenação desc) 💪:
```sql
CREATE VIEW vw_projetos_mais_empregados AS
SELECT
    p.Pname AS Projeto,
    COUNT(wo.Essn) AS NumeroDeEmpregados
FROM project p
LEFT JOIN works_on wo ON p.Pnumber = wo.Pno
````

**4. 📑 Lista de projetos, departamentos e gerentes 🤝:

```sql
CREATE VIEW vw_projetos_departamentos_gerentes AS
SELECT
    p.Pname AS Projeto,
    d.Dname AS Departamento,
    e.Fname AS GerenteNome,
    e.Lname AS GerenteSobrenome
FROM project p
JOIN departament d ON p.Dnum = d.Dnumber
JOIN employee e ON d.Mgr_ssn = e.Ssn
ORDER BY p.Pname;

GROUP BY p.Pname
ORDER BY NumeroDeEmpregados DESC;
```

**5. 🤔 Quais empregados possuem dependentes e se são gerentes? 👨‍👩‍👧‍👦👑:
````sql
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
````


**🔒 Definindo Permissões de Acesso às Views 🛡️:
Criamos usuários especiais com permissões sob medida! 🦸
````sq
-- Criação do usuário gerente 💼
CREATE USER 'gerente'@'localhost' IDENTIFIED BY 'senha_gerente';

-- Concede permissão de SELECT nas views vw_empregados_por_departamento_localidade e vw_departamentos_gerentes ✅
GRANT SELECT ON company.vw_empregados_por_departamento_localidade TO 'gerente'@'localhost';
GRANT SELECT ON company.vw_departamentos_gerentes TO 'gerente'@'localhost';
GRANT SELECT ON company.employee TO 'gerente'@'localhost';
GRANT SELECT ON company.departament TO 'gerente'@'localhost';

-- Criação do usuário employee 🧑‍💻
CREATE USER 'employee'@'localhost' IDENTIFIED BY 'senha_employee';

-- Concede permissão de SELECT na tabela employee ✅
GRANT SELECT ON company.employee TO 'employee'@'localhost';

-- Revoga permissões que o employee não deve ter (por segurança!) 🚫
REVOKE SELECT ON company.departament FROM 'employee'@'localhost';
REVOKE SELECT ON company.vw_empregados_por_departamento_localidade FROM 'employee'@'localhost';
REVOKE SELECT ON company.vw_departamentos_gerentes FROM 'employee'@'localhost';

FLUSH PRIVILEGES;
````


**Parte 2 – Criando gatilhos para cenário de e-commerce 🛒
Aqui a mágica acontece nos bastidores do seu e-commerce! ✨ Criamos gatilhos para cuidar dos dados:

**1. 🗑️ Trigger de remoção: before delete em usuarios 👋

Para nunca perdermos informações importantes! 💾
````sql
-- Certifique-se de estar no banco de dados correto
-- USE ecommerce;

DELIMITER //

CREATE TRIGGER before_delete_usuario
BEFORE DELETE ON usuarios
FOR EACH ROW
BEGIN
    -- Antes de excluir um usuário, insere seus dados na tabela de histórico 📜
    INSERT INTO historico_remocao_usuarios (id_usuario, nome_usuario, email_usuario, data_exclusao)
    VALUES (OLD.id_usuario, OLD.nome_usuario, OLD.email_usuario, NOW());
END //

DELIMITER ;

````

2. ⬆️ Trigger de atualização: before update em colaboradores 💰

Deixando tudo registrado quando um salário muda! ✍️
````sql
-- Certifique-se de estar no banco de dados correto
-- USE ecommerce;

DELIMITER //

CREATE TRIGGER before_update_salario_colaborador
BEFORE UPDATE ON colaboradores
FOR EACH ROW
BEGIN
    -- Verifica se o salário base foi alterado 🤔
    IF NEW.salario_base <> OLD.salario_base THEN
        -- Atualiza a data de atualização do salário 🗓️
        SET NEW.data_atualizacao_salario = NOW();
    END IF;
END //

DELIMITER ;

````


🎉 Finalizado o desafio! 🏆










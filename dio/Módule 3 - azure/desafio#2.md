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

-- Exemplos de chamadas da procedure:

-- Para inserir um novo aluno (isso exigiria uma lógica de inserção que não foi explicitamente pedida,
-- mas você pode adicionar um WHEN 4 para INSERT se precisar. Por ora, focamos em UPDATE e DELETE)
-- CALL ManipulaDados(4, 'alunos', NULL, 'Novo Aluno', 'Novo Curso');

-- Para atualizar um aluno no banco de dados 'universidade':
CALL ManipulaDados(2, 'alunos', 1, 'Nome Atualizado', 'Curso Atualizado');

-- Para deletar um produto no banco de dados 'e-commerce':
CALL ManipulaDados(3, 'produtos', 5, NULL, NULL);

-- Para tentar selecionar um aluno:
CALL ManipulaDados(1, 'alunos', 1, NULL, NULL);

-- Para tentar uma operação em uma tabela não suportada:
CALL ManipulaDados(2, 'outra_tabela', 1, 'Valor', 'Outro Valor');

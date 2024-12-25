![despesa-ifs-menu](https://github.com/user-attachments/assets/eb46b15e-aad3-498b-b9d7-c25c42530c55)


# Arquivos 📂

## 1. Criação do Banco de Dados e Tabelas (esquemaRelacional.sql) 🛠️
Este arquivo contém comandos SQL para criar o banco de dados ecommerce e suas tabelas principais, incluindo:

- **Tabela clients** 🧑‍🤝‍🧑: Armazena informações dos clientes, como nome, CPF e endereço.

- **Tabela product** 📦: Armazena informações dos produtos, como nome, categoria, classificação para crianças e avaliação.

- **Tabela orders** 🛒: Armazena informações dos pedidos, incluindo o cliente que fez o pedido, status e descrição do pedido.

- **Tabela payments** 💳: Armazena informações de pagamentos, incluindo tipo e limite disponível.

- **Tabela productStorage** 🏬: Armazena informações sobre a localização e quantidade do estoque de produtos.

- **Tabela supplier** 🚚: Armazena informações sobre os fornecedores, como nome social, CNPJ e contato.

- **Tabela seller** 🛍️: Armazena informações sobre os vendedores, incluindo nome social, CNPJ, CPF, localização e contato.

- **Tabelas de Relacionamento** 🔗: Incluem as tabelas productSeller, productOrder, storageLocation e productSupplier, que gerenciam os relacionamentos entre produtos, pedidos, estoques, fornecedores e vendedores.

## 2. Inserção de Dados e Consultas (scriptEcommerce.sql) 📊
Este arquivo contém comandos SQL para:

- **Inserção de Dados** 📥: Insere registros nas tabelas clients, product, orders, productStorage, supplier, seller e nas tabelas de relacionamento.

- **Consultas** 🔍: Executa consultas para selecionar dados das tabelas, como pedidos realizados por clientes, produtos em estoque e relações entre diferentes entidades do banco de dados.

![despesa-ifs-menu](https://github.com/user-attachments/assets/eb46b15e-aad3-498b-b9d7-c25c42530c55)



# Projeto de Banco de Dados para Oficina 🚗🔧

**Bem-vindo ao projeto de criação e implementação de um banco de dados para uma oficina! Este projeto envolve a transformação do esquema conceitual em um esquema lógico e sua implementação prática.**

## 1. Análise do Esquema Conceitual 📝
- Revisamos o esquema conceitual usando o modelo Entidade-Relacionamento (ER), incluindo todas as entidades e relacionamentos necessários para o contexto da oficina: Clientes, Veículos, Serviços, Funcionários e Peças.

## 2. Criação do Esquema Lógico 💻
- O esquema conceitual foi transformado em um esquema lógico, definindo a estrutura do banco de dados em termos de tabelas, colunas, tipos de dados e chaves. Abaixo estão as tabelas criadas:

### Tabela Clientes 🧑‍🤝‍🧑
- **ID_Cliente (INT, PRIMARY KEY)**: Identificador único para cada cliente.
- **Nome (VARCHAR(100))**: Nome completo do cliente.
- **Telefone (VARCHAR(15))**: Número de telefone do cliente.
- **Endereço (VARCHAR(255))**: Endereço do cliente.

### Tabela Veículos 🚗
- **ID_Veículo (INT, PRIMARY KEY)**: Identificador único para cada veículo.
- **Placa (VARCHAR(10))**: Placa do veículo.
- **Modelo (VARCHAR(50))**: Modelo do veículo.
- **Ano (INT)**: Ano de fabricação do veículo.
- **ID_Cliente (INT, FOREIGN KEY)**: Identificador do cliente proprietário do veículo.

### Tabela Serviços 🔧
- **ID_Serviço (INT, PRIMARY KEY)**: Identificador único para cada serviço.
- **Descrição (VARCHAR(255))**: Descrição detalhada do serviço.
- **Preço (DECIMAL)**: Preço do serviço.

### Tabela Funcionários 👷
- **ID_Funcionário (INT, PRIMARY KEY)**: Identificador único para cada funcionário.
- **Nome (VARCHAR(100))**: Nome completo do funcionário.
- **Função (VARCHAR(50))**: Função ou cargo do funcionário.
- **Salário (DECIMAL)**: Salário do funcionário.

### Tabela Peças 🛠️
- **ID_Peça (INT, PRIMARY KEY)**: Identificador único para cada peça.
- **Descrição (VARCHAR(255))**: Descrição da peça.
- **Quantidade (INT)**: Quantidade disponível no estoque.
- **Preço (DECIMAL)**: Preço de cada peça.

### Tabela Ordens de Serviço 📋
- **ID_Ordem (INT, PRIMARY KEY)**: Identificador único para cada ordem de serviço.
- **ID_Cliente (INT, FOREIGN KEY)**: Identificador do cliente que solicitou o serviço.
- **ID_Veículo (INT, FOREIGN KEY)**: Identificador do veículo que será reparado.
- **ID_Funcionário (INT, FOREIGN KEY)**: Identificador do funcionário responsável pelo serviço.
- **Data (DATE)**: Data de criação da ordem de serviço.
- **Status (VARCHAR(50))**: Status atual da ordem de serviço (ex: "Em andamento", "Concluído").

### Tabela Peças_Ordem 🔩
- **ID_Ordem (INT, FOREIGN KEY)**: Identificador da ordem de serviço.
- **ID_Peça (INT, FOREIGN KEY)**: Identificador da peça utilizada.
- **Quantidade (INT)**: Quantidade de peças utilizadas na ordem de serviço.

### Tabela Serviços_Ordem 🏷️
- **ID_Ordem (INT, FOREIGN KEY)**: Identificador da ordem de serviço.
- **ID_Serviço (INT, FOREIGN KEY)**: Identificador do serviço prestado.
- **Preço (DECIMAL)**: Preço do serviço prestado.

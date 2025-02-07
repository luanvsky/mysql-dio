# 📊 Descrição do Projeto

Utilizaremos a tabela única de **Financial_Sample** para criar as tabelas dimensão e fato do nosso modelo baseado no esquema estrela para acompanhar nossas despesas pessoais. 💸

O processo consiste na criação das tabelas com base na tabela original. A partir da cópia, serão selecionadas as colunas que irão compor a visão da nova tabela. Sendo assim, a partir da tabela principal serão criadas as seguintes tabelas:

- **Financials_origem** (modo oculto – backup)
- **D_Categorias** (ID_categoria, Categoria, Descrição)
- **D_Produtos** (ID_produto, Produto, Categoria, Preço Unitário)
- **D_Vendedores** (ID_vendedor, Nome_vendedor)
- **D_Data** – Criada por DAX com `calendar()`
- **F_Despesas** (ID_despesa, ID_Produto, ID_vendedor, Quantidade, Total_Compra, Faixa_Desconto, Categoria, Data) 

## 📅 Etapas do Projeto

### 1. Criação de Tabelas
A partir da tabela original, criar tabelas de dimensão e fato conforme especificado.

### 2. Reorganização e Condicionais
Reorganizar colunas e construir novas colunas a partir de condicionais, como um Índice de Produtos.

### 3. Salvamento e Submissão
- Salvar o projeto como `.pbix`
- Salvar uma imagem do esquema em estrela
- Escrever no `README` o processo de construção do diagrama, incluindo etapas, funcionalidades e funções DAX utilizadas.

## 📋 Exemplo de Tabelas Reorganizadas

### D_Categorias:
| ID_categoria | Categoria     | Descrição          |
|--------------|---------------|--------------------|
| 1            | Alimentação   | Despesas com comida|
| 2            | Transporte    | Despesas com deslocamento |
| 3            | Educação      | Despesas com estudos|

### D_Produtos:
| ID_produto | Produto       | Categoria        | Preço Unitário |
|------------|---------------|------------------|----------------|
| 1          | Café          | Alimentação      | $3             |
| 2          | Passagem de Ônibus | Transporte | $2             |
| 3          | Livro         | Educação         | $10            |

### D_Vendedores:
| ID_vendedor | Nome_vendedor |
|-------------|---------------|
| 1           | Supermercado  |
| 2           | Concessionária|
| 3           | Livraria      |

### F_Despesas:

"ID_despesa","ID_produto","ID_vendedor","Quantidade","Total_Compra","Faixa_Desconto","Categoria","Data"
"1","1","1","50","$150","Nenhum","Alimentação","2025-01-01"
"2","2","2","20","40","Nenhum","Transporte","2025-01-10"
"3","3","3","5","$50","Nenhum","Educação","2025-01-15"

Com esse projeto, você conseguirá acompanhar suas despesas pessoais de forma detalhada e organizada. 🚀 

Qualquer dúvida ou se precisar de ajuda em alguma etapa, só dar um alô! 😉



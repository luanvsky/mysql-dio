# Descrição do Projeto - e-commerce

Este projeto tem como objetivo desenvolver um esquema de banco de dados refinado para gerenciar clientes, pagamentos e entregas de uma plataforma de e-commerce. O projeto será avaliado em um futuro desafio de projeto.

## Estrutura do Esquema

- Cliente:


id_cliente: Identificador único do cliente.

nome: Nome do cliente.

tipo_cliente: Tipo do cliente, que pode ser 'PJ' ou 'PF'.

informacoes_PJ: Informações específicas para clientes PJ.

informacoes_PF: Informações específicas para clientes PF.


- Pagamento:

id_pagamento: Identificador único do pagamento.

id_cliente: Identificador do cliente (chave estrangeira).

tipo_pagamento: Tipo de pagamento (e.g., cartão de crédito, boleto, etc.).

detalhes_pagamento: Detalhes específicos do pagamento.

- Entrega:

id_entrega: Identificador único da entrega.

id_cliente: Identificador do cliente (chave estrangeira).

status: Status atual da entrega.

codigo_rastreio: Código de rastreamento da entrega.


**Considerações Finais**

Este projeto visa melhorar a gestão de informações de clientes, pagamentos e entregas, fornecendo uma estrutura clara e funcional para futuras avaliações e implementações.

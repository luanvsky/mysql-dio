-- criação do banco de dados para o cenário de E-commerce
create database ecommerce;
use ecommerce;

-- criar tablea cliente
create table cliente(
		idCliente int auto_increment primary key,
        Pname varchar(10),
        Minit char(3),
        Lname varchar(20),
        CPF char(11) not null,
        Adress varchar(30),
        constraint unique_cpf_cliente unique (CPF)
);

-- criar tablea produto
create table produto(
		idProduct int auto_increment primary key,
        Pname varchar(10),
        Classification bool default false,
        Category enum('eletronic', 'cozinha', 'construção'),
        avaliação float default 0,
        size varchar(30),
        constraint unique_cpf_cliente unique (CPF)
);

create table payment(
	idClient int,
    id_payment int,
    typePayment enum('boleto', 'cartão', 'dois cartões')
    limitavailable float,
    primary key(idClient, id_payment),
);

-- criar tablea pedido
create table order(
		idOrder int auto_increment primary key,
        idOrder int,
        orderStatus enum('Cancelado', 'Confirmado', 'Em processamento',
        orderDescription varchar(255),
        sendValue float default 10,
        paymentCash bool default false,
        constraint fk_order_client foreign key (idOrderClient) references clients()
       );
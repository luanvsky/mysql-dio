# Criação do Esquema 💻🔍

``create schema if not exists azure_company;
use azure_company;``

O código cria um esquema chamado "azure_company" se ele ainda não existir e usa esse esquema 🏢.

## Verificação de Restrições 📊⚙️
``select * from information_schema.table_constraints
    where constraint_schema = 'azure_company';``

Essa consulta verifica todas as restrições de tabela dentro do esquema "azure_company" 🕵️‍♂️.

## Criação da Tabela "employee" 👷‍♂️👷‍♀️

``CREATE TABLE employee(
    Fname varchar(15) not null,
    Minit char,
    Lname varchar(15) not null,
    Ssn char(9) not null,
    Bdate date,
    Address varchar(30),
    Sex char,
    Salary decimal(10,2),
    Super_ssn char(9),
    Dno int not null,
    constraint chk_salary_employee check (Salary > 2000.0),
    constraint pk_employee primary key (Ssn)
);
``

Cria uma tabela "employee" com várias colunas e algumas restrições 📋📊:

chk_salary_employee: Verifica se o salário é maior que 2000 💰.

pk_employee: Define a chave primária como o número do seguro social (Ssn) 🔑.

## Adição de Chave Estrangeira 🔗

``alter table employee 
    add constraint fk_employee 
    foreign key (Super_ssn) references employee(Ssn)
    on delete set null
    on update cascade;``


Adiciona uma restrição de chave estrangeira para a coluna "Super_ssn", referenciando a própria tabela "employee" 🧩.

## Modificação da Coluna 📝

``alter table employee modify Dno int not null default 1;
``
Modifica a coluna "Dno" para que não permita valores nulos e tenha um valor padrão de 1 🛠️.

## Criação da Tabela "departament" 🏢

``create table departament(
    Dname varchar(15) not null,
    Dnumber int not null,
    Mgr_ssn char(9) not null,
    Mgr_start_date date,
    Dept_create_date date,
    constraint chk_date_dept check (Dept_create_date < Mgr_start_date),
    constraint pk_dept primary key (Dnumber),
    constraint unique_name_dept unique (Dname),
    foreign key (Mgr_ssn) references employee(Ssn)
);
``
Cria uma tabela "departament" com várias colunas e restrições 📋🔗:

chk_date_dept: Verifica se a data de criação do departamento é anterior à data de início do gerente 📅.

pk_dept: Define a chave primária como o número do departamento (Dnumber) 🔑.

unique_name_dept: Garante que o nome do departamento seja único 📛.

foreign key (Mgr_ssn): Cria uma chave estrangeira referenciando a tabela "employee" 🧩.

## Modificação de Restrições 🔄

``alter table departament drop departament_ibfk_1;
alter table departament 
    add constraint fk_dept foreign key (Mgr_ssn) references employee(Ssn)
    on update cascade;
``

Remove uma restrição existente e adiciona uma nova chave estrangeira na tabela "departament" ⚙️.

## Criação da Tabela "dept_locations" 🌍

``create table dept_locations(
    Dnumber int not null,
    Dlocation varchar(15) not null,
    constraint pk_dept_locations primary key (Dnumber, Dlocation),
    constraint fk_dept_locations foreign key (Dnumber) references departament (Dnumber)
);
``
Cria uma tabela "dept_locations" que relaciona locais aos números de departamentos com chaves primárias compostas e uma chave estrangeira 🗺️.

## Modificação de Chave Estrangeira 🔄

``alter table dept_locations drop fk_dept_locations;
alter table dept_locations 
    add constraint fk_dept_locations foreign key (Dnumber) references departament(Dnumber)
    on delete cascade
    on update cascade;
``
Remove e readiciona a chave estrangeira com novas ações ao excluir ou atualizar 🛠️.
## Criação da Tabela "project" 📈
``create table project(
    Pname varchar(15) not null,
    Pnumber int not null,
    Plocation varchar(15),
    Dnum int not null,
    primary key (Pnumber),
    constraint unique_project unique (Pname),
    constraint fk_project foreign key (Dnum) references departament(Dnumber)
);
``
Cria uma tabela "project" para armazenar informações de projetos, com restrições de unicidade e chaves estrangeiras 📋🔗.
## Criação da Tabela "works_on" 🧑‍💻🛠️

``create table works_on(
    Essn char(9) not null,
    Pno int not null,
    Hours decimal(3,1) not null,
    primary key (Essn, Pno),
    constraint fk_employee_works_on foreign key (Essn) references employee(Ssn),
    constraint fk_project_works_on foreign key (Pno) references project(Pnumber)
);
``
Cria uma tabela "works_on" para registrar quais funcionários trabalham em quais projetos, com chaves estrangeiras referenciando as tabelas "employee" e "project" 🗂️🔗.
## Criação da Tabela "dependent" 👨‍👩‍👧‍👦

drop table dependent;

``
create table dependent(
    Essn char(9) not null,
    Dependent_name varchar(15) not null,
    Sex char,
    Bdate date,
    Relationship varchar(8),
    primary key (Essn, Dependent_name),
    constraint fk_dependent foreign key (Essn) references employee(Ssn)
);
``
Remove a tabela "dependent" se existir e recria-a para registrar dependentes dos funcionários, com chaves primárias compostas e uma chave estrangeira 👪🔗.
## Mostra Tabelas e Descrição 📋
``show tables;
desc dependent;
``
Mostra todas as tabelas do esquema atual e descreve a estrutura da tabela "dependent" 🗃️🔍.




























    

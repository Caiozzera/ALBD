create database if not exists exercicio3; 

drop database if exists exemplo1;

use exercicio3;

create table agencias(
	id int unsigned unique not null primary key,
    nome varchar(150) not null,
    endereco varchar(200) not null 
    
);
drop table clientes ;

create table clientes(
	id_ int unsigned unique not null primary key,
    id_agencia int unsigned unique not null, 
    nome varchar(100) not null,
	endereço varchar(200)not null ,
    cpf varchar (11) not null,
    data_adesao datetime not null,
    telefone varchar(20) not null,
    foreign key (id_agencia) references agencias(id)
    on delete cascade on update no action
);

create table funcionario (
	id_ int unsigned unique not null primary key,
    id_agencia int unsigned unique not null,
     nome varchar(150) not null,
     cpf varchar(15) not null ,
     endereco varchar(100),
     salario decimal(11,2) not null,
     foreign key (id_agencia) references agencias(id)
     on delete cascade on update no action
);

create table contas(
	id_ int unsigned unique not null primary key,
    id_cliente int unsigned unique not null,
    tipo char(1) not null,
	data_abertura datetime not null, 
    saldo decimal(8,2) not null,
    limite decimal(8,2) not null,
	foreign key (id_cliente) references clientes(id_)
     on delete cascade on update no action
);

create table operacao(
	id  int unsigned unique not null primary key,
    id_conta int  unsigned unique not null,
    tipo char(1) not null,
    data_operacao datetime not null, 
    valor decimal (11,2) not null, 
    foreign key (id_conta) references contas(id_)
);

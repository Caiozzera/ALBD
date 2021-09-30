create database if not exists computadores;
use computadores;
create table cliente(
	id int unsigned unique not null primary key,
    id_movimentacao int unsigned unique not null, 
	nome varchar (33) not null,
    cpf varchar (11) not null,
    data_adesao datetime not null, 
	telefone varchar(45) not null,
    endereco varchar(45),
    foreign key (id_movimentacao) references movimentacao(id)
    on delete cascade on update no action
);
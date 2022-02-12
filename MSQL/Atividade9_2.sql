create database if not exists Aula9_atividade2;

use Aula9_atividade2;

create table pais(
	id int unsigned unique not null primary key,
    nome varchar (100) not null,
    idioma char (5) not null
);

create table estado(
	id int unsigned unique not null primary key,
	id_pais int unsigned not null,
	nome varchar (100) not null,
	foreign key (id_pais) references estados(id)
);

create table cidade(
	id int unsigned unique not null primary key,
    id_estados int unsigned not null,
    nome varchar (150) not null,
	foreign key (id_estados) references cidade(id)
);

create table cliente(
	id int unsigned unique not null primary key ,
    id_cidade int unsigned not null,
    razao_social varchar(100) not null,
    nome_fantasia varchar(100) not null, 
    cnpj char(14) not null,
    endereco varchar(100) not null,
    cep char(8) not null,
    telefone char(14) not null, 
    email varchar(100) not null,
    situacao char(1) not null,
    foreign key (id_cidade) references cliente(id)
);

create table venda(
	id int unsigned unique not null primary key,
    id_vendedor int unsigned  not null,
	id_clientes int unsigned  not null,
    data_venda datetime not null,
    situacao char(1),
    foreign key (id_vendedor) references venda(id),
	foreign key (id_clientes) references venda(id)
);

create table vendedor(
	id int unsigned unique not null primary key,
    nome varchar (100) not null,
   telefone char(14) not null,
   email varchar (100) not null,
   endereco varchar (100) not null
);

create table item_venda(
	id int unsigned unique not null primary key,
    id_venda int unsigned  not null,
	id_produto int unsigned  not null,
    id_unidade_medida  int unsigned  not null,
    preco_unitario decimal (11,2),
    quantidade decimal (11,2),
    total decimal (11,2),
    foreign key (id_venda) references item_venda(id),
    foreign key (id_produto) references item_venda(id),
	foreign key (id_unidade_medida) references item_venda(id)
);

create table unidade_medida(
	id int unsigned unique not null primary key,
	sigla char(2) not null,
    descricao varchar (100) not null
);

create table produto(
	id  int unsigned unique not null primary key,
    id_drupo_produto  int unsigned  not null,
	descricao varchar (100) not null,
    custo decimal (11,2) not null,
    saldo_estoque decimal(11,2) not null,
    situacao char (1) not null,
    foreign key (id_drupo_produto) references produto(id)
);

create table grupo_produto(
	id  int unsigned unique not null primary key,
    descricao varchar (100)
);

#Valor total vendido em Setembro;
select sum(item_venda.total) as total_vendido 
from item_venda
inner join venda on venda.id = item_venda.id_venda
where venda.data_venda <= '2021/09/30' and venda.data_venda >= '2021/09/01'

#Item mais vendido em Setembro;
select produto.descricao as produto, sum(item_venda.quantidade) as quantidade, venda.data_venda from produto
inner join item_venda on item_venda.id_produto = produto.id
inner join venda on venda.id = item_venda.id_venda
where venda.data_venda >= '2021/09/01' and venda.data_venda <= '2021/09/30'
group by produto.descricao
order by sum(item_venda.quantidade) desc
limit 1

#Total de vendas por cidade;
select sum(item_venda.total) as total_vendido, cidade.nome as cidade from item_venda
inner join venda on venda.id = item_venda.id_venda
inner join cliente on cliente.id = venda.id_clientes
inner join cidade on cidade.id = cliente.id_cidade
group by cidade.nome








